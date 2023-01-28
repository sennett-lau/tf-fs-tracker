variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.60.14.0/23"
}

variable "subnet_cidr" {
  description = "Preset Subnets CIDR blocks"
  type        = map(list(string))
  default     = {
    private_subnet = [
      "10.60.12.0/25",
      "10.60.12.128/25",
      "10.60.13.0/25",
      "10.60.13.128/25",
      "10.60.14.0/25",
      "10.60.14.128/25",
    ],
    public_subnet = [
      "10.60.15.0/27",
      "10.60.15.32/27",
      "10.60.15.64/27",
      "10.60.15.96/27",
      "10.60.15.128/27",
      "10.60.15.160/27",
    ],
  }
}
