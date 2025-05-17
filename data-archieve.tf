/*
  * data "archive_file" is used to create a zip file from the source file.
  * The source file is the index.js file in the lambda directory.
  * The output path is the lambda_function_payload.zip file.
   - type: The type of archive to create (zip in this case).
    - source_file: The path to the file or directory to be archived.
    - output_path: The path to save the archive file.
*/

data "archive_file" "service_api_check_handler_archive" {
  type        = "zip"
  source_file = "${path.module}/functions/index.js"
  output_path = "${path.module}/lambda_api_check_handler.zip"
}