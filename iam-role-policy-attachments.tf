/*
  aws_iam_role_policy_attachment is a resource that attaches an IAM policy to an IAM role.
  In this case, the AWSLambdaBasicExecutionRole policy is attached to the IAM role created earlier.
  This policy provides the necessary permissions for the Lambda function to execute.
  - role: The name of the IAM role to attach the policy to.
  - policy_arn: The ARN of the IAM policy to attach to the role.
*/
resource "aws_iam_role_policy_attachment" "service_api_check_handler_role_attachment" {
  role       = aws_iam_role.service_api_check_handler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}