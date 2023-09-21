resource "aws_lightsail_instance" "lightsail_server" {
  name               = "lightsail_server_instance"
  availability_zone  = "us-east-1b"  # Change this to your preferred AWS availability zone
  blueprint_id       = "centos_7_2009_01"    # Specify CentOS 7 Blueprint ID (Confirm the exact ID based on your AWS offerings)
  bundle_id          = "nano_2_0"    # Change this to your preferred bundle ID
  #key_pair_name      = "your_key_pair_name"  # Specify your key pair name here

  user_data = <<-EOT
                #!/bin/bash
                sudo yum update -y
                sudo yum install unzip wget httpd -y
                sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
                sudo unzip main.zip
                sudo rm -rf /var/www/html/*
                sudo cp -r static-resume-main/* /var/www/html/
                sudo systemctl start httpd
                sudo systemctl enable httpd
             EOT
}

output "lightsail_instance_public_ip" {
  value = aws_lightsail_instance.lightsail_server.public_ip_address
  description = "The public IP of the Lightsail instance"
}
