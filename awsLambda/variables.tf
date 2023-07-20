variable "policies" {
  description = "List of AWS policies to add to the Lambda function role"
  default = ["AmazonEC2ReadOnlyAccess", "CloudWatchLogsFullAccess"]
}

variable "description" {
  description = "Lambda function to send request to FLAPI WB"
  default = "lambda-java-src-1.0-SNAPSHOT.jar"
}

variable "lambda_runtime" {
  default = "java11"
}

variable "lambda_function_handler" {
  default = "com.lambda.java.LambdaHandler"
}

variable "lambda_timeout" {
  default = 300
}

variable "memory_size" {
  default = 512
}
variable "cloudwatch_logs_ttl_days" {
  default = 14
}
variable "role_name_prefix" {
  default = "role"
}

variable "aws_lambda_vpc" {
  default = "vpc-6a53ee0d"
}

variable "aws_subnet_a" {
  default = "subnet-a"
}

variable "aws_subnet_b" {
  default = "subnet-b"
}

variable "aws_subnet_c" {
  default = "subnet-c"
}
variable "variable1" {
  description = "Define custom variable here if required on lambda"
}
variable "variable2" {
  description = "Define custom variable here if required on lambda"
}
variable "function_name" {
  default = "lambda_with_java_src"
}
locals{
  sqs_name = "{aws_sqs_name}.fifo",
  dead_letter_queue_name ="{aws_dead_letter_queue_name_name}.fifo"
}
variable "region" {
  description = "The region that the resource belongs to"
}
variable "aws_account" {
  description = "The AWS account to deploy resources, e.g. sandbox/ops/np/np2/pr"
}
