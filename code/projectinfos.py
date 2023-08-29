import json
import urllib3

http = urllib3.PoolManager()


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


    # Uncomment here and make a request to Workday API
    #result = http.request('GET',
    #                    url="http://example.com",
    #                    body=json.dumps({}))
    #data = json.loads(result.data)


    response = {
        "status" : "success",
        "message" : "success",
        "owner": "fake-owner-email-from-workday",
    }

    return response
