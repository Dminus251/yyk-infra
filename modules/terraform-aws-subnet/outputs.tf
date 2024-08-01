output "subnet_usage" {
  value = aws_subnet.main.tags["Usage"]
}

output "id" {
  value = aws_subnet.main.id
}
