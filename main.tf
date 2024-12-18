provider "aws" {
  region     = "us-west-2"  # Specify your AWS region
}

resource "aws_instance" "amazon_linux" {
  ami           = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"
  key_name      = "jenkins"
   user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname c8.local
              sudo yum update -y
              echo "127.0.0.1 c8.local" >> /etc/hosts
              EOF
  tags = {
    Name = "c8.local"
  }
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  key_name      = "jenkins"
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname u21.local
              sudo apt-get update -y
              sudo apt-get upgrade -y
              echo "127.0.0.1 u21.local" >> /etc/hosts
              EOF
  tags = {
    Name = "u21.local"
  }
}

output "instances" {
  value = {
    frontend = aws_instance.amazon_linux.public_ip
    backend  = aws_instance.ubuntu.public_ip
  }
}
