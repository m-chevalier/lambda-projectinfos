# lambda-projectinfos

Ce repo contient le script de déploiement de la lambda permettant de faire le lien entre Workday et le module Terraform de tagging.

## Déploiement

### Variables

Les variables suivantes sont sont présentes et modifiables dans le fichier [variables.tf](variables.tf) :

- region
- function_name

### Backend

Modifier le fichier [backend.tf](backend.tf) pour paramétrer le stockage du `.tfstate`. (voir : [DOC TERRAFORM](https://developer.hashicorp.com/terraform/language/settings/backends/configuration))

### Appliquer

Une fois les changements réalisés :

- initialiser terraform `terraform init`
- déployer l'infrastructure `terraform apply`

Pour détruire l'infrastructure : `terraform destroy`

## Fonctionnement

La lambda reçoit des données JSON sous ce format :

```json
{
    "projectId": "project-id-value"
}
```

La lambda retourne des données JSON sous ce format :

```json
{
    "owner": "Owner email",
    "status" : "success",
    "message" : "success"
}
```

Si le `status` n'est pas à la valeur `success`, le module produira une erreur et affichera la valeur du `message` à l'utilisateur.

## Permissions

Cette lambda a une ressource "aws_lambda_permission" pour autoriser tout l'organisation à l'appeler.

## Développement

Pour modifier l'excution de la lambda, il suffit de modifier le fichier [projectinfos.py](code/projectinfos.py) et d'appliquer l'infrastructure.

Pour l'instant, cette lambda ne réalise aucun appel HTTP, le code commenté sera à réaliser pour la liaison avec Workday
