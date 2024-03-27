
class Person:
    def __init__(self):
        self.__treeID=0
        self.__personID=0
        self.__firstName=''
        self.__middleName=''
        self.__lastName=''
        self.__name=''     
        self.__gender=''  
        self.__dobYear=0 
        self.__relationType=''
        self.__relationID=0 
        self.__blood=-1         
        self.__motherID=0
        self.__fatherID=0
        self.__rootFlag=0
        self.__children={}
        self.__childrenList=[]
        self.__siblings={}
        self.__siblingsList=[]
        self.__spousesList=[]
        self.__spousesColCountList=[]     
        self.__mothersList=[]   
        self.__fathersList=[]    
        self.__allInTreeList=[]    
        self.__relationType=''
        self.__relationTypeDetail=''
        self.__pedigreeRoot = -1
        self.__genderOfRootRelative = ''
        self.__rowNum = -1
        self.__rootFamilyNum = -1
        self.__familyID = ''
        self.__matrixNode = ''
        self.__colsNeeded = 0
        self.__startCol = 0
        self.__rectCoordX = 0 
        self.__numberOfPedGens = 0 
        self.__endCol = 0
        self.__colOrder = -1
        self.__nukeFamilyStartCol = -1
        self.__nukeFamilyEndCol = -1
        self.__siblingOrder = -1
        self.__spouseCount=-1
        self.__spouseNumber=-1
        self.__nonPedParentSpouseNumber=-1
        self.__childrenCount=-1

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
    def rootFlag(self):
        return self.__rootFlag

    @rootFlag.setter
    def rootFlag(self, value):
        self.__rootFlag=value

    @rootFlag.deleter
    def rootFlag(self, value):
        del self.__rootFlag


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
    def spousesColCountList(self):
        return self.__spousesColCountList

    @spousesColCountList.setter
    def spousesColCountList(self, value):
        self.__spousesColCountList=value

    @spousesColCountList.deleter
    def spousesColCountList(self, value):
        print('Deleting..')
        del self.__spousesColCountList

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

class TreeCell:
    def __init__(self):
        self.__genNum=-999
        self.__cellID=-999
        self.__data=-999
