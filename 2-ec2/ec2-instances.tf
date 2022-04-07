# ---------------------------------------------------------------------------------------------------------------------
# EC2
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "ec2-instance" {
  count                       = var.instance_count
  ami                         = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.private_subnets_cidr_blocks[0]
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Shared Learning</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_ec2_name
      AppRole = "Compute"
    }
  )
}









