output "alb_id" {
  description = "The ID of the Application Load Balancer"
  value       = aws_lb.this.id
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = aws_lb.this.zone_id
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "hello_world_target_group_arn" {
  description = "ARN of the hello world target group"
  value       = aws_lb_target_group.hello_world.arn
}

output "hello_world_listener_rule_arn" {
  description = "ARN of the hello world listener rule"
  value       = aws_lb_listener_rule.hello_world.arn
}
