import json
import base64

def lambda_handler(event, context):
    # Parse the incoming event body
    try:
        project_id = event["projectId"]
    except Exception as e:
        return {"Status":"error", "error": "Invalid JSON data in the request body."}

    if project_id == "test-erreur":
        # If the project id doesn't exist we send an error value
        return {"Status": "unknown-project-id"}


    response = {
        "Status" : "success",
        "Project": project_id,
        "ProjectName": "Test d'ajout de tag depuis une requête",
    }

    return response