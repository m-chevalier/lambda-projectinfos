variable "function_name" {
    type = string
    description = "nom de la fonction qui sera déployée, penser à modifier le nom dans le module si celui-ci est modifié"
    default = "project-infos"
}

variable "region" {
  description = "région de déploiement"
  type        = string
  default = "eu-west-1"
}