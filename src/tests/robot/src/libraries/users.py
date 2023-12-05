import random
import utils


def generate_phone():
    return str(random.randint(100000000, 999999999))


def generate_user() -> dict:
    ending = utils.str_uuid()
    phone = generate_phone()
    user = {
       "username": "Username" + ending,
       "password": "Password" + ending,
       "firstname": "Firstname" + ending,
       "lastname": "Lastname" + ending,
       "phone": phone
    }

    return user

def spoil_user(user: dict, attr: str):
    user[attr] = ""
    return user
    
