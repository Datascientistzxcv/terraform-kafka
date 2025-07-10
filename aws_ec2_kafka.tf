resource "aws_security_group" "kafka_sg" {
  count       = var.env == "aws" ? 1 : 0
  name        = "kafka-sg"
  description = "Allow SSH on Kafka brokers"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "kafka_broker" {
  count         = var.env == "aws" ? 3 : 0
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t3.medium"
  key_name      = var.aws_key_name

  vpc_security_group_ids = [aws_security_group.kafka_sg[0].id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y java-1.8.0-openjdk
    wget https://downloads.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz
    tar -xvzf kafka_2.13-3.7.0.tgz
    mv kafka_2.13-3.7.0 /opt/kafka
  EOF

  tags = {
    Name = "kafka-broker-${count.index + 1}"
  }
}
