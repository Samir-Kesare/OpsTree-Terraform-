
output "Postgres_Instance_id" {
  value = [aws_instance.Postgres_server.id]
}

output "Postgresql_sg_id" {
  value = aws_security_group.Postgresql_sg.id
}
