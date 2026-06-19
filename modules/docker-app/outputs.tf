output "nginx_container_id" {
  value = docker_container.exam_web_server.id
}

output "health_checker_container_id" {
  value = docker_container.exam_health_checker.id
}

output "network_id" {
  value = docker_network.exam_network.id
}
