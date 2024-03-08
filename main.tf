## Security Groups

# Public Subnet And ELB Security Group
resource "aws_security_group" "Terra-SG" {
  name        = "Terra-SG"
  description = "Security Group For The Instances"
  vpc_id      = aws_vpc.terra-vpc.id


  ingress {
    description = "Allowing HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allowing SSH"
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

  tags = {
    Name = "Terra-SG"
  }
}

# Private Instance Security Group
resource "aws_security_group" "WebServer2-SG" {
  name        = "WebServer2-SG"
  description = "Security Group For The Web Server 2 Instances"
  vpc_id      = aws_vpc.terra-vpc.id


  ingress {
    description     = "Allowing HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.Terra-SG.id]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServer2-SG"
  }

  depends_on = [aws_security_group.Terra-SG]
}






## Instances
resource "aws_instance" "WebServer1" {
  ami                    = var.AMIS
  instance_type          = var.Instance-Type
  vpc_security_group_ids = [aws_security_group.Terra-SG.id]
  subnet_id              = aws_subnet.Terra-PUB-SUB.id
  user_data              = file("barista-cafe.sh")

  tags = {
    Name = "Web-Server-1"
  }
}

resource "aws_instance" "WebServer2" {
  ami                    = var.AMIS
  instance_type          = var.Instance-Type
  vpc_security_group_ids = [aws_security_group.WebServer2-SG.id]
  subnet_id              = aws_subnet.Terra-PRIV-SUB.id
  user_data              = file("barista-cafe-2.sh")
  tags = {
    Name = "Web-Server-2"
  }
}





## Application Load Balancer
resource "aws_lb" "Terra-LB" {
  name               = "Terra-ALB"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.Terra-SG.id]
  subnets         = [aws_subnet.Terra-PRIV-SUB.id, aws_subnet.Terra-PUB-SUB.id]
}


# Load Balancer Target Group
resource "aws_lb_target_group" "Terra-ALB-TG" {
  name     = "Terra-ALB-Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra-vpc.id

  target_type = "instance"

  health_check {
    path = "/"
    port = "traffic-port"
  }

}

resource "aws_lb_target_group_attachment" "Attach1" {
  target_group_arn = aws_lb_target_group.Terra-ALB-TG.arn
  target_id        = aws_instance.WebServer1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Attach2" {
  target_group_arn = aws_lb_target_group.Terra-ALB-TG.arn
  target_id        = aws_instance.WebServer2.id
  port             = 80
}


resource "aws_lb_listener" "Listener" {
  load_balancer_arn = aws_lb.Terra-LB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.Terra-ALB-TG.arn
    type             = "forward"
  }
}

