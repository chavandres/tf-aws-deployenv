variable "allowed_cidr_block" {
  description = "CIDR Block for Allowlisting into the instance"
  type = list(string)
}

variable "key_name" {
  description = "Name of AWS Key"
  type = string
}

variable "public_key_path" {
  description = "Location of public key on the local system"
  type = string
}