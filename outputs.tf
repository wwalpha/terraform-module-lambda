output "xray_enabled" {
  value = var.xray_enabled
}
output "dummy_enabled" {
  value = var.dummy_enabled
}
# function_name - A unique name for your Lambda Function.
output "function_name" {
  value = local.aws_lambda_function.function_name
}
# arn - The Amazon Resource Name (ARN) identifying your Lambda Function.
output "arn" {
  value = local.aws_lambda_function.arn
}
# qualified_arn - The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true).
output "qualified_arn" {
  value = local.aws_lambda_function.qualified_arn
}
# The Amazon Resource Name (ARN) identifying your Lambda function alias.
output "alias_arn" {
  value = var.alias_name != null ? aws_lambda_alias.this[0].arn : null
}
# invoke_arn - The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri
# Alias or Lambda or Dummy
output "invoke_arn" {
  value = local.invoke_arn
}
# version - Latest published version of your Lambda Function.
output "version" {
  value = local.aws_lambda_function.version
}
# last_modified - The date this resource was last modified.
output "last_modified" {
  value = local.aws_lambda_function.last_modified
}
# kms_key_arn - (Optional) The ARN for the KMS encryption key.
output "kms_key_arn" {
  value = local.aws_lambda_function.kms_key_arn
}