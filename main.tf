resource "aws_s3_bucket" "s3_bucket_myapp" {
  bucket = "myapp-amitvmonani" #"myapp-prod"
  acl = "private"
}

resource "aws_s3_bucket_object" "s3_bucket_object_myapp" {
  bucket = aws_s3_bucket.s3_bucket_myapp.id
  key = "beanstalk/myapp"
  source = "target/react-and-spring-data-rest-0.0.1-SNAPSHOT.jar"
}

resource "aws_elastic_beanstalk_application" "beanstalk_myapp" {
  name = "myapp"
  description = "AWS Lab Exercise "
}


resource "aws_elastic_beanstalk_application_version" "beanstalk_myapp_version" {
  application = aws_elastic_beanstalk_application.beanstalk_myapp.name
  bucket = aws_s3_bucket.s3_bucket_myapp.id
  key = aws_s3_bucket_object.s3_bucket_object_myapp.id
  name = "myapp-${var.myapp_version}"
}

resource "aws_elastic_beanstalk_environment" "beanstalk_myapp_env" {
  name = "myapp-env" #"myapp-prod"
  application = aws_elastic_beanstalk_application.beanstalk_myapp.name
  solution_stack_name = "64bit Amazon Linux 2 v3.2.2 running Corretto 11"
  version_label = aws_elastic_beanstalk_application_version.beanstalk_myapp_version.name

  setting {
    name = "SERVER_PORT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value = "5000"
  }

  setting {
    namespace = "aws:ec2:instances"
    name = "InstanceTypes"
    value = "t2.micro"
  }
  
  setting {
   namespace = "aws:autoscaling:launchconfiguration"
   name = "IamInstanceProfile"
   value = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

}