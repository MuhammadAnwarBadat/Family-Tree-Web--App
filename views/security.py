import bcrypt


def hash_password(pw):
    pwhash = bcrypt.hashpw(pw.encode('utf8'), bcrypt.gensalt())
    return pwhash.decode('utf8')

def check_password(pw, hashed_pw):
    print ('def check pwd')
    expected_hash = hashed_pw.encode('utf8')
    return bcrypt.checkpw(pw.encode('utf8'), expected_hash)


USERS = {'editor': hash_password('editor3'),
         'susan': hash_password('puffins'),
         'resharpe@gmail.com': hash_password('msharp3'),
         'sherman.se@gmail.com': hash_password('puffins'),
         'Saifullah': hash_password('Ronde2lee8'),
         'viewer': hash_password('viewer7')}
         
GROUPS = {'editor': ['group:editors'],
	  'susan': ['group:editors'],
	  'resharpe@gmail.com': ['group:editors'],
	  'sherman.se@gmail.com': ['group:editors'],
      'Saifullah': ['group:editors']}
 
def groupfinder(userid, request):
    if userid in USERS:
        return GROUPS.get(userid, [])
