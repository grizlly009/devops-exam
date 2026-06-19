terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    gitea = {
      source  = "go-gitea/gitea"
      version = "~> 0.7"
    }
  }
}

provider "docker" {}

provider "gitea" {
  base_url = var.gitea_base_url
  token    = var.gitea_token
  insecure = var.gitea_insecure
}

module "docker_app" {
  source = "./modules/docker-app"

  nginx_host_port = var.nginx_host_port
}

resource "gitea_repository" "terraform_docker_exam" {
  username       = var.gitea_username
  name           = var.gitea_repo_name
  private        = true
  auto_init      = true
  default_branch = "main"
  description    = "Terraform Docker exam repository"
}

resource "gitea_repository_branch_protection" "main" {
  username                        = gitea_repository.terraform_docker_exam.username
  name                            = gitea_repository.terraform_docker_exam.name
  rule_name                       = "main"
  block_merge_on_rejected_reviews = true
}

output "repository_clone_url" {
  value = gitea_repository.terraform_docker_exam.clone_url
}

output "repository_web_url" {
  value = gitea_repository.terraform_docker_exam.html_url
}
