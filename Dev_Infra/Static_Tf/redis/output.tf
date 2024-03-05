output "redis_sg_id" {
  value = [aws_security_group.redis_sg.id]
}
output "redis_server_id" {
  value = [aws_instance.redis_server.id]
}
