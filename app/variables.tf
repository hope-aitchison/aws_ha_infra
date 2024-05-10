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

variable "key-pair" {
  description = "instance key pair name"
  type        = string
  default     = ""
}

variable "internet_cidr" {
  description = "cidr block for all IP range"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami" {
  description = "AMI ID"
  type        = string
  default     = ""
}