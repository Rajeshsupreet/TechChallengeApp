variable "rg-name" {
  type        = string
  description = "The Resource Group name"
  default     = "servian_app_rg"
}

variable "location" {
  type        = string
  description = "The Resource Group Location"
  default     = "Australia East"
}

variable "postgresql-server-name" {
  type        = string
  description = "The postgresql name"
  default     = "servianpostgresqlserver"
}

variable "postgresql-db-name" {
  type        = string
  description = "The postgresql name"
  default     = "servian_postgressql_db"
}

variable "service-plan-name" {
  type        = string
  description = "service plan name"
  default     = "servian_app_plan"
}

variable "appname" {
  type        = string
  description = "app name"
  default     = "serviangtdapp"
}

variable "administratorlogin" {
  type        = string
  description = "Postgres Username"
  default     = "psuser"
}

variable "administratorloginpassword" {
  type        = string
  description = "Postgres password"
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
  type        = string
  description = "Azure Client id"
}

variable "client_secret" {
  type        = string
  description = "Azure client Secret "
}

variable "tenant_id" {
  type        = string
  description = " Azure tenant_id"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription id"
}