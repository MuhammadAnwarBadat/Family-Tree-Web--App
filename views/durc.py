from pyramid.view import view_config
from pyramid.response import Response
# from pyramid.httpexceptions import HTTPFound

import cgi, os, shutil
import cgitb; cgitb.enable()
import re


import datetime

import json 

# from time import gmtime, strftime

from datetime import datetime

import sys
sys.path.append('/usr/local/lib/python3.9/dist-packages')

import mysql.connector as connector


from pyramid.httpexceptions import (
    HTTPForbidden,
    HTTPFound,
  	  HTTPNotFound,
    )

class Person:
    def __init__(self):
        self.__treeID=0
        self.__personID=0
        self.__firstName=''
        self.__middleName=''
        self.__lastName=''
        self.__name=''     
        self.__gender=''     
        self.__motherID=0
        self.__fatherID=0
        self.__children={}
        self.__childrenList=[]
        self.__siblings={}
        self.__siblingsList=[]
        ## self.__spouses={}
        self.__spousesList=[]   
        self.__mothersList=[]   
        self.__fathersList=[]    
        self.__allInTreeList=[]    
                    
        self.__relationType=''
        self.__relationTypeDetail=''
        self.__pedigreeRoot = -1
        self.__genderOfRootRelative = ''
        self.__genderOfBaseRelative = ''


    @property
    def name(self):
        return self.__name

    @name.setter
    def name(self, value):
        self.__name=value

    @name.deleter
    def name(self, value):
        print('Deleting..')
        del self.__name
    
    @property
    def motherID(self):
        return self.__motherID

    @motherID.setter
    def motherID(self, value):
        self.__motherID=value

    @motherID.deleter
    def motherID(self, value):
        print('Deleting..')
        del self.__motherID

    @property
    def children(self):
        return self.__children

    @children.setter
    def children(self, value):
        self.__children=value

    @children.deleter
    def children(self, value):
        print('Deleting..')
        del self.__children
 
    @property
    def childrenList(self):
        return self.__childrenList

    @childrenList.setter
    def childrenList(self, value):
        self.__childrenList=value

    @childrenList.deleter
    def childrenList(self, value):
        print('Deleting..')
        del self.__childrenList

    @property
    def spouses(self):
        return self.__spouses

    @spouses.setter
    def spouses(self, value):
        self.__spouses=value

    @spouses.deleter
    def spouses(self, value):
        print('Deleting..')
        del self.__spouses

    @property
    def spousesList(self):
        return self.__spousesList

    @spousesList.setter
    def spousesList(self, value):
        self.__spousesList=value

    @spousesList.deleter
    def spousesList(self, value):
        print('Deleting..')
        del self.__spousesList

    @property
    def siblingsList(self):
        return self.__siblingsList

    @siblingsList.setter
    def siblingsList(self, value):
        self.__siblingsList=value

    @siblingsList.deleter
    def siblingsList(self, value):
        print('Deleting..')
        del self.__siblingsList

    @property
    def mothersList(self):
        return self.__mothersList

    @mothersList.setter
    def mothersList(self, value):
        self.__mothersList=value

    @mothersList.deleter
    def mothersList(self, value):
        print('Deleting..')
        del self.__mothersList

    @property
    def fathersList(self):
        return self.__fathersList

    @fathersList.setter
    def fathersList(self, value):
        self.__fathersList=value

    @fathersList.deleter
    def fathersList(self, value):
        print('Deleting..')
        del self.__fathersList


@view_config(route_name='addTree', renderer='kw03:templates/addTree.mako', permission='edit')
def addTree_view(request):

# , permission=edit'		
    # this code is retrieving the query string parameters(qsps) for the addTree url
    # the qsps will need to be changed here to work with addTree 

    # , permission='edit'

    strUser =  request.authenticated_userid
    print (strUser)

    strSQL_final = "call getUserData('" + strUser + "')"

	# open a database connection
    # cursor = getSQLConn() 
    
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
   
    cursor.execute(strSQL_final)    
	
    rowsReturned = 0
	          
    try:
         items = [dict(uid=strUser, id=row[0], firstName = row[1], lastName=row[2]) for row in cursor.fetchall()]
                # print (row[0])
         for row in items:
                rowsReturned = rowsReturned + 1
                print (rowsReturned)
               # rowsReturned = 1
    except: 
         print ("user not found")
         items = [dict(uid=strUser,id=0, firstName = "", lastName="")]
   
    return {'items': items}

@view_config(route_name='addTreeInsert')
def addTreeInsert_view(request):
    
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    
    treeName =  request.POST['treeName'];
    treeDescrip =  request.POST['treeDescrip'];
	
    strUser =  request.authenticated_userid
    personFirstName = request.POST['firstName']
    personLastName = request.POST['lastName']
    gender = request.POST['genderB']

    strSQL = ""
    newTreeID = 0
	
    args = [treeName, treeDescrip, strUser, personFirstName,  personLastName, gender, strUser, strUser, 1, newTreeID]

    if request.method == 'POST':

		# strSQL = "call addTree3('" + treeName + "', '" + treeDescrip + "', '" + "adm" + "', '" + personFirstName + "', '" + personLastName + "', '" +  "adm" +  "', '" + "adm" + "', " + "1" + ", " + "0" + ")"
		
        result_args = cursor.callproc('addTree3', args)
        
        print(result_args[9])
        newTreeID = result_args[9]
              
    return HTTPFound(location= request.application_url + '/smallTreeView?tid=' + str(newTreeID))
    
    # return HTTPFound(location='http://vagrantvectors.com/smallTreeView?tid=' + str(newTreeID))   

@view_config(route_name='selectRelTypeToAdd', renderer='kw03:templates/addPersonSelectRelType.mako')
def selectRelTypeToAdd_view(request):
     
    print(4572)

    try:
        pid = request.GET.getall('pid')
        strPid= pid[0]
    except:
        strPid =""

    try:
        tid = request.GET.getall('tid')
        strTid= tid[0]
    except:
        strTid =""

    try:
        rid = request.GET.getall('rid')
        strRid= rid[0]
    except:
        strRid =""

 
    print("Value of StrPID: " + strPid)

    # strSQL_final = "CALL getPersonforUpdate2(" + strPid + ")"
    strSQL_final = "CALL getPersonforUpdate2(" + strPid + "," + "0" + ")"


    #open a database connection
    print("Value of StrPID: " + strPid)
    
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
        
    # db = getSqlDb('gen30')
    # cursor = db.cursor()

    cursor.execute(strSQL_final)

    person = Person()
    person.personID = strPid
 
    rows = cursor.fetchall()
    
    # rows = cursor.fetchone()
    print('hey 88')
    # print(rows)
    for row in rows:
        strID = row[0]   
        person.firstName = row[1]
        person.middleName = row[2]
        person.lastName = row[3]
        person.nee = row[4]
        person.dobYear = row[5]
        if row[6] != None:
            person.dob =  datetime.date.strftime(row[6], "%m/%d/%Y")
        else:
            person.dob = None # '1926-02-03'
        person.dobExactOrEst = row[7]
        person.dodYear = row[8]
        # person.dod = row[9]
        if row[9] != None:
            person.dod =  datetime.date.strftime(row[9], "%m/%d/%Y")
        else:
            person.dod= None # '1926-02-03'
        person.dodExactOrEst = row[10]
        person.placeOfBirth = row[11]
        person.placeOfDeath = row[12]
        person.gender = row[13]
        person.genderAtBirth = row[14]
        varDateCreated = row[15]
        varDateUpdated = row[16]
        varCreatedBy = row[17]
        varUpdatedBy = row[18]
        person.photoDescrip = row[19]
        person.genderOfRootRelative = ''  #2023_0225 added 
    
        getRelatives(person)
        # print(person.dob)
        
        items = [dict(tid=strTid, rid=strRid, id=strID, firstName=person.firstName, middleName=person.middleName, lastName=person.lastName, nee=person.nee, dobYear=person.dobYear, dob=person.dob,  dobExactOrEst='', dodYear=person.dodYear, dod=person.dod, dodExactOrEst=person.dodExactOrEst, placeOfBirth=person.placeOfBirth, placeOfDeath=person.placeOfDeath, gender=person.genderOfRootRelative, genderAtBirth=person.genderAtBirth, mothers=person.mothersList,  fathers=person.fathersList, children = person.childrenList, siblings = person.siblingsList, spouses = person.spousesList, dateCreated=varDateCreated, dateUpdated=varDateUpdated, createdBy=varCreatedBy, updatedBy=varUpdatedBy, photoDescrip = person.photoDescrip) ]
    
    return {'items':items}


@view_config(route_name ='deletePerson', permission = 'edit')
def deletePerson(request):

#, permission = 'edit'

    try:
        pid = request.GET.getall('pid')
        strPid= pid[0]
    except:
        strPid =""
    
    try:
        tid = request.GET.getall('tid')
        strTid= tid[0]
    except:
        strTid =""
    
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()

    pargs = (strPid, 0)
    
    cursor.callproc('deletePerson2', pargs)
    
    return HTTPFound(location= request.application_url + '/smallTreeView?tid=' + strTid) 

@view_config(route_name ='addPerson02',renderer ='kw03:templates/addPerson02.mako', permission='edit')
def addPerson02_view(request):

#, permission = 'edit'

    try:
        tid = request.GET.getall('tid')
        strTid= tid[0]
    except:
        strTid =""

    try:
        pid = request.GET.getall('pid')
        strPid= pid[0]
    except:
        strPid =""

    try:
        rid = request.GET.getall('rid')
        strRid= rid[0]
    except:
        strRid ="0"

    print("Value of StrPID: " + strPid)

    # strSQL_final = "CALL getPersonforUpdate2(" + strPid + ")"
    strSQL_final = "CALL getPersonforUpdate2(" + strPid + "," + "0" + ")"

    #open a database connection
    print("Value of StrPID: " + strPid)
    
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
        
    # db = getSqlDb('gen30')
    # cursor = db.cursor()

    cursor.execute(strSQL_final)

    person = Person()
    person.personID = strPid
 
    rows = cursor.fetchall()
    
    # rows = cursor.fetchone()
    # print(rows)
    for row in rows:
        strID = row[0]   
        person.firstName = row[1]
        person.middleName = row[2]
        person.lastName = row[3]
        person.nee = row[4]
        person.dobYear = row[5]
        if row[6] != None:
            # person.dob =  datetime.date.strftime(row[6], "%m/%d/%Y")
            person.dob =  datetime.strftime(row[6], "%m/%d/%Y")
        else:
            person.dob = None # '1926-02-03'
        person.dobExactOrEst = row[7]
        person.dodYear = row[8]
        # person.dod = row[9]
        if row[9] != None:
            # person.dod =  datetime.date.strftime(row[9], "%m/%d/%Y")
            person.dod =  datetime.strftime(row[9], "%m/%d/%Y")

        else:
            person.dod= None # '1926-02-03'

        person.dodExactOrEst = row[10]
        person.placeOfBirth = row[11]
        person.placeOfDeath = row[12]
        person.gender = row[13]
        person.genderAtBirth = row[14]
        # person.genderOfRootRelative = row[13]
        person.genderOfBaseRelative = row[13]
        print('gender base: ' + person.genderOfBaseRelative)
        varDateCreated = row[15]
        varDateUpdated = row[16]
        varCreatedBy = row[17]
        varUpdatedBy = row[18]
        person.photoDescrip = row[19]
         
    getRelatives(person)
    # print(person.dob)

    # person.genderOfRootRelative = person.gender
   # genderOfRootRelative

    # rid
    strPedigreeRoot = "0"
    items = [dict(tid=strTid, id=strID, relationID = strRid, relationGender = 'X', pedigreeRoot = strPedigreeRoot, firstName = person.firstName, lastName = person.lastName, genderOfBaseRelative=person.genderOfBaseRelative, mothers = person.mothersList, fathers = person.fathersList, children = person.childrenList, siblings = person.siblingsList, spouses = person.spousesList)]
    
    '''
    items = [dict(tid=strTid, relationID=strRid, id=strID, firstName=person.firstName, middleName=person.middleName, lastName=person.lastName, nee=person.nee, dobYear=person.dobYear, dob=person.dob,  dobExactOrEst='', dodYear=person.dodYear, dod=person.dod, dodExactOrEst=person.dodExactOrEst, placeOfBirth=person.placeOfBirth, placeOfDeath=person.placeOfDeath, gender=person.genderOfRootRelative, genderAtBirth=person.genderAtBirth, mothers=person.mothersList,  fathers=person.fathersList, children = person.childrenList, siblings = person.siblingsList, spouses = person.spousesList, dateCreated=varDateCreated, dateUpdated=varDateUpdated, createdBy=varCreatedBy, updatedBy=varUpdatedBy, photoDescrip = person.photoDescrip) ]
    '''

    return {'items':items}


def analyzePerson (person):


	# person.lastName = 'Jones'

	if person.relationType == 'sibling':
		# person.childrenList.delete
		del person.childrenList[0 : 25] 

	if person.relationType == 'spouse':
		# person.childrenList.delete
		del person.mothersList[0 : 25] 
		del person.fathersList[0 : 25] 
		del person.siblingsList[0 : 25] 


	if person.relationType == 'child':
		pass	

	return person           


# @view_config(route_name='updateG30Person')
# def updateG30Person(request):
@view_config(route_name='addPersonCommit')
def addPersonCommit(request):
    
    # used to commit adding a new person

    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    
    upsertType=request.POST['upsertType']
    personID = "0";
    treeID=request.POST['tid']  
    relationID = request.POST['relationID']
    additionalRelativesToAdd = request.POST['nameInputAllRelatives']

    relationType = request.POST['relationType']
    # genderOfRelation = request.POST['genderOfRelation']
    genderOfRelation = request.POST['genderOfBasePersonToWhomRelBeingAdded']
    
    pedigreeRoot = request.POST['pedigreeRoot']
    personLastName = request.POST['lastName']
    personFirstName = request.POST['firstName']
    personMiddleName = request.POST['middleName']
    personNeeName = request.POST['nee']
    dobYear = request.POST['yob']
    if dobYear == "":
        dobYear = "0"
    dob = request.POST['dob']
    # dob2 = ''
    if dob == "" or dob == "None":
        dob=None

    # else:
    #     # dob2 =  datetime.date.strftime(dob, "%m/%d/%Y")    
    #     date_str = dob
    #     date_format = '%m/%d/%Y'

    #     dob2 = datetime.strptime(date_str, date_format)
    #     print(dob2)


    yobExactOrEst = request.POST['yobExactOrEst']
    print ("************ YOB exact or est: " + 	yobExactOrEst)
    print ("then more....")
    dodYear = request.POST['yod']
    if dodYear == "":
        dodYear = "0"
    dod = request.POST['dod']
    if dod == "" or dod == "None":
        dod=None
    
    print ('dod: ')
    print (dod)
   
    yodExactOrEst = request.POST['yodExactOrEst']

    gender = request.POST['genderB']
    genderAtBirth = request.POST['genderAtBirth']

    placeOfBirth = request.POST['placeOfBirth']
    placeOfDeath = request.POST['placeOfDeath']

    additionalRelativesToAddParam = deriveRelativesToAddParams (additionalRelativesToAdd, relationType, gender)


    strSQL = ""
    print('******************')
    print (additionalRelativesToAddParam)
    print('******************')
 
    if request.method == 'POST':

        # strSQL = "call upsertPerson9('" + upsertType + "', " + treeID + ", " + pedigreeRoot + ", " + relationID +  ", '" +  genderOfRelation +  "' , '" + relationType +  "', '" + personFirstName + "', '" + personMiddleName + "', '" + personLastName + "', '" + personNeeName  +  "', '" + genderAtBirth + "', '" + gender + "', " + dobYear + ", " + "dob" + ", '" + yobExactOrEst + "', " + dodYear + ", '"  + "dod"  + "', '" +  yodExactOrEst + "', '" + placeOfBirth + "', '" + placeOfDeath + "', '" + additionalRelativesToAddParam + "', 'adm', 'adm'" + ")"

        print (strSQL)			

        print (upsertType + ' ' + str(treeID) + ' ' +  pedigreeRoot + ' ' +  str(relationID) + ' ' +  genderOfRelation + ' ' +  relationType + ' ' +  personFirstName + ' ' +  personMiddleName + ' ' +  personLastName + ' ' +   personNeeName + ' ' +  genderAtBirth + ' ' +  gender + ' ' +    placeOfBirth + ' ' +  placeOfDeath + ' ' +   additionalRelativesToAddParam + ' ' +  'adm' + ' ' +  'adm')

        pargs = (upsertType, treeID, pedigreeRoot, relationID, genderOfRelation, relationType, personFirstName, personMiddleName, personLastName,  personNeeName, genderAtBirth, gender, dobYear, dob, yobExactOrEst,  dodYear, dod, yodExactOrEst, placeOfBirth, placeOfDeath,  additionalRelativesToAddParam, 'adm', 'adm')
        
        # result_args = cursor.callproc('upsertPerson9', pargs)
        cursor.callproc('upsertPerson9', pargs)

        # cursor.execute(strSQL)    

    return HTTPFound(location= request.application_url + '/smallTreeView?pid=' + relationID +'&tid='+treeID) 

def deriveRelativesToAddParams (additionalRelativesToAdd, rootRelationType, gender):

	# person.lastName = 'Jones'

	relativesToAddParam = ''
	delimiter = ''
	
	listRelatives = additionalRelativesToAdd.split(';')	
		
	for relative in listRelatives: 
		ridStart = relative.find('|') 
		rType = relative[0:ridStart]
		rId = relative[ridStart + 1:]

		rtMapped = mapRelationType(rType)
		print ('eqerqwre: ' + rtMapped)

		if relativesToAddParam != '':
			delimiter = ';'

		# left off 		
		'''
		if (rType == 'mom' or rType == 'dad')  and rootRelationType != 'sibling':
			relativesToAddParam += delimiter + rtMapped + '|' + '1' + '|' + str(rId) 
			relativesToAddParam += ';' + 'child' + '|' + '2' + '|' + str(rId) 
		'''
		
		if (rType == 'mom' or rType == 'dad') and (rootRelationType == 'sibling' or rootRelationType == 'child'):
			relativesToAddParam += delimiter + 'child' + '|' + '1' + '|' + str(rId) 
			relativesToAddParam += ';' + rtMapped + '|' + '2' + '|' + str(rId) 

		if rType == 'sib' and (rootRelationType == 'mother' or rootRelationType == 'father'):
			relativesToAddParam += delimiter + rootRelationType + '|' + '1' + '|' + str(rId) 
			relativesToAddParam += ';' + 'child' + '|' + '2' + '|' + str(rId) 

		if rType == 'sib' and (rootRelationType == 'sibling' or rootRelationType == 'child'):
			relativesToAddParam += delimiter + 'sibling' + '|' + '1' + '|' + str(rId) 
			relativesToAddParam += ';' + 'sibling' + '|' + '2' + '|' + str(rId) 
		
		if rType == 'spouse':
			relativesToAddParam += delimiter + 'spouse' + '|' + '1' + '|' + str(rId) 
			relativesToAddParam += ';' + 'spouse' + '|' + '2' + '|' + str(rId) 

		if rType == 'kid':
						
			if gender == 'F':
				parentType = 'mother'		

			if gender == 'M':
				parentType = 'father'		

			if rootRelationType == 'spouse':
				relativesToAddParam += delimiter + parentType + '|' + '1' + '|' + str(rId) 
				relativesToAddParam += ';' + 'child' + '|' + '2' + '|' + str(rId) 
			else:
				relativesToAddParam += delimiter + parentType + '|' + '1' + '|' + str(rId) 
				relativesToAddParam += ';' + 'child' + '|' + '2' + '|' + str(rId) 
                # relativesToAddParam += delimiter + 'child' + '|' + '1' + '|' + str(rId) 
				# relativesToAddParam += ';' + parentType + '|' + '2' + '|' + str(rId) 
							
			
		print ('derive: ' + str(rId))

	return relativesToAddParam


def mapRelationType (rType):
	switcher = { 
		"mom": "mother", 
		"dad": "father", 
		"sib": "sibling", 
	}

	return (switcher.get(rType,"not found"))


@view_config(route_name ='updatePerson',renderer ='kw03:templates/updatePerson.mako', permission='edit')
def updatePerson_view(request):

    try:
        pid = request.GET.getall('pid')
        strPid= pid[0]
    except:
        strPid =""

    try:
        tid = request.GET.getall('tid')
        strTid= tid[0]
    except:
        strTid =""

    try:
        rid = request.GET.getall('rid')
        strRid= rid[0]
    except:
        strRid =""

 
    print("Value of StrPID: " + strPid)

    # strSQL_final = "CALL getPersonforUpdate2(" + strPid + ")"
    strSQL_final = "CALL getPersonforUpdate2(" + strPid + "," + "0" + ")"


    #open a database connection
    print("Value of StrPID: " + strPid)
    
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
        
    # db = getSqlDb('gen30')
    # cursor = db.cursor()

    cursor.execute(strSQL_final)

    person = Person()
    person.personID = strPid
 
    rows = cursor.fetchall()
    
    # rows = cursor.fetchone()
    print('hey 88')
    # print(rows)
    for row in rows:
        strID = row[0]   
        person.firstName = row[1]
        person.middleName = row[2]
        person.lastName = row[3]
        person.nee = row[4]
        person.dobYear = row[5]
        if row[6] != None:
            person.dob =  datetime.strftime(row[6], "%m/%d/%Y")
            # date_time = now.strftime("%m/%d/%Y, %H:%M:%S")
            # print("date and time:",date_time)
            # person.dob =  strftime(str(row[6]), "%m/%d/%Y")
            # person.dob =  datetime.strptime(str(row[6]), "%m/%d/%Y")
        else:
            person.dob = None # '1926-02-03'
        person.dobExactOrEst = row[7]
        person.dodYear = row[8]
        # person.dodYear = 1886
        
        # person.dod = row[9]
        if row[9] != None:
            person.dod =  datetime.strftime(row[9], "%m/%d/%Y")
            # person.dod =  datetime.date.strftime(row[9], "%m/%d/%Y")
        else:
            person.dod= None # '1926-02-03'
        person.dodExactOrEst = row[10]
        person.placeOfBirth = row[11]
        person.placeOfDeath = row[12]
        person.gender = row[13]
        person.genderAtBirth = row[14]
        varDateCreated = row[15]
        varDateUpdated = row[16]
        varCreatedBy = row[17]
        varUpdatedBy = row[18]
        person.photoDescrip = row[19]
        person.genderOfRootRelative = person.gender  #''  #2023_0225 added 
        print ('gender: ' + person.gender)

    getRelatives(person)
    # print(person.dob)
       
    items = [dict(tid=strTid, rid=strRid, id=strID, firstName=person.firstName, middleName=person.middleName, lastName=person.lastName, nee=person.nee, dobYear=person.dobYear, dob=person.dob,  dobExactOrEst='', dodYear=person.dodYear, dod=person.dod, dodExactOrEst=person.dodExactOrEst, placeOfBirth=person.placeOfBirth, placeOfDeath=person.placeOfDeath, gender=person.genderOfRootRelative, genderAtBirth=person.genderAtBirth, mothers=person.mothersList,  fathers=person.fathersList, children = person.childrenList, siblings = person.siblingsList, spouses = person.spousesList, dateCreated=varDateCreated, dateUpdated=varDateUpdated, createdBy=varCreatedBy, updatedBy=varUpdatedBy, photoDescrip = person.photoDescrip) ]
   
    return {'items':items}

@view_config(route_name='updatePersonCommit')
def updatePersonCommit(request):
   	
    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
     
    try:
        tid = request.GET.getall('tid')
        strTid  =  tid[0]					
    except: 
        strTid = ""

    tid=request.POST['tid']
    pid= request.POST['pid']
    rid= request.POST['pid']

    personLastName = request.POST['lastName']
    personFirstName = request.POST['firstName']
    personMiddleName = request.POST['middleName']
    personNeeName = request.POST['nee']
    dobYear = request.POST['yob']
    if dobYear == "":
        dobYear = "0"
    dob = request.POST['dob']
    if dob == "" or dob == "None":
        dob=None
    # dob="null"

    print ('dob:' + str(dob) )

    yobExactOrEst = request.POST['yobExactOrEst']
    print ("************ YOB exact or est: " + 	yobExactOrEst)
    print ("then more....")
    dodYear = request.POST['yod']
    if dodYear == "":
        dodYear = "0"
    
    print('dod year: ')
    print(dodYear)
    
    # dodYear = 1886
    
    dod = request.POST['dod']
    if dod == "" or dod == "None":
        dod=None

    yodExactOrEst = request.POST['yodExactOrEst']

    gender = request.POST['genderB']
    genderAtBirth = request.POST['genderAtBirth']

    placeOfBirth = request.POST['placeOfBirth']
    placeOfDeath = request.POST['placeOfDeath']

    photoAndDescrip = ''
    # photoAndDescrip = request.POST['photoDescrip']
    # photoAndDescrip = re.sub("'", " ",photoAndDescrip)
    # print ('photo d2: ' + photoAndDescrip)

    strSQL = ""

    if request.method == 'POST':

        pargs = (pid, personFirstName, personMiddleName, personLastName, personNeeName, genderAtBirth, gender, dobYear, dob, yobExactOrEst,  dodYear, dod, yodExactOrEst, placeOfBirth, placeOfDeath, photoAndDescrip, 'adm')
        
        result_args = cursor.callproc('upsertPerson4', pargs)
	
    return HTTPFound(location= request.application_url + '/smallTreeView?pid=' + rid +'&tid='+tid)  # ?pid='+rid

def getRelatives (person):

    cn = getSQLConn('gen30') 
    cursor = cn.cursor()
    
    strSQL = "call relativesGet02(" + person.personID + ")"

    print (strSQL)			
    cursor.execute(strSQL)    
    
    rows = cursor.fetchall();

    strSpouse = ""
    strChildren = ""
    strSiblings = ""
    strMother = ""
    strFather = ""
    strGenderRootRelative = ""

    rowCtr = 0
    for row in rows:
         # print (row[2][0])
        strFullName = row[3] + " " + row[4]
        
        # strGenderRootRelative = row[7]
        # person.genderOfRootRelative = row[7]

        if row[0] == "mother":
            # strSpouse = strFullName
            print ('mom 77')
            mother5 = {'name': strFullName, 'pid': str(row[2]), 'gender': row[5]}
            person.mothersList.append(mother5)
            print (person.mothersList[0]['name'])

        if row[0] == "father":
            father5 = {'name': strFullName, 'pid': str(row[2]), 'gender': row[5]}
            person.fathersList.append(father5)

        if row[0] == "spouse":
            strSpouse = strFullName
            print ('spouses 77')
            spouse5 = {'name': strFullName, 'pid': str(row[2]), 'gender': row[5]}
            person.spousesList.append(spouse5)
            print (person.spousesList[0]['name'])
            # person.spouses = '{"spouseID":' + '"7"' 

        if row[0] == "child":
            print ('child 778')
            child5 = {'name': strFullName, 'pid': str(row[2]), 'gender': row[5]}
            person.childrenList.append(child5)
            print ("child " + str(rowCtr+1) + ": " + person.childrenList[rowCtr]['name'])

            if strChildren == "" :
                strChildren = strFullName
            else:
                strChildren = strChildren + ";" + strFullName

        if row[0] == "sibling":
            sib5 = {'name': strFullName, 'pid': str(row[2]), 'gender': row[5]}
            person.siblingsList.append(sib5)

            if strSiblings == "":
                strSiblings = strFullName + "||" + str(row[2])
            else:
                strSiblings = strSiblings + ";" + strFullName + "||" + row[1]

        
        rowCtr +=1

    return person   

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

