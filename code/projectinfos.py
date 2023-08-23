import json
import urllib3

http = urllib3.PoolManager()

url = "https://catfact.ninja/fact"
params = {}

def unknown_project():
    return {"status": "unknown-project-id", "message": "This project ID doesn't exist"}

def invalid_input_parameters():
    return {"status":"json-error", "message": "Invalid JSON data in the request body."}


def lambda_handler(event, context):
    try:
        # Checking if all input parameters are set :
        project_id = event["projectId"]
    except Exception as e:
        return invalid_input_parameters()

    if project_id == "test-erreur": # If the project id doesn't exist we send an error value (remove in production mode)
        return unknown_project()


    # Make a request to Workday API here
    result = http.request('GET',
                        url=url,
                        body=json.dumps(params))
    data = json.loads(result.data)


    response = {
        "status" : "success",
        "message" : "success",
        "projectName": "Name of the project using Workday API",
        "owner": "Owner email using Workday API",
    }

    return response
