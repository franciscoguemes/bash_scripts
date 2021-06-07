#!/usr/bin/env python3

#
# This is an example on a simple interaction with JIRA.
#
# Given a valid username, password, Jira url and ticket name the application will connect with the
# given jira system and will get the title of the ticket and the sprint number.
#


from jirautils import JIRA
import json
import re
import sys


def login(username, password, url):
    jira = JIRA(basic_auth=(username, password), options={'server': url})
    return jira


def get_sprint_for(jira, ticket):
    issue = jira.issue(ticket)

    # customfield_10100 is the sprint field
    sprint_name = re.findall(r"name=[^,]*", str(issue.fields.customfield_10100[0]))
    words = str.split(sprint_name[0])

    # Sprint number is the last one (eg. Sprint 100)
    return words[len(words) - 1]


def get_title_for(jira,ticket):
    issue = jira.issue(ticket)

    return issue.fields.summary


ERROR_MESSAGE = """Please provide the arguments in the following way:
    $> sprint ticket=TICKET url=jira_url user=username password=password
"""


def process_arguments(args):

    if len(args) != 4:
        sys.exit(ERROR_MESSAGE)

    # A dictionary for holding the arguments once they are processed
    parameters = {
        "ticket": "",
        "user": "",
        "password": ""
    }

    # print(args)

    for arg in args:
        chunks = str.split(arg, "=")
        # print(chunks)
        if str.lower(chunks[0])=="ticket":
            parameters["ticket"]=chunks[1]
        elif str.lower(chunks[0])=="user":
            parameters["user"] = chunks[1]
        elif str.lower(chunks[0])=="password":
            parameters["password"] = chunks[1]
        elif str.lower(chunks[0])=="url":
            parameters["url"] = chunks[1]
        else:
            sys.exit(ERROR_MESSAGE)

    return parameters


def main():

    # print(sys.argv)

    parameters = process_arguments(sys.argv[1:])

    ticket = parameters["ticket"]
    user = parameters["user"]
    password = parameters["password"]
    url = parameters["url"]

    jira = login(user, password, url)
    sprint = get_sprint_for(jira, ticket)
    title = get_title_for(jira,ticket)

    # print(f"The ticket {ticket} with title {title} belongs to sprint {sprint}")
    print(sprint)
    print(title)

main()
