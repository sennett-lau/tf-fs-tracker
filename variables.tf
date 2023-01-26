variable "az_count" {
  description = "Number of AZs"
  type        = number
  default     = 6

  validation {
    condition     = var.az_count <= 6
    error_message = "AZCount must be less than or equal to 6 (the largest number of azs which is in us-east-1)."
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
