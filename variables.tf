variable "gitea_base_url" {
  description = "Base URL for the Gitea server"
  type        = string
  default     = "http://localhost:3000"
}

variable "gitea_token" {
  description = "Personal access token for Gitea API"
  type        = string
  sensitive   = true
}

variable "gitea_insecure" {
  description = "Allow insecure TLS for local Gitea setup"
  type        = bool
  default     = true
}

variable "gitea_username" {
  description = "Gitea username that owns the repository"
  type        = string
}

variable "gitea_repo_name" {
  description = "Name of the repository to create"
  type        = string
  default     = "terraform-docker-exam"
}

variable "nginx_host_port" {
  description = "Host port for the Nginx container"
  type        = number
  default     = 8080

  validation {
    condition     = var.nginx_host_port >= 1024 && var.nginx_host_port <= 65535
    error_message = "nginx_host_port must be between 1024 and 65535."
  }
}
