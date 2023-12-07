import random
from robot.api import logger
import utils


CREDENTIALS = ["username", "password", "firstname", "lastname", "phone"]


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


def select_credentials_to_delete():
    creds = CREDENTIALS

    # How many credentials to delete (min 2)
    num = random.randint(2, len(creds) - 1)
    creds_to_delete = []

    # Index of first credential to be deleted
    j = random.randint(0, len(creds) - 1)

    i = 0
    while i < num:
        while creds[j] in creds_to_delete:
            j = random.randint(0, len(creds) - 1)
        creds_to_delete.append(creds[j])
        logger.info(i)
        i += 1
        logger.info(i)

    return creds_to_delete


def spoil_user(user: dict, attrs):
    if isinstance(attrs, str):
        attrs = [attrs]
    elif isinstance(attrs, list):
        pass
    else:
        raise TypeError()

    logger.info(attrs)
    filter = CREDENTIALS
    attrs_to_remove = [k for k in attrs if k in filter]
    logger.info(attrs_to_remove)
    for attr in attrs_to_remove:
        user[attr] = ""

    return user
