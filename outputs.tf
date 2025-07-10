output "aws_instance_ips" {
  value       = var.env == "aws" ? aws_instance.kafka_broker[*].public_ip : []
  description = "Kafka broker public IPs (only if env = aws)"
}

output "onprem_kafka_status" {
  value       = var.env == "onprem" ? "Kafka resources deployed via Kubernetes (onprem)" : ""
  description = "Status message for on-prem Kafka"
}
