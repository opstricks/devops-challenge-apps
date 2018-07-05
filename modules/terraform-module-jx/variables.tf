variable "jxprovider" {
  default = ""
}

variable "git_provider_url" {
  default = ""
}

variable "git_owner" {
  default = ""
}

variable "git_organization" {
  default = ""
}

variable "git_user" {
  description = "git username "
}

variable "git_token" {
  description = "token git"
}

variable "admin_user" {
  description = "Admin username for Jenkins-x"
}

variable "admin_password" {
  description = "Admin password for Jenkins-x"
}

variable "this_module" {
  description = "helps dependency between modules"
  default     = "jenkins-x"
  type        = "string"
}

variable "this_module_depends_on" {
  description = "helps dependency between modules"
  type        = "list"
}

variable "triggers" {
  default = "0"
  type    = "string"
}

variable "kubeconfig_dir" {
  type = "string"
}