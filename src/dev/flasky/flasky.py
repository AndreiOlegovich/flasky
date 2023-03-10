import requests

target_ip = "10.6.0.13"
username = "tester0"
password = "secret0"


def fetch_token(username, password):

    url = f"http://{target_ip}:8080/api/auth/token"
    res = requests.get(url, auth=(username, password))
    try:
        token = (res.json()["token"])
    except KeyError:
        token = None
    return token


def get_users(username, password):
    token = fetch_token(username, password)
    url = f"http://{target_ip}:8080/api/users"
    headers = {
        'Content-Type': 'application/json',
        'Token': token
    }
    res = requests.get(url, headers=headers)
    print(res.text)
    status = res.status_code
    print(status)

    return status


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


def create_user(user: dict) -> int:
    token = fetch_token("tester0", "secret0")
    url = f"http://{target_ip}:8080/api/users"
    headers = {
        'Content-Type': 'application/json',
        'Token': token
    }
    res = requests.post(url, headers=headers, json=user)
    print(res.text)
    status = res.status_code
    print(status)

    return status


def update_user(old_username: str, old_password: str, **kwargs) -> int:
    token = fetch_token(old_username, old_password)
    url = f"http://{target_ip}:8080/api/users/{old_username}"
    headers = {
        "Content-Type": "application/json",
        "Token": token
    }
    filters = ["username", "password", "firstname", "lastname", "phone"]
    payload = {k: kwargs.get(k) for k in filters if kwargs.get(k)}
    res = requests.put(url, headers=headers, json=payload)
    print(res.text)
    status = res.status_code
    print(status)

    return status


if __name__ == '__main__':
    fetch_token("tester0", "secret0")
    get_users("tester0", "secret0")
    # get_users("tester0", "")
    # get_users("unknown", "secret0")
    # get_user("tester0", "secret0")
    # get_user("tester0", "")
    # get_user("unknown", "secret0")
    # update_user("tester1", "secret1")
    # get_user("tester1", "secret1")
    # update_user("tester0", "secret0")
