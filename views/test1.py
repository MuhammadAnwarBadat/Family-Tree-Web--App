
import mysql.connector as connector 


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
