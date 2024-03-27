
from pyramid.response import Response
from operator import itemgetter

from pyramid.httpexceptions import HTTPFound
from pyramid.security import (
    remember,
    forget,
    )

from pyramid.view import (
    view_config,
    view_defaults,
    forbidden_view_config
    )

from .security import (
    USERS,
      check_password
)

from .classes import Person, TreeCell


import json 

import sys
sys.path.append('/usr/local/lib/python3.9/dist-packages')


# sys.path.append('/usr/local/lib64/python3.7/site-packages')
# import mysql.connector

import mysql.connector as connector 

# import pymysql
 
# from mysql.connector 
# import pymysql
# pymysql.install_as_MySQLdb()
# import MySQLdb
        
@view_defaults(renderer='kw03:templates/homePage.mako')
class TutorialViews:
    def __init__(self, request):
        self.request = request
        self.logged_in = request.authenticated_userid    

        
    @view_config(route_name='home')
    def home(self):
        request = self.request
        items = [dict(name="kinwheel", user=request.authenticated_userid, 
                      root_url = request.route_url('home'))]
        return {'items': items}
       

    @view_config(route_name='userlogin', renderer='kw03:templates/userlogin.mako')
    @forbidden_view_config(renderer='kw03:templates/userlogin.mako')
    def login(self):
        request = self.request
        login_url = request.route_url('userlogin')
        # print ('login url: ' + login_url)
        referrer = request.url
        if referrer == login_url:
            referrer = '/'  # never use login form itself as came_from
        came_from = request.params.get('came_from', referrer)
        message = ''
        login = ''
        password = ''
        if 'form.submitted' in request.params:
            login = request.params['login']
            password = request.params['password']
            print ('pwd ' + password)
            check2 = USERS.get(login)
            print ('check2: ' + check2)
            if check2 is None:
	       # check2='000'
                return HTTPFound()
	    # if check_password(password, USERS.get(login)):
            print ('003')
            if check_password(password, check2):
                print ('004')
                headers = remember(request, login)
                # return HTTPFound(location=came_from,
				 # headers=headers)
                # return HTTPFound(location='http://vagrantvectors.com/viewTrees', headers=headers)
                destUrl = request.route_url ('viewTrees')
                return HTTPFound(location=destUrl, headers=headers)
                print ('log in complete')
                
            message = 'Failed login'

        return dict(
            name='Login',
            message=message,
            url=request.application_url + '/userlogin',
            came_from=came_from,
            login=login,
            password=password,
        )

    @view_config(route_name='logout')
    def logout(self):
        request = self.request
        headers = forget(request)
        url = request.route_url('home')
        return HTTPFound(location=url,
                         headers=headers)

@view_config(route_name='viewTrees', renderer='kw03:templates/viewTrees.mako', permission='edit')
def viewTrees(request):

# , permission='edit'
    
    # me = Person('John Snow')
    # print(me.get_name())

    strUserID = request.authenticated_userid
    # strUserID = 'resharpe@gmail.com'
    # strSQL_final = "call getTrees3('" + strUserID +  "' )"
    strSQL_final = "call treesGet('" + strUserID +  "' )"

    print (strSQL_final)
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    
    cursor.execute(strSQL_final, multi=True)    

    items = [dict(treeID = row[0], treeName=row[1], treeDescrip=row[2], dateCreated=row[3], dateUpdated=row[4], status=row[5], userID=strUserID, peopleInTreeCount=row[7] ) for row in cursor.fetchall()]
            
    # get albums list
    
    # start comment
    '''
    strCreatedBy = 'resharpe@gmail.com'
    strSQL_final = "call albumsGetList('" + strCreatedBy +  "' )"
    
    cn2 = getSQLConn('gen30') 
    cursor2 = cn2.cursor()
    
    cursor2.execute(strSQL_final)    

    itemsAlbums = [dict(albumID = row[0], albumTitle=row[1], albumDescrip=row[2], albumStatus=row[3], albumPersonID=row[4], albumTreeID=row[5], albumDateCreated = row[6], albumDateUpdated = row[7], albumCreatedBy = row[8]) for row in cursor2.fetchall()]
    '''
    # end comment 

    # return {'items': items, 'itemsAlbums': itemsAlbums}
    return {'items': items}

@view_config(route_name='treeViewDetermine', renderer='kw03:templates/treeViewDetermine.mako')
def treeViewDetermine(request):
    
    try:
        ppid = request.GET.getall('pid')
        strPersonID =  ppid[0]                  
    except: 
        strPersonID = "0"

    try:
        tid = request.GET.getall('tid')
        strTid =  tid[0]                  
    except: 
        strTid = "0"
    
    try:
        rootID = request.GET.getall('rid')
        strRootID =  rootID[0]                  
    except: 
        strRootID = "0"
    
    try:
        backToRoot = request.GET.getall('br')
        strBackToRoot =  backToRoot[0]                  
    except: 
        strBackToRoot = "0"
   
    # open a database connection
    cn2 = getSQLConn('gen30') 
    cursor2 = cn2.cursor()

    #if no tree ID qs param sent, get the id of the tree using the persob id 
    if strTid == "0": 
        
        strSQLGetTid = "CALL treeIDGetFromPersonID(" + strPersonID + ")"
        cursor2.execute(strSQLGetTid)    
        itemsTiD = [dict(treeID=row[0]) for row in cursor2.fetchall()]

        for item in itemsPiD: 
            strTid = str(item['treeID'])

    #if no person ID param sent, get the root id of the tree using the tree id 
    if strPersonID == "0": 
        strSQLGetPid = "CALL treeRootIDGet(" + strTid + ")"
        cursor2.execute(strSQLGetPid)    
        itemsPiD = [dict(personID=row[0]) for row in cursor2.fetchall()]

        for item in itemsPiD: 
            strPersonID = str(item['personID'])
        
    # get count of gens in Tree
    strSQL_final = "CALL treeGensCount(" + strTid + ")"

    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    cursor.execute(strSQL_final)    

    itemsGenCount = [dict(numGens=row[0]) for row in cursor.fetchall()]
    
    return {'items': itemsGenCount}

@view_config(route_name='smallTreeView', renderer='kw03:templates/smallTree.mako')
def smallTreeView(request):
    
    try:
        ppid = request.GET.getall('pid')
        strPersonID =  ppid[0]                  
    except: 
        strPersonID = "0"

    try:
        tid = request.GET.getall('tid')
        strTid =  tid[0]                  
    except: 
        strTid = "0"
    
    try:
        rootID = request.GET.getall('rid')
        strRootID =  rootID[0]                  
    except: 
        strRootID = "0"
    
    try:
        backToRoot = request.GET.getall('br')
        strBackToRoot =  backToRoot[0]                  
    except: 
        strBackToRoot = "0"
   
    # open a database connection
    cn2 = getSQLConn('gen30') 
    cursor2 = cn2.cursor()

    #if no person ID param sent, get the root id of the tree using the tree id 
    if strPersonID == "0": 
        strSQLGetPid = "CALL treeRootIDGet(" + strTid + ")"
        cursor2.execute(strSQLGetPid)    
        itemsPiD = [dict(personID=row[0]) for row in cursor2.fetchall()]

        for item in itemsPiD: 
            strPersonID = str(item['personID'])
        
    # add a param for root id to get name and persist it on the tree page 
    # strSQL_final = "CALL getPersonforUpdate2(" + strPersonID + ")"
    strSQL_final = "CALL getPersonforUpdate2(" + strPersonID + "," + strRootID + ")"

    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    cursor.execute(strSQL_final)    

    varRootUrl = request.application_url

    items = [dict(tid=strTid, personID=row[0], authUser=request.authenticated_userid, firstName=row[1], middleName=row[2], lastName=row[3], nee=row[4], dobYear=row[5], dob=row[6],  dobExactOrEst=row[7], dodYear=row[8], dod=row[9], dodExactOrEst=row[10], placeOfBirth=row[11], placeOfDeath=row[12], gender=row[13], genderAtBirth=row[14], dateCreated=row[15], dateUpdated=row[16], createdBy=row[17], updatedBy=row[18], rootID=strRootID, status=row[19], rootPersonName=row[20], backToRootID = strBackToRoot, rootUrl = varRootUrl) for row in cursor.fetchall()]

    # , rootUrl=varRootUrl
    # request.route_url('home')

    # items = [dict(personID = strPersonID, treeID = strTid)]

    return {'items': items}


@view_config(route_name='tallWideTreeView', renderer='kw03:templates/tallWideTree.mako')
def tallWideTreeView(request):
    
    try:
        ppid = request.GET.getall('pid')
        strPersonID =  ppid[0]                  
    except: 
        strPersonID = "0"

    try:
        tid = request.GET.getall('tid')
        strTid =  tid[0]                  
    except: 
        strTid = "0"
    
    try:
        rootID = request.GET.getall('rid')
        strRootID =  rootID[0]                  
    except: 
        strRootID = "0"
    
    try:
        backToRoot = request.GET.getall('br')
        strBackToRoot =  backToRoot[0]                  
    except: 
        strBackToRoot = "0"
   
    # open a database connection
    cn2 = getSQLConn('gen30') 
    cursor2 = cn2.cursor()

    #if no person ID param sent, get the root id of the tree using the tree id 
    if strPersonID == "0": 
        strSQLGetPid = "CALL treeRootIDGet(" + strTid + ")"
        cursor2.execute(strSQLGetPid)    
        itemsPiD = [dict(personID=row[0]) for row in cursor2.fetchall()]

        for item in itemsPiD: 
            strPersonID = str(item['personID'])
        
    # add a param for root id to get name and persist it on the tree page 
    # strSQL_final = "CALL getPersonforUpdate2(" + strPersonID + ")"
    strSQL_final = "CALL getPersonforUpdate2(" + strPersonID + "," + strRootID + ")"

    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    cursor.execute(strSQL_final)    

    varRootUrl = request.application_url

    items = [dict(tid=strTid, personID=row[0], authUser=request.authenticated_userid, firstName=row[1], middleName=row[2], lastName=row[3], nee=row[4], dobYear=row[5], dob=row[6],  dobExactOrEst=row[7], dodYear=row[8], dod=row[9], dodExactOrEst=row[10], placeOfBirth=row[11], placeOfDeath=row[12], gender=row[13], genderAtBirth=row[14], dateCreated=row[15], dateUpdated=row[16], createdBy=row[17], updatedBy=row[18], rootID=strRootID, status=row[19], rootPersonName=row[20], backToRootID = strBackToRoot, rootUrl = varRootUrl) for row in cursor.fetchall()]

    # , rootUrl=varRootUrl
    # request.route_url('home')

    # items = [dict(personID = strPersonID, treeID = strTid)]

    return {'items': items}

@view_config(route_name='tallWideTreeViewGetJson', renderer='json')
def tallWideTreeViewGetJson(request):
    
        person = Person()

        strID = ""
        strSort = ""
        strTopMenu = ""
        strPersonId = ""
        strStyle = ""
        strDeviceType = ""
    
        # request = self.request

        try:
                pPersId = request.GET.getall('idp')
                strPersonId =  pPersId[0]                   
        except: 
                strPersonId =  "0"  

        try:
                tid = request.GET.getall('tid')
                strTreeID =  tid[0]                   
        except: 
                strTreeID =  "0"  

        try:
                pmb = request.GET.getall('mb')
                strDeviceType =  pmb[0]                 
        except: 
                strDeviceType =  "unknown"              

        if strDeviceType == "mb":
                strDeviceType = "Mobile"
        else: 
                strDeviceType = "notMobile"
    
    # qsp to toggle top menu listing on and off
        try:
                ptm = request.GET.getall('tm')
                strTopMenu  =  ptm[0]                   
        except: 
                strTopMenu =  "no"              
    
        try:
                psort = request.GET.getall('srt')
                strSort =  psort[0]                 
        except: 
                strSort =  ""               

        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'nodes', 0 " + ")"
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'nodes', 0 " + ")"
        # getPersonProfile72   getPersonProfilePedigree

        cn = getSQLConn('gen30') 
        cursor = cn.cursor()
 
        cursor.execute(strSQL_final)    
       
        items =  [dict(rowNum = row[0], rootFamilyNum=row[1], familyID =row[2], colsNeeded=row[3], siblingOrder=row[4],  matrixNode=row[5],  personID=row[6], motherID=row[7], fatherID=row[8], colOrder=row[9], firstName=row[10],lastName=row[11],dobYear=row[12], dodYear=row[13], relationType=row[14],relationID=row[15], blood=row[16], spouseCount=row[17], spouseNumber=row[18], nonPedParentSpouseNumber=row[19], childrenCount=row[20], rootFlag = row[22], authUser=request.authenticated_userid, treeID=strTreeID ) for row in cursor.fetchall()]

        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'nodes', 1 " + ")"

        cn = getSQLConn('gen30') 
        cursor = cn.cursor()        
        
        cursor.execute(strSQL_final)    
        
        items2 = [dict(rowNum = row[0], rootFamilyNum=row[1], familyID =row[2], colsNeeded=row[3], siblingOrder=row[4],  matrixNode=row[5],  personID=row[6], motherID=row[7], fatherID=row[8], colOrder=row[9], firstName=row[10],lastName=row[11],dobYear=row[12], dodYear=row[13], relationType=row[14],relationID=row[15], blood=row[16], spouseCount=row[17], spouseNumber=row[18], nonPedParentSpouseNumber=row[19], childrenCount=row[20], rootFlag = row[22], authUser=request.authenticated_userid, treeID=strTreeID ) for row in cursor.fetchall()]

        # jsonRelatives = json.dumps(items)
        
        # jsonPeople  = getJsonForNodesFromDictC ('nodes', items, items2, str(request.authenticated_userid))
        
        # jsonStrings = getJsonForNodesFromDictC ('nodes', items, items2, str(request.authenticated_userid))
        jsonStrings = getJsonForTallTree ('nodes', items, items2, str(request.authenticated_userid))
        
        jsonPeople = jsonStrings[0] 
        jsonChildren = jsonStrings[1] 

        jsonPeople2 = ' { "chart": [ ' + jsonPeople  + ' ] '       
        # jsonPeople2 = " { 'chart': [ " + jsonPeople  + " ] "       
        
        # get spouses data
        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'spouses', 2 " + ")"
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'spouses', 2 " + ")"
        # getPersonProfile72  getPersonProfilePedigree
                
        print (strSQL_final)
        
        cn = getSQLConn('gen30') 
        cursor = cn.cursor()        
        
        cursor.execute(strSQL_final)    
  
        items = [dict(relation_type = row[0], r01_ID=row[1], firstNameSource=row[2], 
        authUser=request.authenticated_userid, lastNameSource=row[3], r02_ID=row[4], firstNameTarget = row[5], lastNameTarget = row[6]) for row in
        cursor.fetchall()]

        jsonSpouses  = getJsonForRelationsFromDict ('spouses', items)
        jsonSpouses  = ", " + jsonSpouses
      
        # get siblings  data 
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'non-spouses', 3 " + ")"
        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'non-spouses', 3 " + ")"
        # getPersonProfile72  getPersonProfilePedigree    
        # 
        print (strSQL_final)  
        
        cn = getSQLConn('gen30') 
        cursor = cn.cursor()        
	        
        cursor.execute(strSQL_final)    
        
        items = [dict(relation_type = row[0], r01_ID=row[1], firstNameSource=row[2], 
        authUser=request.authenticated_userid,
        lastNameSource=row[3], r02_ID=row[4], firstNameTarget = row[5], lastNameTarget = row[6]) for row in
        cursor.fetchall()]
        
        jsonNonSpouses  = getJsonForRelationsFromDict ('nonSpouses', items)
                
        # get data that enables rendering of connecting lines between ancestors  
        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'ancestors', 5 " + ")"
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'ancestors', 5 " + ")"
        print (strSQL_final)  

        cn = getSQLConn('gen30') 

        cursor = cn.cursor()        
            
        cursor.execute(strSQL_final)    
        
        items = [dict(relation_type = row[0], r01_ID=row[1], firstNameSource=row[2], 
        authUser=request.authenticated_userid,
        lastNameSource=row[3], r02_ID=row[4], firstNameTarget = row[5], lastNameTarget = row[6]) for row in
        cursor.fetchall()]
        
        jsonAncestors  = getJsonForRelationsFromDict ('ancestors', items)
        
        # assemble into final full json string 
        jsonNonSpouses  = ", " + jsonNonSpouses

        # jsonFull = jsonPeople2 + jsonSpouses +  jsonNonSpouses + '}'
                
        jsonChildren = ', ' + jsonChildren
        
        jsonAncestors = ', ' + jsonAncestors
        
        jsonFull = jsonPeople2 + jsonSpouses +  jsonNonSpouses + jsonChildren + jsonAncestors + '}'
        
        resp = Response ( jsonFull )                
    
        resp.headerlist.append(('Access-Control-Allow-Origin', '*')) #Add the access control
        print (" END  END  END  ")
    
        return resp



@view_config(route_name='personProfileViewC', renderer='json')
def personProfileViewC(request):
    
        person = Person()

        strID = ""
        strSort = ""
        strTopMenu = ""
        strPersonId = ""
        strStyle = ""
        strDeviceType = ""
    
        # request = self.request

        try:
                pPersId = request.GET.getall('idp')
                strPersonId =  pPersId[0]                   
        except: 
                strPersonId =  "0"  

        try:
                tid = request.GET.getall('tid')
                strTreeID =  tid[0]                   
        except: 
                strTreeID =  "0"  

        try:
                pmb = request.GET.getall('mb')
                strDeviceType =  pmb[0]                 
        except: 
                strDeviceType =  "unknown"              

        if strDeviceType == "mb":
                strDeviceType = "Mobile"
        else: 
                strDeviceType = "notMobile"
    
    # qsp to toggle top menu listing on and off
        try:
                ptm = request.GET.getall('tm')
                strTopMenu  =  ptm[0]                   
        except: 
                strTopMenu =  "no"              
    
        try:
                psort = request.GET.getall('srt')
                strSort =  psort[0]                 
        except: 
                strSort =  ""               

        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'nodes', 0 " + ")"
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'nodes', 0 " + ")"
        # getPersonProfile72   getPersonProfilePedigree

        cn = getSQLConn('gen30') 
        cursor = cn.cursor()
 
        cursor.execute(strSQL_final)    
       
        items =  [dict(rowNum = row[0], rootFamilyNum=row[1], familyID =row[2], colsNeeded=row[3], siblingOrder=row[4],  matrixNode=row[5],  personID=row[6], motherID=row[7], fatherID=row[8], colOrder=row[9], firstName=row[10],lastName=row[11],dobYear=row[12], dodYear=row[13], relationType=row[14],relationID=row[15], blood=row[16], spouseCount=row[17], spouseNumber=row[18], nonPedParentSpouseNumber=row[19], childrenCount=row[20], rootFlag = row[22], authUser=request.authenticated_userid, treeID=strTreeID ) for row in cursor.fetchall()]

        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'nodes', 1 " + ")"

        cn = getSQLConn('gen30') 
        cursor = cn.cursor()        
        
        cursor.execute(strSQL_final)    
        
        items2 = [dict(rowNum = row[0], rootFamilyNum=row[1], familyID =row[2], colsNeeded=row[3], siblingOrder=row[4],  matrixNode=row[5],  personID=row[6], motherID=row[7], fatherID=row[8], colOrder=row[9], firstName=row[10],lastName=row[11],dobYear=row[12], dodYear=row[13], relationType=row[14],relationID=row[15], blood=row[16], spouseCount=row[17], spouseNumber=row[18], nonPedParentSpouseNumber=row[19], childrenCount=row[20], rootFlag = row[22], authUser=request.authenticated_userid, treeID=strTreeID ) for row in cursor.fetchall()]

        # jsonRelatives = json.dumps(items)
        
        # jsonPeople  = getJsonForNodesFromDictC ('nodes', items, items2, str(request.authenticated_userid))
        
        jsonStrings = getJsonForNodesFromDictC ('nodes', items, items2, str(request.authenticated_userid))
             
        jsonPeople = jsonStrings[0] 
        jsonChildren = jsonStrings[1] 

        jsonPeople2 = ' { "chart": [ ' + jsonPeople  + ' ] '       
        
        # get spouses data
        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'spouses', 2 " + ")"
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'spouses', 2 " + ")"
        # getPersonProfile72  getPersonProfilePedigree
                
        print (strSQL_final)
        
        cn = getSQLConn('gen30') 
        cursor = cn.cursor()        
        
        cursor.execute(strSQL_final)    
  
        items = [dict(relation_type = row[0], r01_ID=row[1], firstNameSource=row[2], 
        authUser=request.authenticated_userid, lastNameSource=row[3], r02_ID=row[4], firstNameTarget = row[5], lastNameTarget = row[6]) for row in
        cursor.fetchall()]

        jsonSpouses  = getJsonForRelationsFromDict ('spouses', items)
        jsonSpouses  = ", " + jsonSpouses
      
        # get siblings  data 
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'non-spouses', 3 " + ")"
        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'non-spouses', 3 " + ")"
        # getPersonProfile72  getPersonProfilePedigree    
        # 
        print (strSQL_final)  
        
        cn = getSQLConn('gen30') 
        cursor = cn.cursor()        
	        
        cursor.execute(strSQL_final)    
        
        items = [dict(relation_type = row[0], r01_ID=row[1], firstNameSource=row[2], 
        authUser=request.authenticated_userid,
        lastNameSource=row[3], r02_ID=row[4], firstNameTarget = row[5], lastNameTarget = row[6]) for row in
        cursor.fetchall()]
        
        jsonNonSpouses  = getJsonForRelationsFromDict ('nonSpouses', items)
                
        # get data that enables rendering of connecting lines between ancestors  
        # strSQL_final = "call getPersonProfile72(" + strPersonId + ", 0, 'ancestors', 5 " + ")"
        strSQL_final = "call getPersonProfilePedigree(" + strPersonId + ", 0, 'ancestors', 5 " + ")"
        print (strSQL_final)  

        cn = getSQLConn('gen30') 

        cursor = cn.cursor()        
            
        cursor.execute(strSQL_final)    
        
        items = [dict(relation_type = row[0], r01_ID=row[1], firstNameSource=row[2], 
        authUser=request.authenticated_userid,
        lastNameSource=row[3], r02_ID=row[4], firstNameTarget = row[5], lastNameTarget = row[6]) for row in
        cursor.fetchall()]
        
        jsonAncestors  = getJsonForRelationsFromDict ('ancestors', items)
        
        # assemble into final full json string 
        jsonNonSpouses  = ", " + jsonNonSpouses

        # jsonFull = jsonPeople2 + jsonSpouses +  jsonNonSpouses + '}'
                
        jsonChildren = ', ' + jsonChildren
        
        jsonAncestors = ', ' + jsonAncestors
        
        jsonFull = jsonPeople2 + jsonSpouses +  jsonNonSpouses + jsonChildren + jsonAncestors + '}'
        
        resp = Response ( jsonFull )                
    
        resp.headerlist.append(('Access-Control-Allow-Origin', '*')) #Add the access control
        print (" END  END  END  ")
    
        return resp

def getJsonForNodesFromDictC (relationType, dictRelationsData, dictRelationsDataByRow, authUserID):

    objTd = dictRelationsData
    objTdByRow = dictRelationsDataByRow
    
    listOfNodesByRow = []

    for node in objTdByRow: 
        person = Person()
        person.rowNum = node['rowNum']
        person.rootFamilyNum = node['rootFamilyNum']
        person.familyID = node['familyID']
        person.colsNeeded = node['colsNeeded']
        person.spouseCount = node['spouseCount']
        person.spouseNumber = node['spouseNumber']
        # person.spousesColCountList = 
        person.nonPedParentSpouseNumber = node['nonPedParentSpouseNumber']
        person.childrenCount = node['childrenCount']
        person.colOrder = node['colOrder']
        person.siblingOrder = node['siblingOrder']
        person.matrixNode = node['matrixNode']
        person.personID = node['personID']
        person.treeID = node['treeID']
        person.motherID = node['motherID']
        person.fatherID = node['fatherID']
        person.firstName = node['firstName']
        person.lastName = node['lastName']
        person.dobYear = node['dobYear']
        person.dobYear = node['dobYear']
        person.dodYear = node['dodYear']
        person.blood = node['blood']
        person.relationType = node['relationType']
        person.relationID = node['relationID']
        person.rootFlag = node['rootFlag']
        person.startCol = 0
        person.nukeFamilyStartCol = 0
        person.nukeFamilyEndCol = 0
        person.numberOfPedGens = 0

        listOfNodesByRow.append(person)

    jsonFamily = ""
    jsonAllFamiles = ""
       
    intNodeLoopCtr = 0
    
    listOfNodes = []
    
    listOfNodesProcessed = []
    
    rootFamilyNum = 100

    numGens = -1
    nodeCtr = 0

    for node in objTd: 
        person = Person()
      
        person.rowNum = node['rowNum']
        if person.rowNum < -5:  # skip the older, pedigree rows 
            pass

        # if person.rowNum > numGens:
          #  numGens = person.rowNum

        person.rootFamilyNum = node['rootFamilyNum']
        person.lastName = node['lastName']
        person.firstName = node['firstName']

        # print (person.lastName + ', ' + person.firstName + ', ' + 'rootFamily: ' + str(person.rootFamilyNum) + '; nodes count: ' + str(len(listOfNodesProcessed)))

        print (rootFamilyNum)
        print (person.rootFamilyNum)

        if (person.rootFamilyNum) > rootFamilyNum:
            listOfNodesProcessed = processFamilyNodes(listOfNodes, listOfNodesByRow, listOfNodesProcessed, person.rootFamilyNum - 1, numGens)
       
            rootFamilyNum += 1
            numGens = -1

        person.familyID = node['familyID']
   
        person.colsNeeded = node['colsNeeded']
        person.startCol = 0
        person.rectCoordX = 0
        person.numberOfPedGens = 0
        person.endCol = 0
        person.nukeFamilyStartCol = 0
        person.nukeFamilyEndCol = 0

        person.siblingOrder = node['siblingOrder']

        person.spouseCount = node['spouseCount']
        person.spouseNumber = node['spouseNumber']
        person.nonPedParentSpouseNumber = node['nonPedParentSpouseNumber']
        # node['nonPedParentSpouseNumber']

        person.childrenCount = node['childrenCount']
        person.colOrder = node['colOrder']
        person.matrixNode = node['matrixNode']
        person.personID = node['personID']
        person.treeID = node['treeID']
        person.motherID = node['motherID']
        person.fatherID = node['fatherID']
        person.firstName = node['firstName']
        person.lastName = node['lastName']
        person.dobYear = node['dobYear']
        person.dodYear = node['dodYear']
        person.blood = node['blood']
        person.relationType = node['relationType']
        person.relationID = node['relationID']
        person.rootFlag = node['rootFlag']

        listOfNodes.append(person)
   
        nodeCtr += 1

    # if person.rootFamilyNum > 95:  # skip the older, pedigree rows
    listOfNodesProcessed = processFamilyNodes(listOfNodes, listOfNodesByRow, listOfNodesProcessed, person.rootFamilyNum, numGens)

    # listOfPeople = calcStartEndCols (listOfNodesProcessed, listOfNodesProcessed)
    result = calcStartEndCols (listOfNodesProcessed, listOfNodesProcessed)
    
    listOfPeople = result[0]
    # for person in listOfNodesProcessed:
    
    listOfChildren = result[1]
    lowRowNumOfTree = result[2] 
    countOfPedGens = result[3]
    
    # full monte 01
    print ('count  of ped gens is: ' + str(countOfPedGens))
    for person in listOfPeople:
        print ('row: ' +  str(person.rowNum) + '; ' + 'start col #: ' + str(person.startCol) + '; end col #: ' + str(person.endCol) +'; rowPos: ' + str(person.rectCoordX) + '; ' + person.lastName + ', ' + person.firstName + ', ' + 'rootFamily: ' + str(person.rootFamilyNum) + '; nodes count: ' + str(len(listOfNodesProcessed)) + '; person ID:'  + str(person.personID) + '; mother ID:'  + str(person.motherID) + str(person.personID) + '; father ID:'  + str(person.fatherID)  )

    genNum = ""
    cellNums = ""
    cellNum = ""

    countOfPedGensB = countOfPedGens # + 1

    # set up a list of all cells, whether or not populated 
    # listOfAllCellsForTree = [['0','0','0']]
    # listOfAllCellsForTree = [['0','0','0']]
    # listOfAllCellsForTree =  ([['genNum', '0'], ['cellNum', '0'], ['personID', '0']])
    listOfAllCellsForTree = []
    print ('ya')
    # print (listOfAllCellsForTree[1][1])

    for ctrNodes in range(countOfPedGensB, 1, -1):
       
        if ctrNodes == countOfPedGensB:
            genYoungest = "gen " + str(ctrNodes + 1)
            personCount = "; # of people in gen: 1;"
            
            cellYoungest = 2**(ctrNodes-1)
            
            print (str(genYoungest) + personCount + " cell: " + str(cellYoungest))
            treeCell = TreeCell()
            treeCell.genNum = ctrNodes + 1
            treeCell.cellNum = cellYoungest

            # listOfAllCellsForTree.append (treeCell)
            # listOfAllCellsForTree.append ([treeCell.genNum, treeCell.cellNum, 0])
            # listOfAllCellsForTree.append ([['genNum', str(treeCell.genNum)], ['cellNum', str(treeCell.cellNum)], ['personID', '0']])
            listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0], ['firstName', 'none'], ['lastName', 'none']])
            # listOfAllCellsForTree.append [(1, 2, 0)]

            # etree.SubElement(body, "h4").text = genYoungest + personCount + " cell " + str(cellYoungest)
        
        if ctrNodes <= countOfPedGensB:
            # genNum = "gen " + str(ctrNodes - 1) + "; "
            genNumString = "gen " + str(ctrNodes) + "; "
            genNum = ctrNodes 
            personCount = "; # of people in gen: " + str(2**((countOfPedGensB+1)-ctrNodes)) + "; "
            
        print (genNumString + personCount)
        
        cellNums = ""
        cellNum = ""
        for y in range(2**(countOfPedGensB-ctrNodes) * 2):
            # cellNums = cellNums + " " + str(2**(ctrNodes-2) + (y * (2**(ctrNodes-1))))
            cellNumString =  "cell num: " + str(2**(ctrNodes-2) + (y * (2**(ctrNodes-1))))
            print (cellNumString)
            cellNum = 2**(ctrNodes-2) + (y * (2**(ctrNodes-1)))
            treeCell = TreeCell()
            treeCell.genNum = genNum
            treeCell.cellNum = cellNum

            # listOfAllCellsForTree.append ([treeCell.genNum, treeCell.cellNum, 0])
            # listOfAllCellsForTree.append ([['genNum', str(treeCell.genNum)], ['cellNum', str(treeCell.cellNum)], ['personID', '0']])
            # listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0]])
            listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0], ['firstName', 'none'], ['lastName', 'none']])
            # listOfAllCellsForTree.append ([['genNum', 'a'], ['cellNum', 'b'], ['personID', '0']])
            # listOfAllCellsForTree.append (treeCell)

        # print( genNum +  personCount + " cell #s: " + str(cellNums))
    
    for z in range(2**(countOfPedGensB)):
        print (str(z))
        treeCell = TreeCell()
        treeCell.genNum = 1
        treeCell.cellNum = z
        # listOfAllCellsForTree.append (treeCell)
        # listOfAllCellsForTree.append ([treeCell.genNum, treeCell.cellNum, 0])
        # listOfAllCellsForTree.append ([['genNum', str(treeCell.genNum)], ['cellNum', str(treeCell.cellNum)], ['personID', '0']])
        # listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0]])
        listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0], ['firstName', 'none'], ['lastName', 'none']])
        
    for cell in listOfAllCellsForTree:
        # print ('ya-' + str(cell.genNum) + '-' + str(cell.cellNum))
        pass

    '''
    val = 6
    a = [[1,2,0],[3,4,0],[5,6,0], [6,7,9]]

    y = [x for x in a if val in x]

    print(y)
   
    for ctr in y:
        print (y)
    '''
    ## 
    '''
    for person in listOfPeople:
        # y = [x for x in a if val in x]
        
        match = [x for x in listOfAllCellsForTree if person.startCol in x]

        for ctr in match:
            print (str(match[1]) + ' ' + str(person.personID))
    '''
    # print (listOfAllCellsForTree)
    for cell in listOfAllCellsForTree:
        continue
        print (cell)
        print (cell[0])
        print (cell[0][1])
        print (cell[2])
        print (cell[2][0])
        
        
        # print(cell[0][1])
        
        # print(cell[1][1])
        # pass
    
    for person in listOfPeople:
        # y = [x for x in a if val in x]
        
        for cell in listOfAllCellsForTree:
            # if person.startCol == cell[1]:
            if person.startCol == cell[1][1] and cell[0][1] != 1: # person.rowNum > 1:   # cell[0][1] != 1:
                # print ('match afdsfdas')
                print ('row num: ' + str(person.rowNum))
                cell[2][1] = person.personID
                cell[3][1] = person.firstName
                cell[4][1] = person.lastName
                continue
            
            if person.startCol == cell[1][1] and person.rowNum == 1: # cell[0][1] == 1: #person.rowNum == 1:
                # print ('match afdsfdas')
                print ('row num: ' + str(person.rowNum))
                cell[2][1] = person.personID
                cell[3][1] = person.firstName
                cell[4][1] = person.lastName
                continue

    ctr = 0

    json_str = ""
    for cell in listOfAllCellsForTree:
        # print (cell)
        # listOfAllCellsForTree.append (['genNum', str(treeCell.genNum)], ['cellNum', str(treeCell.cellNum)], 0])
        dictOfAllCellsForTree = {x[0]:x[1] for x in cell}
        json_str += str(dictOfAllCellsForTree) + ', '
        # print (dictOfAllCellsForTree)
        # pass
    # print (dictOfAllCellsForTree)
    # l1 = [[1,2],[3,4],[5,[6,7]]]
    # d1={x[0]:x[1] for x in l1}
    # print(d1)#Output:{1: 2, 3: 4, 5: [6, 7]}
        
    
    # json_str = json.dumps(dictOfAllCellsForTree)

    print('afds')
    print (json_str)
    print('223 afds')
    
    separator = ', '

    # create json for  children to be connected via lines in tree
    ctrPeople = 1
    
    strJsonChildren = ''
    strJsonChildren = '  "children": [' 
    for person in listOfChildren:
        # jsonChild = '{' + '"personID": ' + str(person.personID)  + '}'

        jsonChild = ' {  "source": { "id": ' + str(person.personID) + ', "name": "' + person.firstName + ' ' + person.lastName + '" }, "target": {"id":  ' + str(person.personID) + ', "name": "' + person.firstName + ' ' + person.lastName + '" } } '

                
        if ctrPeople > 1:
            strJsonChildren += separator + jsonChild
        elif ctrPeople == 1:
            strJsonChildren += jsonChild

        ctrPeople += 1

    strJsonChildren += " ] "            

    # create json for person nodes
    ctrPeople = 1
    strJson = ''
    
    for person in listOfPeople:
        # if person.startCol == 0:
          #   person.startCol = 1

        jsonPerson =  '{' +  '"treeID": ' + str(person.treeID) + ', "personID": ' + str(person.personID) + ', "rootFlag":' + str(person.rootFlag) +  ', "motherID": ' + str(person.motherID) + ', "fatherID": ' + str(person.fatherID) +  ', "relation": "' + person.relationType + '", "authUser": "' + authUserID + '", "lastName": "' + person.lastName +  '", "firstName": "' + person.firstName + '", "dobYear": ' + str(person.dobYear) + ', "dodYear": ' + str(person.dodYear) + ', "blood": ' + str(person.blood)  +  ', "rowNum": ' + str(person.rowNum) + ', "orderNum": ' + str(person.startCol) + ', "sstyle": ""' + ', "topMenu": ' + '"no"'  + ', "deviceType": '  + '"notMobile"' + ', "sort": ' + '""' + ', "parentColOrder": ' + '0' + ', "numNodesInRow": ' + '0' + ', "childrenCount": ' +  str(person.childrenCount) + ', "matrixNode": "' +  person.matrixNode +  '"' + ','  + '"family Num": "' + str(person.familyID) + '", "cols Needed":' + str(person.colsNeeded) + ',' + ' "colStart":'  +  str(person.startCol) + ',' + ' "rectCoordX":'  +  str(person.rectCoordX) + ',' + ' "col End":' + str(person.endCol) + ',' + ' "nukeFamilyStartCol":' + str(person.nukeFamilyStartCol) + ',' + ' "nukeFamilyEndCol":' + str(person.nukeFamilyEndCol) + ', "lowRowNumOfTree":' + str(lowRowNumOfTree) + ', "spouseNumber":' + str(person.spouseNumber) + ', "countOfPedGens":' + str(person.numberOfPedGens)  + '}' # +'<br>'

            # request.authenticated_userid

        if ctrPeople > 1:
            strJson += separator + jsonPerson
        elif ctrPeople == 1:
            strJson += jsonPerson

        ctrPeople += 1
            
    return (strJson, strJsonChildren)

def getJsonForTallTree (relationType, dictRelationsData, dictRelationsDataByRow, authUserID):

    objTd = dictRelationsData
    objTdByRow = dictRelationsDataByRow
    
    listOfNodesByRow = []

    for node in objTdByRow: 
        person = Person()
        person.rowNum = node['rowNum']
        person.rootFamilyNum = node['rootFamilyNum']
        person.familyID = node['familyID']
        person.colsNeeded = node['colsNeeded']
        person.spouseCount = node['spouseCount']
        person.spouseNumber = node['spouseNumber']
        # person.spousesColCountList = 
        person.nonPedParentSpouseNumber = node['nonPedParentSpouseNumber']
        person.childrenCount = node['childrenCount']
        person.colOrder = node['colOrder']
        person.siblingOrder = node['siblingOrder']
        person.matrixNode = node['matrixNode']
        person.personID = node['personID']
        person.treeID = node['treeID']
        person.motherID = node['motherID']
        person.fatherID = node['fatherID']
        person.firstName = node['firstName']
        person.lastName = node['lastName']
        person.dobYear = node['dobYear']
        person.dobYear = node['dobYear']
        person.dodYear = node['dodYear']
        person.blood = node['blood']
        person.relationType = node['relationType']
        person.relationID = node['relationID']
        person.rootFlag = node['rootFlag']
        person.startCol = 0
        person.nukeFamilyStartCol = 0
        person.nukeFamilyEndCol = 0
        person.numberOfPedGens = 0

        listOfNodesByRow.append(person)

    jsonFamily = ""
    jsonAllFamiles = ""
       
    intNodeLoopCtr = 0
    
    listOfNodes = []
    
    listOfNodesProcessed = []
    
    rootFamilyNum = 100

    numGens = -1
    nodeCtr = 0

    for node in objTd: 
        person = Person()
      
        person.rowNum = node['rowNum']
        if person.rowNum < -5:  # skip the older, pedigree rows 
            pass

        person.rootFamilyNum = node['rootFamilyNum']
        person.lastName = node['lastName']
        person.firstName = node['firstName']

        print (rootFamilyNum)
        print (person.rootFamilyNum)

        if (person.rootFamilyNum) > rootFamilyNum:
            listOfNodesProcessed = processFamilyNodes(listOfNodes, listOfNodesByRow, listOfNodesProcessed, person.rootFamilyNum - 1, numGens)
       
            rootFamilyNum += 1
            numGens = -1

        person.familyID = node['familyID']
   
        person.colsNeeded = node['colsNeeded']
        person.startCol = 0
        person.rectCoordX = 0
        person.numberOfPedGens = 0
        person.endCol = 0
        person.nukeFamilyStartCol = 0
        person.nukeFamilyEndCol = 0

        person.siblingOrder = node['siblingOrder']

        person.spouseCount = node['spouseCount']
        person.spouseNumber = node['spouseNumber']
        person.nonPedParentSpouseNumber = node['nonPedParentSpouseNumber']
        # node['nonPedParentSpouseNumber']

        person.childrenCount = node['childrenCount']
        person.colOrder = node['colOrder']
        person.matrixNode = node['matrixNode']
        person.personID = node['personID']
        person.treeID = node['treeID']
        person.motherID = node['motherID']
        person.fatherID = node['fatherID']
        person.firstName = node['firstName']
        person.lastName = node['lastName']
        person.dobYear = node['dobYear']
        person.dodYear = node['dodYear']
        person.blood = node['blood']
        person.relationType = node['relationType']
        person.relationID = node['relationID']
        person.rootFlag = node['rootFlag']

        listOfNodes.append(person)
   
        nodeCtr += 1

    # if person.rootFamilyNum > 95:  # skip the older, pedigree rows
    listOfNodesProcessed = processFamilyNodes(listOfNodes, listOfNodesByRow, listOfNodesProcessed, person.rootFamilyNum, numGens)

    # listOfPeople = calcStartEndCols (listOfNodesProcessed, listOfNodesProcessed)
    result = calcStartEndCols (listOfNodesProcessed, listOfNodesProcessed)
    
    listOfPeople = result[0]
    
    listOfChildren = result[1]
    lowRowNumOfTree = result[2] 
    countOfPedGens = result[3]
    
    # full monte 01
    print ('count  of ped gens is: ' + str(countOfPedGens))
    for person in listOfPeople:
        print ('row: ' +  str(person.rowNum) + '; ' + 'start col #: ' + str(person.startCol) + '; end col #: ' + str(person.endCol) +'; rowPos: ' + str(person.rectCoordX) + '; ' + person.lastName + ', ' + person.firstName + ', ' + 'rootFamily: ' + str(person.rootFamilyNum) + '; nodes count: ' + str(len(listOfNodesProcessed)) + '; person ID:'  + str(person.personID) + '; mother ID:'  + str(person.motherID) + str(person.personID) + '; father ID:'  + str(person.fatherID)  )

    genNum = ""
    cellNums = ""
    cellNum = ""

    countOfPedGensB = countOfPedGens # + 1

    # set up a list of all cells, whether or not populated 
    
    listOfAllCellsForTree = []
    
    for ctrNodes in range(countOfPedGensB, 1, -1):
       
        if ctrNodes == countOfPedGensB:
            genYoungest = "gen " + str(ctrNodes + 1)
            personCount = "; # of people in gen: 1;"
            
            cellYoungest = 2**(ctrNodes-1)
            
            print (str(genYoungest) + personCount + " cell: " + str(cellYoungest))
            treeCell = TreeCell()
            treeCell.genNum = ctrNodes + 1
            treeCell.cellNum = cellYoungest

            # listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0]])
            # listOfAllCellsForTree.append ([["genNum", treeCell.genNum], ["cellNum", treeCell.cellNum], ["personID", 0]])
            listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0], ['firstName', 'none'], ['lastName', 'none']])

        if ctrNodes <= countOfPedGensB:
            genNumString = "gen " + str(ctrNodes) + "; "
            genNum = ctrNodes 
            personCount = "; # of people in gen: " + str(2**((countOfPedGensB+1)-ctrNodes)) + "; "
            
        print (genNumString + personCount)
        
        cellNums = ""
        cellNum = ""
        for y in range(2**(countOfPedGensB-ctrNodes) * 2):
            cellNumString =  "cell num: " + str(2**(ctrNodes-2) + (y * (2**(ctrNodes-1))))
            print (cellNumString)
            cellNum = 2**(ctrNodes-2) + (y * (2**(ctrNodes-1)))
            treeCell = TreeCell()
            treeCell.genNum = genNum
            treeCell.cellNum = cellNum

            # listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0]])
            # listOfAllCellsForTree.append ([["genNum", treeCell.genNum], ["cellNum", treeCell.cellNum], ["personID", 0]])
            listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0], ['firstName', 'none'], ['lastName', 'none']])
    
    for z in range(2**(countOfPedGensB)):
        print (str(z))
        treeCell = TreeCell()
        treeCell.genNum = 1
        treeCell.cellNum = z
        # listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0]])
        # listOfAllCellsForTree.append ([["genNum", treeCell.genNum], ["cellNum", treeCell.cellNum], ["personID", 0]])
        listOfAllCellsForTree.append ([['genNum', treeCell.genNum], ['cellNum', treeCell.cellNum], ['personID', 0], ['firstName', 'none'], ['lastName', 'none']])  
    '''
    val = 6
    a = [[1,2,0],[3,4,0],[5,6,0], [6,7,9]]

    y = [x for x in a if val in x]
    
    for ctr in y:
        print (y)
    '''
    '''
    for person in listOfPeople:
        # y = [x for x in a if val in x]
        
        match = [x for x in listOfAllCellsForTree if person.startCol in x]

        for ctr in match:
            print (str(match[1]) + ' ' + str(person.personID))
    '''
    print("1")
    print (listOfAllCellsForTree)
    print("2")

    for person in listOfPeople:
        print('root flag: ' + str(person.rootFlag))
        for cell in listOfAllCellsForTree:
            if person.startCol == cell[1][1] and cell[0][1] != 1: # person.rowNum > 1:   # cell[0][1] != 1:
                # print ('match afdsfdas')
                print ('row num: ' + str(person.rowNum))
                cell[2][1] = person.personID
                cell[3][1] = person.firstName
                cell[4][1] = person.lastName
                continue
            
            if person.startCol == cell[1][1] and person.rowNum == 1: # cell[0][1] == 1: #person.rowNum == 1:
                print ('row num: ' + str(person.rowNum))
                cell[2][1] = person.personID
                cell[3][1] = person.firstName
                cell[4][1] = person.lastName
                continue
            
            if  person.rootFlag == 1:
                print ("ROOT ROOT !")
                print (person.startCol)
                print(2**(countOfPedGensB-(ctrNodes-1)))

            rootCell = 2**(countOfPedGensB-(ctrNodes-1))
            if rootCell == cell[1][1] and person.rootFlag == 1 and cell[0][1] != 1:
                print ('row num: ' + str(person.rowNum))
                cell[2][1] = person.personID
                cell[3][1] = person.firstName
                cell[4][1] = person.lastName
                continue
            


            # print(cell)

    jsonPeopleInTree = ""
    for cell in listOfAllCellsForTree:
        dictOfAllCellsForTree={x[0]:x[1] for x in cell}
        jsonPeopleInTree += str(dictOfAllCellsForTree) + ', '
    # l1 = [[1,2],[3,4],[5,[6,7]]]
    # d1={x[0]:x[1] for x in l1}
    # print(d1)#Output:{1: 2, 3: 4, 5: [6, 7]}
        
    # jsonPeopleInTree = json.dumps(dictOfAllCellsForTree)

    # string[start:end:step]
    chopLastComma = jsonPeopleInTree[0:len(jsonPeopleInTree) - 2 ]
    jsonPeopleInTree =  chopLastComma.replace("'", '"')   
    
    print (jsonPeopleInTree)

    
    separator = ', '

    # create json for  children to be connected via lines in tree
    ctrPeople = 1
    
    strJsonChildren = ''
    strJsonChildren = '  "children": [' 
    for person in listOfChildren:
        # jsonChild = '{' + '"personID": ' + str(person.personID)  + '}'

        jsonChild = ' {  "source": { "id": ' + str(person.personID) + ', "name": "' + person.firstName + ' ' + person.lastName + '" }, "target": {"id":  ' + str(person.personID) + ', "name": "' + person.firstName + ' ' + person.lastName + '" } } '
                
        if ctrPeople > 1:
            strJsonChildren += separator + jsonChild
        elif ctrPeople == 1:
            strJsonChildren += jsonChild

        ctrPeople += 1

    strJsonChildren += " ] "            

    # return (strJson, strJsonChildren)
    return (jsonPeopleInTree, strJsonChildren)




def processFamilyNodes (listOfFamilyNodes, listOfFamilyNodesByRow, listOfNodesProcessed, familyID, numGens):

    # listOfFamilyNodes.sort(key=lambda x: str(x.rowNum) + '.' + x.familyID + '.' + x.matrixNode, reverse=True) 
    
    # sort the list of person objects by rowNum, familyID, matrixNode in reverse order 
    # means the youngest row first for a loop thru:
    listOfFamilyNodes.sort(key=lambda x: str(x.rowNum) + '.' + x.familyID + '.' + str(x.nonPedParentSpouseNumber) +  x.matrixNode, reverse=True) 

    strJson = ''
        
    # nodeColsNeededEachGen  = [0,0,0,0,0,0,0]
    # nodeColsNeededEachGenSpouse  = [0,0,0,0,0,0,0]
    nodeColsNeededEachGen  = [0,0,0,0,0,0,0,0,0,0]  # 2023_0318
    nodeColsNeededEachGenSpouse  = [0,0,0,0,0,0,0,0,0,0]   # 2023_0318
   
    # nodeColsNeededEachGen  = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]

    matrixNode = ''

    numColsNeededByFirstWife = -1
    
    listOfNodesProcessed2 = []

    countOfColsNeededByFirstSpouse = 0

    for person in listOfFamilyNodes:         

        # if person.familyID == 100:
        if person.rootFamilyNum < 101:
            if  familyID == 101: 
                listOfNodesProcessed2.append (person)
                print ('root fam:' + str(person.rootFamilyNum))
            continue
        if str(person.familyID).find(str(familyID)) < 0:
            continue
        if person.relationType == 'spouse': #  and person.spouseNumber == 1:
            # person.matrixNode = person.matrixNode + '.' + '01'
            print ('matrix: ' + person.lastName + ' ' + person.firstName + ' ' + person.matrixNode)
        
            if person.spouseNumber ==1:
                pass
               
            if person.spouseNumber > 1:
                person.colsNeeded = 1
            
            # listOfNodesProcessed2.append (person)
            # continue

        matrixNode = person.matrixNode
        # nodefamilyID = person.familyID
        nodefamilyID = person.matrixNode
        nodeGenNum = genOfNode = person.matrixNode.count('.') 

        nodeColsNeededEachGen[0] = 0        
        nodeColsNeededEachGen[1] = 0
        nodeColsNeededEachGen[2] = 0
        nodeColsNeededEachGen[3] = 0
        nodeColsNeededEachGen[4] = 0
        nodeColsNeededEachGen[5] = 0
        nodeColsNeededEachGen[6] = 0
        nodeColsNeededEachGen[7] = 0  # added 2023_0318
        nodeColsNeededEachGen[8] = 0  # added 2023_0318
        nodeColsNeededEachGen[9] = 0  # added 2023_0318

        ctrC = 0
        for personInner in listOfFamilyNodesByRow:                 
            # if personInner.familyID == 100:
            if personInner.rootFamilyNum < 101:
                continue
            if personInner.relationType == 'spouse':
                # pass
                continue
            if str(personInner.familyID).find(str(familyID)) < 0:
                continue
            
            genOfCurrentNodeInner = personInner.matrixNode.count('.') 
                      
            # if personInner.matrixNode.find(nodefamilyID) > -1:  # 101.1.1 find 101.1
            if personInner.matrixNode.find(nodefamilyID) > -1 and personInner.matrixNode != nodefamilyID:  
                # nodeColsNeededEachGen[genOfCurrentNodeInner] += personInner.colsNeeded 
                if person.relationType != 'spouse':
                    nodeColsNeededEachGen[genOfCurrentNodeInner] += personInner.colsNeeded 
                if person.relationType == 'spouse': 
                    if person.personID == personInner.motherID or person.personID == personInner.fatherID:
                        nodeColsNeededEachGen[genOfCurrentNodeInner] += personInner.colsNeeded 
                        print ('got: ' + person.lastName + ' ' + person.firstName + ' pid: '+ str(person.personID) + personInner.lastName + ' ' + personInner.firstName + ' mom pid: ' + str(personInner.motherID) + ' dad pid: ' + str(personInner.fatherID))

            if nodeGenNum > 2:
                # print(matrixNode.rfind('.'))
                pass
                # print('ending: ' + matrixNode[matrixNode.rfind('.') + 1:])
        
        allRows = ''        
        maxCols = -1
        for x in nodeColsNeededEachGen:
            allRows += str(x) + ';'
            if x > maxCols:
                maxCols = x 
        if maxCols > person.colsNeeded:
            person.colsNeeded = maxCols
        
        print ('node family id: ' + str(nodefamilyID) + ' ' + person.lastName + ' ' + person.firstName + ' ' + str(person.colsNeeded))

        if person.relationType == 'spouse': #  and person.spouseNumber == 1:
            person.matrixNode = person.matrixNode + '.' + '01'
        
        listOfNodesProcessed2.append (person)
        # print (matrixNode + '; maxCols: ' + str(person.colsNeeded) + '; all: ' + allRows)    
    
    # ***************************************
    # second pass thru this, needs to be cleaned up...
    
    for person in listOfNodesProcessed2:         

        # if person.familyID == 100:
        if person.rootFamilyNum < 101:
            listOfNodesProcessed.append (person)
            # print ('100')
            continue
        if str(person.familyID).find(str(familyID)) < 0:
            continue
        if person.relationType == 'spouse':
            # person.matrixNode = person.matrixNode + '.' + '01'
            # person.colsNeeded = 7
            
            if person.spouseNumber == 1:
                pass
          
                # person.colsNeeded = 7 # numColsNeededByFirstWife  + 1 # 7
                # countOfColsNeededBySpouse = countColsNeededBySpouse (person)
                
                #countOfColsNeededBySpouse = person.colsNeeded
               #person.colsNeeded = countOfColsNeededBySpouse
            if person.spouseNumber > 1:
                person.colsNeeded = 1
                pass
                # person.colsNeeded = countColsNeededBySpouse (person, listOfFamilyNodes, listOfFamilyNodesByRow)
                
            listOfNodesProcessed.append (person)
            continue

        matrixNode = person.matrixNode
        # nodefamilyID = person.familyID
        nodefamilyID = person.matrixNode
        nodeGenNum = genOfNode = person.matrixNode.count('.') 

        nodeColsNeededEachGen[0] = 0         
        nodeColsNeededEachGen[1] = 0
        nodeColsNeededEachGen[2] = 0
        nodeColsNeededEachGen[3] = 0
        nodeColsNeededEachGen[4] = 0
        nodeColsNeededEachGen[5] = 0
        nodeColsNeededEachGen[6] = 0
        nodeColsNeededEachGen[7] = 0  # added 2023_0318
        nodeColsNeededEachGen[8] = 0  # added 2023_0318
        nodeColsNeededEachGen[9] = 0  # added 2023_0318


        for personInner in listOfNodesProcessed2:                 
            # if personInner.familyID == 100:
            if personInner.rootFamilyNum < 101:
                continue
            if personInner.relationType == 'spouse':  
                # pass
                continue
            if str(personInner.familyID).find(str(familyID)) < 0:
                continue

            # prevGenNum = genOfCurrentNodeInner 
            genOfCurrentNodeInner = personInner.matrixNode.count('.') 
            #if genOfCurrentNodeInner < nodeGenNum:
              #  continue 
           
            if personInner.matrixNode.find(nodefamilyID) > -1:  # 101.1.1 find 101.1
                nodeColsNeededEachGen[genOfCurrentNodeInner] += personInner.colsNeeded 

                lenNode = len(personInner.matrixNode)
            
        allRows = ''        
        maxCols = -1
        for x in nodeColsNeededEachGen:
            allRows += str(x) + ';'
            if x > maxCols:
                maxCols = x 
        if maxCols > person.colsNeeded:
            person.colsNeeded = maxCols
        
        print ('B. node family id: ' + str(nodefamilyID) + ' ' + person.lastName + ' ' + person.firstName + ' ' + str(person.colsNeeded))
        listOfNodesProcessed.append (person)
        # print (matrixNode + '; maxCols: ' + str(person.colsNeeded) + '; all: ' + allRows)          

    return listOfNodesProcessed


def calcStartEndCols (listOfPeople, listOfParents):

    # listOfPeople.sort(key=lambda x: str(x.rowNum) + '.' + x.matrixNode)
    # listOfPeople.sort(key=lambda x: str(x.rowNum) + '.' + x.familyID + '.' + x.matrixNode)
    listOfPeople.sort(key=lambda x: str(x.rowNum) + '.' + x.familyID + '.' + str(x.nonPedParentSpouseNumber) + '.' + x.matrixNode )
   
    
    colWidth = 160  # 160
    # **********************************************
    # Process pedigree ancestors
    # **********************************************
    
    result = calcPedigreeGensStartCols_02 (listOfPeople)  
    # result = calcPedigreeGensStartColsCompact (listOfPeople)
    listOfPeople02 = result[0]
    colPosForRoot = result[1]
    countOfPedGens = result[2]
       
    
    ##### start of 2023_0508 comment 
    
    if colPosForRoot == 2:
        colPosForRoot = 1.5
    
    if colPosForRoot < 2:
        colPosForRoot = 1
    
    ##### end of 2023_0508 comment 
   
    # if colPosForRoot == 0:
    #  colPosForRoot = -1

    
    # **********************************************   
    #process root and descendants
    # **********************************************
    listOfPeople03 = []
  

    # **********************************************
    # Process tree root, siblings and descendants
    # **********************************************
  
    pedGensOnly = "no"

    # create a list with root and root's descendants
    for person in listOfPeople:
        if pedGensOnly == "no":
            if person.rootFamilyNum > 100:  # get all descendants
                 listOfPeople03.append(person)
                 print (person.firstName + ' - ' + str(person.rootFlag) + ' ' + person.matrixNode + ' ' + str(person.nonPedParentSpouseNumber))
        if pedGensOnly == "yes":
            if person.rootFamilyNum == 101 and person.rootFlag == 1:  # > 100  2023_0225-added: and person.rootFlag==1: to just get peds
                listOfPeople03.append(person)
                print (person.firstName + ' - ' + str(person.rootFlag) + ' ' + person.matrixNode + ' ' + str(person.nonPedParentSpouseNumber))
    
    # adjust root position 4/3/21
    runningSumColStart = colPosForRoot  # 1
    colPosForSpouse = -1
    colEndOfPreviousSpouse = -1
    colPosForRootParents = 1
    prevRootFamilyNum = -1

    # process the root person's generation
    for person in listOfPeople03:

        # process root's generation
        # if len(person.matrixNode) == 3 and person.blood == 1:
        if len(person.matrixNode) <= 3 and person.blood == 1:
            # assign col nums for root person and his/her siblings 
            person.startCol = runningSumColStart
            person.rectCoordX = (person.startCol *  colWidth)  + 20 # 160
            if person.rootFlag == 1:
                person.rectCoordX = colPosForRoot
            person.endCol = person.startCol + (person.colsNeeded - 1)
            runningSumColStart = person.endCol + 1
            colPosForSpouse = person.startCol + 1            
        
        if person.matrixNode.find('.01', 0, 6) > -1:
            # set col num for spouses of root person and spouses of root's sibs (previously gen1)
          
            if person.spouseNumber == 1:
                person.startCol = colPosForSpouse + (person.spouseNumber - 1)
                person.rectCoordX = person.startCol * colWidth # 160 
                # person.rectCoordX = (colPosForSpouse + (person.spouseNumber - 1)) * 160
                person.endCol = colPosForSpouse + (person.spouseNumber - 1)
                colEndOfPreviousSpouse = person.startCol + (person.colsNeeded - 1)
            else: 
                person.startCol = colEndOfPreviousSpouse # + 5
                person.rectCoordX = person.startCol *  colWidth # 160
                # person.rectCoordX = colEndOfPreviousSpouse * 160
                person.endCol = colEndOfPreviousSpouse #  + 5
                colEndOfPreviousSpouse = person.startCol + person.colsNeeded
   
    colEndOfOlderSibling = -1
    colEndOfPreviousSpouse = -1
    nukeFamilyStartCol = -1
    nukeFamilyEndCol = -1
    
    # process descendants' generations younger than the root's gen
    for person in listOfPeople03:
       
        # process descendants' generations
        if len(person.matrixNode) > 3 and person.matrixNode.find('.01', 0, 7) == -1:
            # print ('sib ord: ' + str(person.siblingOrder))
            print (person.spouseCount)
            if person.siblingOrder == 1 and person.blood == 1:
                # for first born, set person start col to start col of pedigree parent 
                # person = setStartColEndCol (person, listOfPeople )
                result = setStartColEndCol (person, listOfPeople )
                person = result[0]
                spouseNumber = result[1]

                person.rectCoordX = person.startCol * colWidth  # 160
                colEndOfOlderSibling = person.endCol
                colPosForSpouse = person.startCol + 1   
                # pass
            if person.siblingOrder > 1 and person.blood == 1:
                # for younger siblings, set person start col to the end col + 1 of just older sibling 
                print (person.firstName)
                print (colEndOfOlderSibling)
                result = setStartColEndCol (person, listOfPeople )
                person2 = result[0]
                spouseNumber = result[1]
                print ('spouse num' + str(spouseNumber))
                if spouseNumber == 1:
                    person.startCol = colEndOfOlderSibling + 1
                else:
                    person.startCol = person2.startCol

                # nukeFamilyEndCol = person.startCol # used to draw horiz line above and connecting siblings 
                # person.nukeFamilyEndCol = nukeFamilyEndCol

                person.rectCoordX = person.startCol * colWidth # 160
                person.endCol = person.startCol + (person.colsNeeded - 1)
                colEndOfOlderSibling = person.endCol
                colPosForSpouse = person.startCol + 1            
            if person.siblingOrder == 0 and person.blood == 0:
                # set start col for spouses 
                if person.spouseNumber == 1:
                    person.startCol = colPosForSpouse + (person.spouseNumber - 1) 
                    person.rectCoordX = person.startCol * colWidth # 160
                    person.endCol = colPosForSpouse + (person.spouseNumber - 1) 
                    colEndOfPreviousSpouse = person.startCol + (person.colsNeeded - 1) 
                else: 
                    person.startCol = colEndOfPreviousSpouse 
                    person.rectCoordX = person.startCol * colWidth # 160
                    person.endCol = colEndOfPreviousSpouse  
                    colEndOfPreviousSpouse = person.startCol + person.colsNeeded 


    for person in listOfPeople03:
        if person.blood == 1:
            famStart, famEnd = setNukeFamBloodParentStartAndEndCols (person.personID, listOfPeople03)
            person.nukeFamilyStartCol = famStart
            person.nukeFamilyEndCol = famEnd

    # slide the descendants over to the right to alighn better with the ancestors
    # for person in listOfPeople03:
      #  person.startCol +=12

    # compress the spacing for ancestors
    # for person in listOfPeople02:
        # person.startCol = person.startCol * 0.5

    listOfChildren = [] # use to store the descendants who have a blood parent

    # add descendants to the list of pedigree ancestors
    
    for person in listOfPeople03:
        # print ('nuke f: ' + str(person.nukeFamilyStartCol ))
        
        if person.motherID > 0 or person.fatherID > 0:
            listOfChildren.append(person)

        listOfPeople02.append (person)
 
        
    for person in listOfPeople02:
        person.rowNum += 1   

    for person in listOfPeople02:
        lowRowNumOfTree = person.rowNum
        break
        # left off 

    print ('low row num of tree: ' + str(lowRowNumOfTree))     

    return listOfPeople02, listOfChildren, lowRowNumOfTree, countOfPedGens


def setStartColEndCol (person, listOfPeople):
    
    for parent in listOfPeople:
        print (parent.firstName + ' --  ' + parent.lastName)

    spouseNumber = 1
    for parent in listOfPeople:
                
        if parent.personID == person.motherID and parent.blood == 0 and parent.spouseNumber > 1:
            person.startCol = parent.startCol
            person.endCol = person.startCol + (person.colsNeeded - 1)
            print ('melania')
            spouseNumber = parent.spouseNumber
            break
        if parent.personID == person.fatherID and parent.blood == 0 and parent.spouseNumber > 1:
            person.startCol = parent.startCol
            person.endCol = person.startCol + (person.colsNeeded - 1)
            spouseNumber = parent.spouseNumber
            break
    
    if spouseNumber == 1:
        for parent in listOfPeople:
                    
            if parent.personID == person.motherID and parent.blood == 1:
                person.startCol = parent.startCol
                person.endCol = person.startCol + (person.colsNeeded - 1)
                break
            if parent.personID == person.fatherID and parent.blood == 1:
                person.startCol = parent.startCol
                person.endCol = person.startCol + (person.colsNeeded - 1)
                break
            #person.startCol = 77
        #print (person.startCol)
    
    return person, spouseNumber

def setNukeFamBloodParentStartAndEndCols (personID, listOfPeople03):

    # (motherID, fatherID,nukeFamilyStartCol, nukeFamilyEndCol, listOfPeople03):
    
    # iterate thru list of people to find blood parent and update start and end cols for the nuke family
    # 
    nukeFamilyStartCol = -1
    nukeFamilyEndCol = -1 

    foundBloodParent = -1
    for person in listOfPeople03:
        if person.motherID == personID:
            if person.startCol > nukeFamilyStartCol:
                nukeFamilyEndCol = person.startCol
                if nukeFamilyStartCol == -1:
                    nukeFamilyStartCol = person.startCol    
            if nukeFamilyStartCol > person.startCol:
                nukeFamilyStartCol = person.startCol
            if nukeFamilyEndCol < person.startCol:
                nukeFamilyEndCol = person.startCol
        
        if person.fatherID == personID:
            if person.startCol > nukeFamilyStartCol:
                nukeFamilyEndCol = person.startCol
                if nukeFamilyStartCol == -1:
                    nukeFamilyStartCol = person.startCol    
            if nukeFamilyStartCol > person.startCol:
                nukeFamilyStartCol = person.startCol
            if nukeFamilyEndCol < person.startCol:
                nukeFamilyEndCol = person.startCol

        '''
        if person.personID == motherID and person.blood == 1:
            print ('nukeFamLine: ' + str(nukeFamilyStartCol) + ' - ' + str(nukeFamilyEndCol) )
            foundBloodParent = 1
            
        if person.personID == fatherID and person.blood == 1:
            print ('nukeFamLine: ' + str(nukeFamilyStartCol) + ' - ' + str(nukeFamilyEndCol) )
            foundBloodParent = 1
            
        if foundBloodParent == 1:
            person.nukeFamilyStartCol = nukeFamilyStartCol
            person.nukeFamilyEndCol = nukeFamilyEndCol
            break
        '''

    # person.nukeFamilyStartCol = nukeFamilyStartCol
    # person.nukeFamilyEndCol = nukeFamilyEndCol
    # print ('person id: ' + str(personID) + ' range: ' + str(nukeFamilyStartCol) + ' ' + str(nukeFamilyEndCol) )

    return nukeFamilyStartCol, nukeFamilyEndCol
    # return listOfPeople03



def calcPedigreeGensStartCols_02 (listOfPeople): 
 
    # ancestors laid out centered 
    '''
     1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31
      2 6 10 14 18 22 26 30   2 to the 1 power = 2   repeat 7 times: 2 + 2 squared = 6 
       4 12 20 28  2 squared = 4   repeat three times:  4 + 2 cubed = 12 
        8  24   2 cubed (num of ped gens - 1) = 8    repeat once: 8 + 2 to the 4th = 24
         16

    '''

    listOfPedigreePeople  = []

    # get the count of ped gens
    pedGensAllCount = 0

    pedGenCount = 0
    prevRootFamilyNum = -1

    for person in listOfPeople:
         # if person.rootFamilyNum < 101  and person.rootFamilyNum > 85:  # 2023_0215
         if person.rootFamilyNum < 102  and person.rootFamilyNum > 85:  # 2023_0508
            if prevRootFamilyNum < person.rootFamilyNum or prevRootFamilyNum == -1:
                pedGensAllCount += 1
                prevRootFamilyNum = person.rootFamilyNum

    pedGenCount = 0
    prevRootFamilyNum = -1

    for person in listOfPeople:
        # iterate list which is sorted from earliest gen aka row to latest 
        # if person.rootFamilyNum < 101:
        # if person.rootFamilyNum < 101: # and person.rootFamilyNum > 98:
           
        # if person.rootFamilyNum < 101  and person.rootFamilyNum > 97:  # 2023_0215
        if person.rootFamilyNum < 101  and person.rootFamilyNum > 94:  # 2023_0215
        
        # if person.rootFamilyNum < 102  and person.rootFamilyNum > 97:  # 2023_0508 
        # if person.rootFamilyNum < 101  and person.rootFamilyNum > 92:  # 2023_0215
            if prevRootFamilyNum < person.rootFamilyNum or prevRootFamilyNum == -1:
                pedGenCount += 1
                prevRootFamilyNum = person.rootFamilyNum
                pid = person.personID

            listOfPedigreePeople.append (person)
        else:
            if person.rootFamilyNum > 101:
                break
            continue
                
    print ('num of ped gens: ' + str(pedGenCount))
    numOfPedGensToProcess = pedGenCount
    
    print('number of pedigree people: ' + str(len(listOfPedigreePeople)))


    # listOfPedigreePeople.sort(key=lambda x: str(x.rowNum) + '.' + x.familyID + '.' + x.matrixNode, reverse=True) 
    # sort list so that youngest gens come first 
    listOfPedigreePeople.sort(key=lambda x: str(x.rowNum), reverse=True) 

    # list to store person id and col nums for each pedigree
    people, colNum = (2**(pedGenCount+1), 2) 
    #arr = [[0 for i in range(cols)] for j in range(rows)] 
    arr = [[0 for i in range(colNum)] for j in range(people)] 
    print ('*** arr: ')
    print(arr) 

    pedColNum = -1
    prevRowNum = -1
    pedRowCtr = 0
    baseRowCtr = 1
    rowColPos = 0
    firstRowColPos = 0
    childs_ColPos = 1
    childYoungerGen = -1
    
    rootMomRectCoordX = 0
    rootDadRectCoordX = 0

    # loop thru each pedigree person and use their child's id to determine the ped's col num
    # then use the col num and row num to calc the final col pos

    # numOfPedGensToProcess = 2
    numOfGensProcessed = 0

    for person in listOfPedigreePeople:
        # loop thru from youngest gen to oldest 
        # print (person.relationType + ':' + str(person.relationID))
        
        if prevRowNum > person.rowNum and  prevRowNum > -1:
            print ('row num changed!')
            pedGenCount -=1
            rowColPos = 0
            firstRowColPos = 2
            childs_ColPos = 1
            baseRowCtr += 1
            numOfGensProcessed +=1            
        
        print (person.personID)
                   
        if pedRowCtr == 0:  
        # if pedRowCtr == -1:  
           childs_ColPos = 1
        else:
            # get the colPos of person's child 
            for k in range(len(arr)):
                childYoungerGen = arr[k][0]
                if childYoungerGen == person.relationID:
                    childs_ColPos = arr[k][1]
                    break

        print ('child younger gen: ' + str(childYoungerGen) + '; col pos: ' + str(childs_ColPos))
        # if pedRowCtr == 1:
        
        
        if person.relationType == 'mother':
            rowColPos = (childs_ColPos * 2) - 1
        elif person.relationType == 'father':
            rowColPos = (childs_ColPos * 2) 
        
        print ('ped row is: ' + str(pedRowCtr) + ' and person id is: ' + str(person.personID) + ' and col position is: ' + str(rowColPos) )


        '''
        calculating col positions for 4 ped gens with root at col pos 4
            1 2 3 4 5 6 7 8 - repeat 2 cubed times
            1 3 5 7  - (2 to the 1st) – (2 to the 0) + (2 to the 1st * 0, 1,2,3) == 1, 3,5,7  repeat 2 squared times
            2 6  - ((2 squared) – (2 to the 1st)) + (2 squared * 0,1) == 2,6  repeat 2 to the 1st times
            4 - ((2 cubed) – (2 squared)) + (2 cubed * 0) == 4  repeat 2**0  times
        '''
       
        colWidth = 160

        halfRectOffset = -75
        genCalc = numOfPedGensToProcess - (baseRowCtr )
        genCalcB = genCalc - 1
        if genCalc == 0:
            # oldest gen displayed in tree
            genCalcB = 0
            rowColPos -=1
            person.rectCoordX = 10 + (rowColPos * colWidth) + (rowColPos * 10)  # 160
            person.startCol = rowColPos 
            # rowColPos += 1
            
        if genCalc > 0:
            person.startCol = (2**genCalc) - (2**(genCalcB)) + (2**genCalc) * (rowColPos - 1)
            colPos = person.startCol
            # person.rectCoordX = 10 + (colPos * 160) + ((colPos - 1) * 10) + halfRectOffset
            person.rectCoordX = 10 + (colPos * colWidth) + ((colPos - 1) * 10) + halfRectOffset  # 160
        
        person.numberOfPedGens = pedGensAllCount
        print (str(person.personID) + 'start col: ' + str(person.startCol) + ' rect coord x: ' + str(person.rectCoordX))
           
        if pedRowCtr == 0:
            rootMomRectCoordX = person.rectCoordX
        if pedRowCtr == 1:
            rootDadRectCoordX = person.rectCoordX
        

        # print (person. rectCoordX)

        # person.startCol = (2**(numOfPedGensToProcess - baseRowCtr)) + ((2**(numOfPedGensToProcess - (baseRowCtr - 1)) * (rowColPos - 1)))   
        
        arr[pedRowCtr][0] = person.personID
        arr[pedRowCtr][1] = rowColPos
        pedRowCtr +=1
        
        firstRowColPos +=1
        prevRowNum = person.rowNum

    listOfPedigreePeople.sort(key=lambda x: x.rowNum) 
    # colPosForRoot = (numOfPedGensToProcess - 1) * 2
    # if colPosForRoot == 0:
      #  colPosForRoot = 200
    # colPosForRoot = (numOfPedGensToProcess - 1) * ((numOfPedGensToProcess - 1) + 0.5)
    # colPosForRoot = (arr[0][1] + arr[1][1]) / 2
    
    colPosForRoot = (rootMomRectCoordX + rootDadRectCoordX)/2
    # colPosForRoot = colPosForRoot - 100
    
    print ('rootMomRectCoordX: ' + str(rootMomRectCoordX))
    print ('rootDadRectCoordX: ' + str(rootDadRectCoordX))
    
    print ('col position for Root: ' + str(colPosForRoot))
    print ('col position for Root: ' + str((rootMomRectCoordX + rootDadRectCoordX)/2))


    # return listOfPedigreePeople
    # return multiple variables 
    return listOfPedigreePeople, colPosForRoot, numOfPedGensToProcess  #2023_0216


def getJsonForRelationsFromDict (relationType, dictRelationsData):

    objTd = dictRelationsData
    strJson =  ""
    
    # strJson += '  "spouses": [ '
    strJson += '  "' + relationType + '": [ '
    
#   strJson += '   "Siblings": [ {  "source": { "id": 31, "name": "Helen Rubin" }, "target": {"id": 32, "name": "Sam Rubin" } } ] '
#   strJson += '   } '
    
    intRelationCtr = 0
    for relations in objTd: 
        intRelationCtr += 1          
    
    relation1_ID = ""
    relation1FName = ""
    relation1LName = ""
    relation2_ID = ""
    relation2FName = ""
    relation2LName = ""
    
    intRelationLoopCtr = 0
    
    for relations in objTd: 
        relation1_ID = relations['r01_ID']
        relation1FName = relations['firstNameSource']
        relation1LName = relations['lastNameSource']
        relation2_ID = relations['r02_ID']
        relation2FName = relations['firstNameTarget']
        relation2LName = relations['lastNameTarget']
    
        # print ('sib 7: ' + spouse1LName)
    
        strJson += ' {  "source": { "id": ' + str(relation1_ID) + ', "name": "' + relation1FName + ' ' + relation1LName + '" }, "target": {"id":  ' + str(relation2_ID) + ', "name": "' + relation2FName + ' ' + relation2LName + '" } } '
        
        # {  "source": { "id": 31, "name": "Helen Rubin" }, "target": {"id": 32, "name": "Sam Rubin" } } ] '
        
        intRelationLoopCtr += 1
        
        if intRelationLoopCtr < intRelationCtr:
            strJson += ", "
    
        
    strJson += '  ] '
    # print ("sibling ----- " + strJson)

    return ( strJson )


def getSQLConn (dbase):

    config = {
        "user": "dbFlyer",
        "password": "Chronicle7Wonk!",
        "host": "localhost",
        "port": 3306,
        "database": dbase,
        "auth_plugin":"mysql_native_password"
       
    }
    try:
        c = connector.connect(**config)
        # cursor = c.cursor()
        return c
        # return cursor
    except:
        print ("connection error")
        exit(1)

