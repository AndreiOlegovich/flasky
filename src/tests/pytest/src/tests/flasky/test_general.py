import pytest
import requests

from dev.flasky.flasky import (
    fetch_token, get_user, get_users, create_user, update_user)

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
        "username": "icurie2",
        "password": "IrenSecret",
        "firstname": "Iren",
        "lastname": "Curie",
        "phone": "22222"
}

user2 = {
        "username": "rfeynman2",
        "password": "decay",
        # "firstname": "Richard",
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


@pytest.mark.parametrize(
    "args, kwargs, expected_result",
    [
        pytest.param(
            ["tester0", "secret0"],
            {"firstname": "Max", "lastname": "Planck", "phone": 4444},
            201,
            id="normal update"),
        pytest.param(
            ["tester0", "secret0"],
            {"username": "tester00", "lastname": "Landau", "phone": 5555},
            403,
            id="forbidden field username"),
        pytest.param(
            ["tester0", "secret0"],
            {"password": "newpwd", "lastname": "Abrikosov", "phone": 6666},
            403,
            id="forbidden field password"),
    ])
def test_update_user(args, kwargs, expected_result):
    res = update_user(*args, **kwargs)
    assert res == expected_result
