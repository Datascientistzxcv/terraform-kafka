resource "kubernetes_service" "kafka" {
  count = var.provider_type == "confluent" ? 1 : 0

  metadata {
    name      = "kafka"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "kafka"
    }

    port {
      name        = "broker"
      port        = 9092
      target_port = 9092
      protocol    = "TCP"
    }

    type = local.service_type
  }
}
