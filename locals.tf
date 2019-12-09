locals {
  default_assume_role_policy = var.edge ? file("${path.module}/iam/lambda_edge_principals.json") : file("${path.module}/iam/lambda_principals.json")
  assume_role_policy         = var.assume_role_policy != null ? var.assume_role_policy : local.default_assume_role_policy

  empty_array = []
  empty_map   = {}

  dead_letter_config          = var.target_arn != null ? list(var.target_arn) : local.empty_array
  environment                 = var.variables != null ? list(var.variables) : local.empty_array
  mode                        = var.xray_enabled ? "Active" : var.mode
  tracing_config              = local.mode != null ? list(local.mode) : local.empty_array
  vpc_config                  = var.subnet_ids != null ? map("subnet_ids", var.subnet_ids, "security_group_ids", var.security_group_ids) : local.empty_map
  routing_config              = var.additional_version_weights != null ? list(var.additional_version_weights) : local.empty_array
  filename                    = var.dummy_enabled ? "${path.module}/index.zip" : var.source_output_path
  source_code_hash            = var.dummy_enabled ? filebase64sha256("${path.module}/index.zip") : filebase64sha256(data.archive_file.this.output_path)
  aws_lambda_function         = var.dummy_enabled ? aws_lambda_function.dummy[0] : aws_lambda_function.this[0]
  aws_xray_write_only_arn     = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
  invoke_arn                  = var.alias_name != null ? aws_lambda_alias.this[0].invoke_arn : local.aws_lambda_function.invoke_arn
  enable_permission_smarthome = var.trigger_principal == "alexa-connectedhome.amazon.com" ? 1 : 0
  enable_permission_others    = var.trigger_principal == null ? 0 : local.permission_others
  permission_others           = var.trigger_principal == "alexa-connectedhome.amazon.com" ? 0 : 1
  publish                     = var.alias_name != null ? true : var.publish
}
