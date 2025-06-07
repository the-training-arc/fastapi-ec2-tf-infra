resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "aws_key_pair" "generated_key" {
  key_name   = "${local.resource_prefix}-key-pair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
