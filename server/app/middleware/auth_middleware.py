from fastapi import HTTPException, Header
import jwt
from ..config import SECRET_KEY, ALGORITHM

def auth_middleware(x_auth_token : str = Header(...)):
    if not x_auth_token: 
        raise HTTPException(401, 'No auth token, access denied!')
    #decode the token
    try:
        verified_token = jwt.decode(x_auth_token, SECRET_KEY, algorithms=[ALGORITHM])
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail='Token expired')
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail='Invalid token')
    
    #get the id from the token
    uid = verified_token.get('id')
    if not uid:
        raise HTTPException(status_code=401, detail='Invalid token payload')
    
    return {'uid': uid, 'token': x_auth_token}