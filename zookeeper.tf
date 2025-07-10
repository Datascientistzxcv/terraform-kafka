resource "kubernetes_manifest" "zookeeper" {
  count = var.env == "onprem" ? 1 : 0

  manifest = yamldecode(<<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Zookeeper
metadata:
  name: zookeeper
  namespace: default
spec:
  replicas: 1
  image:
    application: confluentinc/cp-zookeeper:7.5.0
    init: confluentinc/confluent-init-container:2.5.0
  dataVolumeCapacity: 5Gi
  logVolumeCapacity: 10Gi
EOF
  )
}
