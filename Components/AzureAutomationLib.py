"""
Script for setting automated fields in azure api
Can be run: python AzureAutomationLib.py --id 123 --name test
"""
import argparse
import json
import requests
import uuid
import sys
from Parameters.AzureParams import AZURE_TOKEN, AZURE_DEVOPS_URL, project

def check_azure_token(AZURE_TOKEN):
    if len(AZURE_TOKEN) == 52:
        return True
    else:
        sys.exit('Azure token not valid')

def get_content_json(workitem):
        url = f'{AZURE_DEVOPS_URL}/{project}/_apis/wit/workitems/{workitem}'
        r = requests.get(url,
            auth=('', AZURE_TOKEN))
        return json.loads(r.text)

def check_values(workitem, type):
    check_azure_token(AZURE_TOKEN)
    content_json = get_content_json(workitem)
    content_xml = content_json["fields"][f'Microsoft.VSTS.TCM.{type}']
    print(content_xml)
    if content_xml:
        return content_xml
    else:
        return None

def set_automated_value(workitem, operation, path, value):
    url = f'{AZURE_DEVOPS_URL}/{project}/_apis/wit/workitems/{workitem}?api-version=5.1'
    headers ={"content-type": "application/json-patch+json"}
    body_array =[]
    body = {
            "op": operation,
            "path": path,
            "value": value
        }
    body_array.append(body)
    r = requests.patch(url, json=body_array, auth=('', AZURE_TOKEN), headers=headers)
    print(r.content)

#to run in robot
def set_azure_value(workitem, name=None):
    if name:
        path= "/fields/Microsoft.VSTS.TCM.AutomatedTestName"
        operation = "add"
        set_automated_value(workitem, operation, path, name)
    currentStatus = check_values(workitem, "AutomationStatus")

    if (name and currentStatus != "Automated"):
        uid = uuid.uuid1()
        set_automated_value(workitem, operation, "/fields/Microsoft.VSTS.TCM.AutomatedTestId", str(uid))
        set_automated_value(workitem, operation, "/fields/Microsoft.VSTS.TCM.AutomationStatus", "Automated")


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--id', type=int, required=True)
    parser.add_argument('--name', type=str, required=True)
    args = parser.parse_args()
    currentStatus = check_values(args.id, "AutomationStatus")
    currentName = check_values(args.id, "AutomatedTestName")
    if (not currentName or currentStatus != "Automated"):
        set_automated_value(args.id, "add", "/fields/Microsoft.VSTS.TCM.AutomatedTestName", args.name)
    if currentName != args.name:
        set_automated_value(args.id, "replace", "/fields/Microsoft.VSTS.TCM.AutomatedTestName", args.name)
    if (currentStatus != "Automated"):
        uid = uuid.uuid1()
        set_automated_value(args.id, "add", "/fields/Microsoft.VSTS.TCM.AutomatedTestId", str(uid))
        set_automated_value(args.id, "add", "/fields/Microsoft.VSTS.TCM.AutomationStatus", "Automated")
