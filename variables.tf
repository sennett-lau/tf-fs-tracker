variable "project" {
  description = "The project name"
  type        = string
  default     = "fs"
}

variable "env" {
  description = "Project environment"
  type        = string
  default     = "dev"
}

variable "module" {
  description = "The module name"
  type        = string
  default     = "tracker"
}

variable "az_count" {
  description = "Number of AZs"
  type        = number
  default     = 3

  validation {
    condition     = var.az_count == 3 || var.az_count == 2
    error_message = "AZCount must be 2 or 3"
  }
}

variable "cidr" {
  description = "Preset CIDR blocks"
  type        = map(list(string))
  default = {
    pri_subnet = [
      "10.60.14.0/25",
      "10.60.14.128/25",
      "10.60.15.0/25",
    ],
    pub_subnet = [
      "10.60.15.128/27",
      "10.60.15.160/27",
      "10.60.15.192/27",
    ],
  }
}

variable "ami" {
  description = "AMI ID"
  type        = map(map(string))
  default = {
    us-west-2 = {
      bastion = "ami-00f7e5c52c0f43726"
    }
  }
}

variable "support_email" {
  description = "Support email address"
  type        = string
  default     = "tech@example.com"
}

variable "bastion_key_name" {
  description = "Bastion key name"
  type        = string
  default     = "fs-dev-admin-key"
  nullable    = true
}

variable "create_bastion" {
  description = "Create bastion host"
  type        = bool
  default     = false
}
