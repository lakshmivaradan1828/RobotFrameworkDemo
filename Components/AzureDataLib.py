import json
import re
import requests
import xmltodict
import xml.etree.ElementTree as ET
import pandas as pd
import sys
from Parameters.AzureParams import AZURE_TOKEN, AZURE_DEVOPS_URL, project

class AzureDataLib:
    def __init__(self, workitem=12345, filename=""):
         self.get_workitem_content(project, workitem, filename)

    def check_azure_token(self, AZURE_TOKEN):
        if len(AZURE_TOKEN) == 52:
            return True
        else:
            sys.exit('Azure token not valid')

    def get_content_json(self, project, workitem):
        url = f'{AZURE_DEVOPS_URL}/{project}/_apis/wit/workitems/{workitem}'
        self.check_azure_token(AZURE_TOKEN)
        r = requests.get(url,
            auth=('', AZURE_TOKEN))
        return json.loads(r.text)

    def get_shared_workitem_details(self, project, workitem, filename):
        content_json = self.get_content_json(project, workitem)
        content_xml = content_json["fields"]["Microsoft.VSTS.TCM.Parameters"]
        content_dict = xmltodict.parse(content_xml)
        df = pd.DataFrame()
        thisdict = []
        counter=0
        for key,value in content_dict.items():
            for x,y in (value["paramData"].items()):
                for a in y:
                    tmp_dict = {}
                    if type(a) == dict and not counter:
                        df = pd.DataFrame(a["kvp"])
                        counter=len(a["kvp"])
                    for x in range(int(counter)):
                        tmp_dict[a["kvp"][x]["@key"]] = a["kvp"][x]["@value"]
                        if len(tmp_dict) == counter:
                            thisdict.append(tmp_dict)
        df = pd.DataFrame(thisdict)
        for col_name in df.columns:
            robot_col_name=f"${{{col_name}}}"
            df = df.rename(columns={col_name : robot_col_name})
        df.to_excel(f'{filename}.xlsx', index=False)

    def get_shared_workitem_content(self, project, content, filename):
        shared_workitem = re.search('"sharedParameterDataSetId":(\d+)', content)
        if shared_workitem:
            self.get_shared_workitem_details(project, shared_workitem.group(1), filename)

    def get_workitem_content(self, project, workitem, filename):
        content_json = self.get_content_json(project, workitem)
        content = content_json["fields"]["Microsoft.VSTS.TCM.LocalDataSource"]
        if "NewDataSet" in content_json["fields"]["Microsoft.VSTS.TCM.LocalDataSource"]:
            content_dict = xmltodict.parse(content)["NewDataSet"]["Table1"]
            df = pd.DataFrame(content_dict)
            for col_name in df.columns:
                robot_col_name=f"${{{col_name}}}"
                df = df.rename(columns={col_name : robot_col_name})
            df.to_excel(f'{filename}.xlsx', index=False)
        else:
            self.get_shared_workitem_content(project, content, filename)
