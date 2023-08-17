import json
import base64
import urllib3

http = urllib3.PoolManager()

url = "https://catfact.ninja/fact"
params = {}

def lambda_handler(event, context):
    # Parse the incoming event body
    try:
        #Checking if all input parameters are set :
        project_id = event["projectId"]
    except Exception as e:
        return {"Status":"error", "error": "Invalid JSON data in the request body."}

    if project_id == "test-erreur":
        # If the project id doesn't exist we send an error value (remove in production mode)
        return {"Status": "unknown-project-id"}


    # Make a request to Workday API here
    result = http.request('GET',
                        url=url,
                        body=json.dumps(params))
    data = json.loads(result.data)


    response = {
        "Fact": data["fact"], # We can add every parameter we want in this object
        "Status" : "success",
        "ProjectName": "Test d'ajout de tag depuis une requête",
    }

    return response