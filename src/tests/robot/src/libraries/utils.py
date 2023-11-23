import uuid
import random


def str_uuid():
    return str(uuid.uuid4())


def generate_phone():
    return str(random.randint(100000000, 999999999))


def generate_user() -> dict:
    ending = str_uuid()
    phone = generate_phone()
    user = {
       "username": "Username" + ending,
       "password": "Password" + ending,
       "firstname": "Firstname" + ending,
       "lastname": "Lastname" + ending,
       "phone": phone
    }

    return user
