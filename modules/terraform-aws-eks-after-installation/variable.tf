variable "triggers" {
  default = "0"
  type    = "string"
}

variable "this_module" {
  description = "helps dependency between modules"
  default     = "eks-after-installation"
  type        = "string"
}

variable "this_module_depends_on" {
  description = "helps dependency between modules"
  type        = "list"
}
