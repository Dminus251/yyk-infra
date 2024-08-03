output "subnet_usage" {
  value = aws_subnet.main.tags["Usage"]
}

output "id" {
  value = aws_subnet.main.id
}

output "ids" { #id를 리스트형식으로
  value = aws_subnet.main.*.id
}


