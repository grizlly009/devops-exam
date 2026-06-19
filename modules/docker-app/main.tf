terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_network" "exam_network" {
  name = "exam-network"
}

resource "docker_volume" "exam_web_data" {
  name = "exam-web-data"
}

resource "docker_image" "nginx" {
  name = "nginx:1.27.4"
}

resource "docker_image" "curl" {
  name = "curlimages/curl:8.17.0"
}

resource "docker_container" "exam_web_server" {
  name  = "exam-web-server"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.exam_network.name
  }

  ports {
    internal = 80
    external = var.nginx_host_port
  }

  volumes {
    container_path = "/var/cache/nginx"
    volume_name    = docker_volume.exam_web_data.name
  }

  labels {
    label = "project"
    value = "devops-exam"
  }

  labels {
    label = "environment"
    value = "development"
  }

  labels {
    label = "managed-by"
    value = "terraform"
  }

  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost"]
    interval     = "30s"
    timeout      = "5s"
    retries      = 3
    start_period = "10s"
  }
}

resource "docker_container" "exam_health_checker" {
  name  = "exam-health-checker"
  image = docker_image.curl.image_id

  command = [
    "sh",
    "-c",
    "while true; do curl -sf http://exam-web-server:80 || echo 'Health check failed'; sleep 30; done"
  ]

  networks_advanced {
    name = docker_network.exam_network.name
  }

  labels {
    label = "project"
    value = "devops-exam"
  }

  labels {
    label = "environment"
    value = "development"
  }

  labels {
    label = "managed-by"
    value = "terraform"
  }

  depends_on = [docker_container.exam_web_server]
}
