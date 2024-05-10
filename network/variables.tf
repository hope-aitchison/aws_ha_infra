### General Variables ###
variable "profile" {
  description = "IAM role or profile"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-2" # London
}

variable "stage" {
  description = "The environment to deploy into"
  type        = string
  default     = ""
}

variable "app-name" {
  description = "name of the application"
  type        = string
  default     = ""
}