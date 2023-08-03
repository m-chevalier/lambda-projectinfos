output "instance_ip_addr" {
  value = aws_lambda_function_url.url.function_url
}