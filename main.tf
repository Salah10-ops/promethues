provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "monitoring_sg" {
  name        = "monitoring_sg"
  description = "Allow monitoring traffic"
  vpc_id      = "vpc-01db9a3b289f16330"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9093
    to_port     = 9093
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

resource "aws_instance" "prometheus" {
  ami           = "ami-084568db4383264d4"  
  instance_type = "t2.micro"             
  key_name      = "my-key-pair"
  subnet_id   = "subnet-0b4ae95c0df876ba9"
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]
  tags = { Name = "Prometheus-EC2" }
}

resource "aws_instance" "infra" {
  ami           = "ami-084568db4383264d4"  
  instance_type = "t2.micro"  
  key_name      = "my-key-pair"  
  subnet_id   = "subnet-0b4ae95c0df876ba9"
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]
  tags = { Name = "Infra-EC2" }
}

resource "aws_instance" "app" {
  ami           = "ami-084568db4383264d4"  
  instance_type = "t2.micro"  
  key_name      = "my-key-pair"
  subnet_id   = "subnet-0b4ae95c0df876ba9"
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]
  tags = { Name = "App-EC2" }
}


