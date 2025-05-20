
/* 
  This Terraform configuration file defines the AWS Lambda function and its associated resources.
    It includes the following components:
    - AWS Lambda function: A serverless compute service that runs code in response to events.
    - AWS IAM role: A role that grants the Lambda function permissions to access other AWS services
*/
resource "aws_lambda_function" "service_customer_api_function" {
  filename         = data.archive_file.service_customer_api_function_archive.output_path
  source_code_hash = data.archive_file.service_customer_api_function_archive.output_base64sha256
  function_name    = "service-customer-api-function"
  role             = aws_iam_role.service_customer_api_function_role.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  depends_on       = [data.archive_file.service_customer_api_function_archive]

  tags = {
    Name = "resource_dedicated_infrastructure"
    Project = "lambda_dedicated_infrastructure"
  }
}