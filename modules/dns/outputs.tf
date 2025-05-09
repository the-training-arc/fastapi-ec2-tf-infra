
output "certificate_arn" {
  description = "The ARN of the ALB certificate"
  value       = aws_acm_certificate.cert.arn
}
