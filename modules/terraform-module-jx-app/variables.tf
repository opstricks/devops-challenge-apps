variable "git_provider_url" {
  description = ""
  default     = "https://github.com"
}

variable "git_owner" {
  description = ""
}

variable "git_organization" {
  description = ""
}

variable "git_user" {
  description = ""
}

variable "git_token" {
  description = "token git"
}

variable "this_module" {
  description = "helps dependency between modules"
  default     = "jenkins-x-app"
  type        = "string"
}

variable "this_module_depends_on" {
  description = "helps dependency between modules"
  type        = "list"
}

variable "app_name" {
  description = "Application name"
  type        = "string"
}

variable "kubeconfig_dir" {
  type = "string"
}

variable "worker_iam_role_name" {
  type = "string"
}
