variable "REGION" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "CIDR" {
  description = "Terra-VPC CIDE Range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "AZS" {
  description = "Subnet Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "Instance-Type" {
  default = "t2.micro"
}

variable "AMIS" {
  default = "ami-0261755bbcb8c4a84"
}
