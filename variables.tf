variable "rg-name" {
  type        = string
  description = "The Resource Group name"
  default     = "rg-tech-app"
}

variable "location" {
  type        = string
  description = "The Resource Group Location"
  default     = "australiaeast"
}

variable "postgresql-server-name" {
  type        = string
  description = "The postgresql name"
  default     = "tech-app-postgresql-server"
}

variable "postgresql-db-name" {
  type        = string
  description = "The postgresql name"
  default     = "tech-app-db"
}

variable "service-plan-name" {
  type        = string
  description = "service plan name"
  default     = "tech-app-plan"
}

variable "appname" {
  type        = string
  description = "app name"
  default     = "technicalapp1353"
}

variable "administratorlogin" {
  type        = string
  description = "app name"
}

variable "administratorloginpassword" {
  type        = string
  description = "app name"
}

variable "listenhost" {
  type        = string
  description = "The listenhost of the app"
  default     = "0.0.0.0"
}

variable "docker_image" {
  type        = string
  description = "The listenhost of the app"
  default     = "servian/techchallengeapp"
}

variable "docker_image_tag" {
  type        = string
  description = "The listenhost of the app"
  default     = "latest"
}

variable "client_id" {
  type = string
  description = "Azure Client id"
}

variable "client_secret" {
  type = string
  description = "Azure client Secret "
}

variable "tenant_id" {
  type = string
  description = " Azure tenant_id"
}

variable "subscription_id" {
  type = string
  description = "Azure subscription id"
}