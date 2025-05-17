
/* 
  This Terraform configuration file defines the AWS Lambda function and its associated resources.
    It includes the following components:
    - AWS Lambda function: A serverless compute service that runs code in response to events.
    - AWS IAM role: A role that grants the Lambda function permissions to access other AWS services
*/
resource "aws_lambda_function" "service_api_check_handler" {
  filename         = data.archive_file.service_api_check_handler_archive.output_path
  source_code_hash = data.archive_file.service_api_check_handler_archive.output_base64sha256
  function_name    = "service-api-check-handler"
  role             = aws_iam_role.service_api_check_handler_role.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  depends_on       = [data.archive_file.service_api_check_handler_archive]

  tags = {
    Name = "resource_dedicated_infrastructure"
    Project = "lambda_dedicated_infrastructure"
  }
}