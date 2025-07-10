variable "env" {
  description = "Deployment environment: onprem or aws"
  type        = string
  validation {
    condition     = contains(["onprem", "aws"], var.env)
    error_message = "env must be either 'onprem' or 'aws'"
  }
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file for on-prem"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}

variable "aws_key_name" {
  description = "AWS key pair name (only used if env = aws)"
  type        = string
  default     = ""
}
variable "provider_type" {
  description = "Kafka provider: bitnami or confluent"
  type        = string
  validation {
    condition     = contains(["bitnami", "confluent"], var.provider_type)
    error_message = "Provider must be 'bitnami' or 'confluent'."
  }
}

variable "namespace" {
  description = "The Kubernetes namespace to deploy into"
  type        = string
}
