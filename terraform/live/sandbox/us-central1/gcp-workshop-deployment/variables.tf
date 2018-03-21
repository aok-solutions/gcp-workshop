variable "name" {}
variable "node_count" {}
variable "username" {}
variable "password" {}
variable "labels_owner" {}
variable "labels_env" {}

variable "additional_zones" {
  type = "list"
}

variable "zone" {}

variable "image" {}

variable "gitsha" {}

variable "project" {}
