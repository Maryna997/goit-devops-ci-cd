output "repository_url" {
  description = "Full ECR repository URL used for Docker image push and pull operations."
  value       = aws_ecr_repository.ecr.repository_url
}

output "registry_url" {
  description = "ECR registry hostname (without the repository name) used for Docker authentication and image push."
  value       = split("/", aws_ecr_repository.ecr.repository_url)[0]
}

output "repository_arn" {
  description = "ARN of the created Amazon ECR repository."
  value       = aws_ecr_repository.ecr.arn
}