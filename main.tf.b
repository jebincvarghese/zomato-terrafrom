
# =========================================================================
# Security Group For Web Communication
# =========================================================================

resource "aws_security_group" "webserver" {
    
  name        = "webserver"
  description = "allows 80,443 traffic"
 

  ingress {
    description      = ""
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }

    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "webserver-${var.project}",
    project = var.project
  }
}



# =========================================================================
# Security Group For Remote Access
# =========================================================================

resource "aws_security_group" "remote" {
    
  name        = "remote"
  description = "allow 22 traffic"
 

  ingress {
    description      = ""
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "remote",
    project = "uber"
  }
}


# =========================================================================
# Creating Ec2 Instance
# =========================================================================


resource "aws_instance" "application" {
    
  ami           = "ami-03fa4afc89e4a8a09"
  instance_type = "t2.micro"
  key_name = "mumbai-aws-new"
  vpc_security_group_ids = [ aws_security_group.webserver.id , aws_security_group.remote.id ]
  tags = {
    Name = "zomato-application",
    project = "zomato"
  }
}
