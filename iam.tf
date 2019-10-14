# ------------------------------
# AWS Lambda Role
# ------------------------------
resource "aws_iam_role" "this" {
  name               = "${var.role_name}"
  assume_role_policy = "${local.assume_role_policy}"

  lifecycle {
    create_before_destroy = false
  }
}

# ------------------------------
# AWS Lambda AssumeRole
# ------------------------------
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "edge_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

# ------------------------------
# AWS Lambda Logging Policy
# ------------------------------
resource "aws_iam_role_policy" "logging" {
  # provider   = "${var.provider}"
  depends_on = ["aws_iam_role.this"]

  name = "logging"
  role = "${aws_iam_role.this.id}"

  policy = "${data.aws_iam_policy_document.logging.json}"
}

data "aws_iam_policy_document" "logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

# ------------------------------
# AWS Lambda Role Policy
# ------------------------------
resource "aws_iam_role_policy" "policy" {
  role   = "${aws_iam_role.this.id}"
  policy = "${var.role_policy_json[count.index]}"

  count = "${length(var.role_policy_json)}"
}

# resource "aws_iam_role_policy" "policy1" {
#   depends_on = ["aws_iam_role.this"]

#   role   = "${aws_iam_role.this.id}"
#   policy = "${var.role_policy_json[1]}"

#   count = "${length(var.role_policy_json) > 1 ? 1 : 0}"
# }
# resource "aws_iam_role_policy" "policy2" {
#   depends_on = ["aws_iam_role.this"]

#   role   = "${aws_iam_role.this.id}"
#   policy = "${var.role_policy_json[2]}"

#   count = "${length(var.role_policy_json) > 2 ? 1 : 0}"
# }

# resource "aws_iam_role_policy" "policy3" {
#   depends_on = ["aws_iam_role.this"]

#   role   = "${aws_iam_role.this.id}"
#   policy = "${var.role_policy_json[3]}"

#   count = "${length(var.role_policy_json) > 3 ? 1 : 0}"
# }

# ------------------------------
# AWS Role Policy Attachment
# ------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  role       = "${aws_iam_role.this.name}"
  policy_arn = "${local.aws_xray_write_only_arn}"

  count = "${var.xray_enabled ? 1 : 0}"
}
