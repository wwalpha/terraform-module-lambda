# ------------------------------------------
# AWS Lambda Function
# ------------------------------------------
resource "aws_lambda_function" "this" {
  depends_on = ["aws_iam_role.this"]

  function_name = "${var.function_name}"
  description   = "${var.description}"
  handler       = "${var.handler}"
  role          = "${aws_iam_role.this.arn}"
  memory_size   = "${var.memory_size}"
  runtime       = "${var.runtime}"
  timeout       = "${var.timeout}"
  layers        = "${var.layers}"
  publish       = "${var.publish}"
  tags          = "${var.tags}"

  filename          = "${local.filename}"
  source_code_hash  = "${local.source_code_hash}"
  s3_bucket         = "${var.s3_bucket}"
  s3_key            = "${var.s3_key}"
  s3_object_version = "${var.s3_object_version}"

  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
  kms_key_arn                    = "${var.kms_key_arn}"

  dynamic "dead_letter_config" {
    for_each = "${local.dead_letter_config}"

    content {
      target_arn = "${dead_letter_config.value}"
    }
  }

  dynamic "tracing_config" {
    for_each = "${local.tracing_config}"

    content {
      mode = "${tracing_config.value}"
    }
  }

  dynamic "vpc_config" {
    for_each = "${local.vpc_config}"

    content {
      subnet_ids         = "${vpc_config.subnet_ids}"
      security_group_ids = "${vpc_config.security_group_ids}"
    }
  }

  dynamic "environment" {
    for_each = "${local.environment}"

    content {
      variables = "${environment.value}"
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = ["qualified_arn", "version", "last_modified"]
  }

  count = "${var.dummy_enabled ? 0 : 1}"
}

resource "aws_lambda_function" "dummy" {
  depends_on = ["aws_iam_role.this"]

  function_name = "${var.function_name}"
  description   = "${var.description}"
  handler       = "${var.handler}"
  role          = "${aws_iam_role.this.arn}"
  memory_size   = "${var.memory_size}"
  runtime       = "${var.runtime}"
  timeout       = "${var.timeout}"
  layers        = "${var.layers}"
  publish       = "${var.publish}"
  tags          = "${var.tags}"

  filename          = "${local.filename}"
  source_code_hash  = "${local.source_code_hash}"
  s3_bucket         = "${var.s3_bucket}"
  s3_key            = "${var.s3_key}"
  s3_object_version = "${var.s3_object_version}"

  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
  kms_key_arn                    = "${var.kms_key_arn}"

  dynamic "dead_letter_config" {
    for_each = "${local.dead_letter_config}"

    content {
      target_arn = "${dead_letter_config.value}"
    }
  }

  dynamic "tracing_config" {
    for_each = "${local.tracing_config}"

    content {
      mode = "${tracing_config.value}"
    }
  }

  dynamic "vpc_config" {
    for_each = "${local.vpc_config}"

    content {
      subnet_ids         = "${vpc_config.subnet_ids}"
      security_group_ids = "${vpc_config.security_group_ids}"
    }
  }

  dynamic "environment" {
    for_each = "${local.environment}"

    content {
      variables = "${environment.value}"
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = ["source_code_hash", "qualified_arn", "version", "last_modified"]
  }

  count = "${var.dummy_enabled ? 1 : 0}"
}

# ------------------------------------------
# AWS Lambda Cloudwatch LogGroup
# ------------------------------------------
resource "aws_cloudwatch_log_group" "this" {
  depends_on = ["aws_lambda_function.this", "aws_lambda_function.dummy"]

  name              = "/aws/lambda/${local.aws_lambda_function.function_name}"
  retention_in_days = "${var.log_retention_in_days}"
}

// ----------------------------------
// AWS Lambda Permission
// ----------------------------------
resource "aws_lambda_permission" "others" {
  depends_on = ["aws_lambda_function.this", "aws_lambda_function.dummy"]

  action        = "lambda:InvokeFunction"
  function_name = "${local.aws_lambda_function.function_name}"
  principal     = "${var.trigger_principal}"
  source_arn    = "${var.trigger_source_arn}"

  count = "${local.enable_permission_others}"
}

resource "aws_lambda_permission" "smarthome" {
  depends_on = ["aws_lambda_function.this", "aws_lambda_function.dummy"]

  action             = "lambda:InvokeFunction"
  function_name      = "${local.aws_lambda_function.function_name}"
  principal          = "${var.trigger_principal}"
  event_source_token = "${var.trigger_source_arn}"

  count = "${local.enable_permission_smarthome}"
}
