#!/usr/bin/env python

import requests


def generate_login_data(username, password):

    # clientSecret is a value requested by the API of the Dashboard.
    # In order to login you have to have a look to the requested headers of the Endpoint --> see comment below

    data = {
        'username': '%s' % username,
        'password': '%s' % password,
        'clientSecret': '2g7P1FEBqXZRfK74s0Ff',
        'verifyToken': None,
        'version': 'something'
    }
    return data


def login(username, password):
    # Endpoint
    URL = 'https://my-shaun.idgard.de/uiapi/AccountsAPI/v1/rest/login'
    headers = {'Content-type': 'application/json', 'Accept': 'application/json'}

    # Data to be sent to api
    data = generate_login_data(username, password)

    # Send request
    session = requests.Session()
    r = session.post(url=URL, json=data, headers=headers)

    # Check response
    if r.status_code == 200:
        print("Login successfully with user: " + username)
        return session
    else:
        sys.exit("ERROR: " + str(r.status_code) + ": Failed to login with user: " + username)
