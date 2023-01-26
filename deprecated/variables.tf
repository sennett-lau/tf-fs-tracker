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
  default     = 6

  validation {
    condition     = var.az_count <= 6
    error_message = "AZCount must be less than or equal to 6 (the largest number of azs which is in us-east-1)."
  }
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.60.14.0/23"
}

variable "cidr" {
  description = "Preset Subnets CIDR blocks"
  type        = map(list(string))
  default     = {
    pri_subnet = [
      "10.60.14.0/25",
      "10.60.14.128/25",
      "10.60.15.0/25",
      "10.60.15.128/25",
      "10.60.16.0/25",
      "10.60.16.128/25",
    ],
    pub_subnet = [
      "10.60.17.0/27",
      "10.60.17.32/27",
      "10.60.17.64/27",
      "10.60.17.96/27",
      "10.60.17.128/27",
      "10.60.17.160/27",
    ],
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
