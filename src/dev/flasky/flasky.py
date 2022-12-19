import requests
import json

target_ip = "10.6.0.13"
username = "tester0"
password = "secret0"


def fetch_token(username, password):

    url = f"http://{target_ip}:8080/api/auth/token"
    res = requests.get(url, auth=(username, password))
    print(res.text)
    print(type(res))
    try:
        token = (res.json()["token"])
    except KeyError as e:
        token = None
    print(token)
    return token


def get_users():
    token = fetch_token("tester0", "secret0")
    url = f"http://{target_ip}:8080/api/users"
    headers = {
        'Content-Type': 'application/json',
        'Token': token 
    }
    res = requests.get(url, headers=headers)
    print(res.text)
    

def get_user(username, password):
    token = fetch_token(username, password)
    url = f"http://{target_ip}:8080/api/users/{username}"
    headers = {
        'Content-Type': 'application/json',
        'Token': token
    }
    res = requests.get(url, headers=headers)
    print(res.text)
    status = res.status_code
    print(status)

    return status


def update_user(username, password):
    token = fetch_token(username, password)
    url = f"http://{target_ip}:8080/api/users/{username}"
    headers = {
        'Content-Type': 'application/json',
        'Token': token
    }
    payload = {
        "firstname": "Nikolai",
        "lastname": "Basov"
    }
    res = requests.put(url, headers=headers, data=payload)
    print(res.text)
    status = res.status_code
    print(status)

    return status


if __name__ == '__main__':
    # fetch_token("tester0", "secret0")
    # get_users()
    get_user("tester0", "secret0")
    # get_user("tester0", "")
    # get_user("unknown", "secret0")
    # update_user("tester1", "secret1")
    # get_user("tester1", "secret1")
