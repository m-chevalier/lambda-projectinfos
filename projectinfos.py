import json
import base64

def lambda_handler(event, context):
    # Parse the incoming event body
    try:
        if(event["isBase64Encoded"]):
            #If the body is encoded, we need to decode it before we parse to json
            decoded_body = base64.b64decode(event["body"])
            body = json.loads(decoded_body)
        else:
            body = json.load(event["body"])
        project_id = body.get("projectId", "")
    except Exception as e:
        return {
            "statusCode": 400,
            "body": json.dumps({"Status":"error", "error": "Invalid JSON data in the request body."}),
        }

    if project_id == "test-erreur":
        # If the project id doesn't exist we send an error value
        return {
        "statusCode": 200,
        "body": json.dumps({"Status": "unknown-project-id"}),
        }


    response = {
        "Status" : "success",
        "Project": project_id,
        "ProjectName": "Test d'ajout de tag depuis une requête",
    }

    return {
        "statusCode": 200,
        "body": json.dumps(response),
    }