output "endpoint" {
  description = "Fully qualified DNS name for the environment"
  value       = aws_elastic_beanstalk_environment.beanstalk_myapp_env.cname
}