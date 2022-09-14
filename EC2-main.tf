# Resource-7: Creat Security Group for Web Server
resource "aws_security_group" "OMS-EC2-Webserver-SG" {
  name        = "OMS-VPC-Webserver-SG"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.OMS-VPC.id
  ingress    {
      description      = "TLS from Internet"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    ingress    {
      description      = "All traffic"
      from_port         = 0
      to_port           = 65535
      protocol          = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  ingress    {
      description      = "SSH Connection"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  egress     {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "OMS-EC2-Webserver-SG"
  }
}

# Resource-8: Creat EC2 Ubuntu  Web Server
resource "aws_instance" "OMS-EC2-Webserver" {
  ami           = "ami-HERE"
  instance_type = "t2.micro"
  key_name      = "xxx"
  subnet_id     = aws_subnet.OMS-VPC-Pub-sbn.id
  vpc_security_group_ids = [aws_security_group.OMS-EC2-Webserver-SG.id]
  count                     = "3"

  tags = {
    Name = "OMS-EC2-Webserver"
  }
}
# Resource-8: Creat EC2 Ubuntu  Web Server
resource "aws_instance" "OMS-EC2-Webserver" {
  ami           = "ami-HERE"
  instance_type = "t2.micro"
  key_name      = "KEY-HERE"
  subnet_id     = aws_subnet.OMS-VPC-Pub-sbn.id
  vpc_security_group_ids = [aws_security_group.OMS-EC2-Webserver-SG.id]
  count                     = "1"
  user_data = <<-EOF
<<-EOF
              #!/bin/bash
              sudo apt-get install nginx -y
              echo "Welcome to Patara Web Application Server" > /var/www/html/index.html
              sudo apt-get update -y
              sudo service httpd start
              
              sudo curl -fsSL https://get.docker.com -o get-docker.sh
              sudo sh get-docker.sh  
                                          
              EOF


  tags = {
    Name = "OMS-EC2-Webserver"
  }
}
