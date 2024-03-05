output "instance_public_ip" {
  value = aws_instance.Postgres_Instance.public_ip
}
