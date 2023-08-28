# lambda-projectinfos

This lambda is used by the Terraform module `terraform-module-tagging`

Its objective is to contact the Workday API to get any information related to a project and return them to the module in order to set tags on a resource

The module send JSON data formatted like :

````json
{
    "projectId": "project-id-value"
}```

The lambda returns JSON data formatted like :

```json
{
    "owner": "Owner email",
    "status" : "success",
    "message" : "success"
}```

# Permissions

This lambda has a aws_lambda_permission that allows the whole organization to call it. However, this could not be tested, as we only have access to one account.
