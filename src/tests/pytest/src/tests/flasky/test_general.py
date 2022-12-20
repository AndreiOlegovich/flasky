import pytest
import requests
import json

from dev.flasky.flasky import fetch_token, get_user, get_users, create_user, update_user

target_ip = "10.6.0.13"
username = "tester0"
password = "secret0"
token = fetch_token("tester0", "secret0")


def test_connection():
    res = requests.get(f"http://{target_ip}:8080/healthy")
    res = res.status_code
    expected_result = 200
    assert res == expected_result


def test_get_token():
    url = f"http://{target_ip}:8080/api/auth/token"
    res = requests.get(url, auth=(username, password))
    res = res.status_code
    expected_result = 200
    assert res == expected_result

@pytest.mark.skip(reason="known failure")
@pytest.mark.parametrize(
    "args, expected_result",
    [
        (("tester0", "secret0"), 200),
        (("tester0", ""), 401),
        (("unknown", "secret0"), 401),
    ])
def test_get_users(args, expected_result):
    res = get_users(*args)
    assert res == expected_result


@pytest.mark.parametrize(
    "args, expected_result",
    [
        (("tester0", "secret0"), 200),
        (("tester0", ""), 401),
        (("unknown", "secret0"), 401),
    ])
def test_get_user(args, expected_result):
    res = get_user(*args)
    assert res == expected_result



user1 = {
        "username": "icurie",
        "password": "IrenSecret",
        "firstname": "Iren",
        "lastname": "Curie",
        "phone": "22222"
        }
user2 = {
        "username": "rfeynman",
        "password": "decay",
        "lastname": "Feynman",
        "phone": "000"
}


@pytest.mark.parametrize(
    "user, expected_result",
    [
        pytest.param(user1, 201, id="new user"),
        pytest.param(user1, 400, id="duplicate user"),
        pytest.param(user2, 400, id="missing firstname"),
    ])
def test_create_user(user, expected_result):
    res = create_user(user)
    assert res == expected_result


def test_update_user():
    res = update_user("tester0", "secret0")
    expected_result = 201
    assert res == expected_result
