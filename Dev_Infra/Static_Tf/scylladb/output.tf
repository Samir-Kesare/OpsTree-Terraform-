output "scylladb_sg_id" {
  value = [aws_security_group.scylladb_sg.id]
}
output "scylladb_server_id" {
  value = [aws_instance.scylladb_server.id]
}
