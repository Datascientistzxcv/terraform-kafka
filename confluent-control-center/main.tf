resource "kubernetes_service" "control_center" {
  count = var.provider_type == "confluent" ? 1 : 0

  metadata {
    name      = "control-center"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "control-center"
    }

    port {
      port        = 9021
      target_port = 9021
      protocol    = "TCP"
    }

    type = local.service_type
  }
}
