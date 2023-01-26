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
      "10.60.14.0/25",
      "10.60.14.128/25",
      "10.60.15.0/25",
      "10.60.15.128/25",
      "10.60.16.0/25",
      "10.60.16.128/25",
    ],
    public_subnet = [
      "10.60.17.0/27",
      "10.60.17.32/27",
      "10.60.17.64/27",
      "10.60.17.96/27",
      "10.60.17.128/27",
      "10.60.17.160/27",
    ],
  }
}
