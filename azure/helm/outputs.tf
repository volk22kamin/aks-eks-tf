output "hello_world_release_name" {
  description = "Name of the hello-world Helm release"
  value       = module.hello_world_app.release_name
}
