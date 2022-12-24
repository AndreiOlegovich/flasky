import pytest
import requests
import json
import pathlib

from pathlib import Path
from dev.flasky.flasky import (
    fetch_token, get_user, get_users, create_user, update_user)


dir_path = pathlib.Path.cwd()
path = Path(dir_path, "tests", "test_data", "users.json")

with open(path, "r") as f:
    data = f.read()
    testdata = json.loads(data)

base_url = testdata["url"]
user0 = testdata["users"][0]
# user1 is used in robot but not here
user2 = testdata["users"][2]
user3 = testdata["users"][3]

token = fetch_token(user0["username"], user0["password"])


def test_connection():
    res = requests.get(f"{base_url}/healthy")
    res = res.status_code
    expected_result = 200
    assert res == expected_result


def test_get_token():
    url = f"{base_url}/api/auth/token"
    res = requests.get(url, auth=(user0["username"], user0["password"]))
    res = res.status_code
    expected_result = 200
    assert res == expected_result


@pytest.mark.parametrize(
    "args, expected_result",
    [
        ((user0["username"], user0["password"]), 200),
        ((user0["username"], ""), 401),
        (("unknown", user0["password"]), 401),
    ])
def test_get_users(args, expected_result):
    res = get_users(*args)
    assert res == expected_result


@pytest.mark.parametrize(
    "args, expected_result",
    [
        ((user0["username"], "secret0"), 200),
        ((user0["username"], ""), 401),
        (("unknown", "secret0"), 401),
    ])
def test_get_user(args, expected_result):
    res = get_user(*args)
    assert res == expected_result


@pytest.mark.parametrize(
    "user, expected_result",
    [
        pytest.param(user2, 201, id="new user"),
        pytest.param(user2, 400, id="duplicate user"),
        pytest.param(user3, 400, id="missing firstname"),
    ])
def test_create_user(user, expected_result):
    res = create_user(user)
    assert res == expected_result


@pytest.mark.parametrize(
    "args, kwargs, expected_result",
    [
        pytest.param(
            [user0["username"], "secret0"],
            {"firstname": "Max", "lastname": "Planck", "phone": 4444},
            201,
            id="normal update"),
        pytest.param(
            [user0["username"], "secret0"],
            {"username": "tester00", "lastname": "Landau", "phone": 5555},
            403,
            id="forbidden field username"),
        pytest.param(
            [user0["username"], "secret0"],
            {"password": "newpwd", "lastname": "Abrikosov", "phone": 6666},
            403,
            id="forbidden field password"),
    ])
def test_update_user(args, kwargs, expected_result):
    res = update_user(*args, **kwargs)
    assert res == expected_result
