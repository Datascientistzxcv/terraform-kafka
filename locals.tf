locals {
  kafka_image     = "confluentinc/cp-server:7.5.0"
  zookeeper_image = "confluentinc/cp-zookeeper:7.5.0"

  storage_class = (
    var.env == "aws" ? "gp3" :
    var.env == "gcp" ? "standard" :
    var.env == "azure" ? "managed-premium" :
    ""
  )

  bootstrap_servers = (
    var.env == "onprem"
    ? "PLAINTEXT://kafka-0.kafka.confluent.svc.cluster.local:9092"
    : "PLAINTEXT://kafka.confluent.svc.cluster.local:9092"
  )

  service_type = (
    var.env == "onprem" ? "NodePort" : "LoadBalancer"
  )
}
