resource "kubernetes_manifest" "kafka" {
  count = var.env == "onprem" ? 1 : 0

  manifest = yamldecode(<<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Kafka
metadata:
  name: kafka
  namespace: default
spec:
  replicas: 1
  image:
    application: confluentinc/cp-server:7.5.0
    init: confluentinc/confluent-init-container:2.5.0
  dataVolumeCapacity: 5Gi
  dependencies:
    zookeeper:
      endpoint: zookeeper.default.svc.cluster.local:2181
EOF
  )
}
