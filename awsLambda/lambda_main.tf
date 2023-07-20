resource "aws_lambda_function" "lambda_function_with_java_src" {
  filename                       = "${data.archive_file.dummy.output_path}"
  function_name                  = "${var.function_name}"
  role                           = "${data.aws_iam_role.flapi_lambda_role.arn}"
  handler                        = "${var.lambda_function_handler}"
  runtime                        = "${var.lambda_runtime}"
  timeout                        = "${var.lambda_timeout}"
  description                    = "${var.description}"
  memory_size                    = "${var.memory_size}"

  vpc_config {
    subnet_ids         = [
      "${var.aws_subnet_a}",
      "${var.aws_subnet_b}",
      "${var.aws_subnet_c}",
      ]
    security_group_ids = ["${aws_security_group.lambda-sg.id}"]
  }
  environment = {
    variables = {
      variable1 = "${var.variable1}",
      variable2 = "${var.variable2}"
    }
  }
  depends_on = ["aws_security_group.flapi-wb-lambda-sg"]
}

resource "aws_lambda_permission" "lambda_permission_for_sqs" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function_with_java_src.function_name}"
  principal     = "sqs.amazonaws.com"
  source_arn    = "arn:aws:sqs:${var.region}:${var.aws_account}:${local.sqs_name}"
}

resource "aws_lambda_event_source_mapping" "flapi_wb_sqs_mapping" {
  event_source_arn = "arn:aws:sqs:${var.region}:${var.aws_account}:${local.sqs_name}"
  function_name    = "${aws_lambda_function.lambda_function_with_java_src.arn}"
  batch_size       = "1"
  #function_response_types = ["ReportBatchItemFailures"]
}
resource "aws_cloudwatch_log_group" "lambda_cloudwatch_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function_with_java_src.function_name}"
  retention_in_days = "${var.cloudwatch_logs_ttl_days}"
}
data "aws_sqs_queue" dead_letter_q{
  name = "${local.dead_letter_queue_name}"
}
