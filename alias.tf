# ------------------------------------------
# AWS Lambda Alias
# ------------------------------------------
resource "aws_lambda_alias" "this" {
  depends_on = ["aws_lambda_function.this", "aws_lambda_function.dummy"]

  name             = "${var.alias_name}"
  description      = "${var.alias_description}"
  function_name    = "${local.aws_lambda_function.arn}"
  function_version = "${local.aws_lambda_function.version}"

  dynamic "routing_config" {
    for_each = "${local.routing_config}"

    content {
      additional_version_weights = "${routing_config.value}"
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = ["function_version"]
  }

  count = "${var.alias_name == null ? 0 : 1}"
}
