output "url" {
  description = "Instance url"
  value       = aws_ecr_repository.repository.repository_url
  sensitive = false
}
