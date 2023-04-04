variable "bastion_key_name" {
  description = "Bastion key name"
  type        = string
  default     = "fs-dev-bastion-key"
  nullable    = true
}

variable "create_bastion" {
  description = "Create bastion host"
  type        = bool
  default     = false
}

variable "create_bastion_eip" {
  description = "Create bastion host EIP"
  type        = bool
  default     = false
}
