import pytest
import requests
import json

from dev.flasky.flasky import fetch_token, get_user

target_ip = "10.6.0.13"
username = "tester0"
password = "secret0"
token = fetch_token("tester0", "secret0")


def test_connection():
    res = requests.get(f"http://{target_ip}:8080/api/healthcheck")
    res = res.status_code
    expected_result = 200
    assert res == expected_result


def test_get_token():
    url = f"http://{target_ip}:8080/api/auth/token"
    res = requests.get(url, auth=(username, password))
    res = res.status_code
    expected_result = 200
    assert res == expected_result


def test_get_users():
    url = f"http://{target_ip}:8080/api/users"
    headers = {
        'Content-Type': 'application/json',
        'Token': ""
    }
    res = requests.get(url, headers=headers)
    print(res.text)
    res = res.status_code
    expected_result = 200
    assert res == expected_result


@pytest.mark.parametrize(
    "args, expected_result",
    [
        (("tester0", "secret0"), 200),
        (("tester0", ""), 401),
        (("unknown", "secret0"), 412),
    ])
def test_get_user(args, expected_result):
    res = get_user(*args)
    assert res == expected_result

