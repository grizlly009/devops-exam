output "nginx_container_id" {
  value = module.docker_app.nginx_container_id
}

output "health_checker_container_id" {
  value = module.docker_app.health_checker_container_id
}

output "network_id" {
  value = module.docker_app.network_id
}
