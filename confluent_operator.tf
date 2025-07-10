resource "kubernetes_manifest" "control_center" {
  count = var.env == "onprem" ? 1 : 0

  manifest = {
    apiVersion = "platform.confluent.io/v1beta1"
    kind       = "ControlCenter"
    metadata = {
      name      = "controlcenter"
      namespace = "default"
    }
    spec = {
      image = {
        application = "confluentinc/cp-enterprise-control-center:7.5.0"
        init        = "confluentinc/confluent-init-container:2.5.0"
      }
      dataVolumeCapacity = "10Gi"
      replicas           = 1
      dependencies = {
        kafka = {
          bootstrapEndpoint = "PLAINTEXT://kafka.default.svc.cluster.local:9092"
        }
      }
    }
  }
}
