// ----------------------------------
// Lambda Other Settings
// ----------------------------------
variable "log_retention_in_days" {
  default = null
}

variable "dummy_enabled" {
  default = false
}

variable "xray_enabled" {
  default = false
}

// ----------------------------------
// Lambda Basic Settings
// ----------------------------------
# function_name - (Required) A unique name for your Lambda Function.
variable "function_name" {}

# description - (Optional) Description of what your Lambda Function does.
variable "description" {
  default = null
}

# handler - (Required) The function entrypoint in your code.
variable "handler" {}

# role_name - (Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details.
variable "role_name" {}

variable "assume_role_policy" {
  default = null
}

# role_policy_json - (Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details.
variable "role_policy_json" {
  default = []
}

# memory_size - (Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. See Limits
variable "memory_size" {
  default = 128
}

# runtime - (Required) See Runtimes for valid values.
variable "runtime" {}

# timeout - (Optional) The amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits
variable "timeout" {
  default = 10
}

# layers - (Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. See Lambda Layers
variable "layers" {
  default = null
}

# variables - (Optional) A map that defines environment variables for the Lambda function.
variable "variables" {
  default = null
}

# tags - (Optional) A mapping of tags to assign to the object.
variable "tags" {
  default = null
}

// ----------------------------------
// Lambda File Upload Settings
// ----------------------------------
# filename - (Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used.
variable "filename" {
  default = null
}

# s3_bucket - (Optional) The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function.
variable "s3_bucket" {
  default = null
}

# s3_key - (Optional) The S3 key of an object containing the function's deployment package. Conflicts with filename.
variable "s3_key" {
  default = null
}

# s3_object_version - (Optional) The object version containing the function's deployment package. Conflicts with filename.
variable "s3_object_version" {
  default = null
}

# reserved_concurrent_executions - (Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. See Managing Concurrency
variable "reserved_concurrent_executions" {
  default = null
}

# publish - (Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false.
variable "publish" {
  default = false
}

# kms_key_arn - (Optional) The ARN for the KMS encryption key.
variable "kms_key_arn" {
  default = null
}

# source_code_hash - (Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is ${base64sha256(file("file.zip"))}, where "file.zip" is the local filename of the lambda function source archive.
variable "source_code_hash" {
  default = null
}

# target_arn - (Required) The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted.
variable "target_arn" {
  default = null
}

# mode - (Required) Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with "sampled=1". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision.
variable "mode" {
  default = "PassThrough"
}

// ----------------------------------
// Lambda VPC Settings
// ----------------------------------
# subnet_ids - (Required) A list of subnet IDs associated with the Lambda function.
variable "subnet_ids" {
  default = null
}

# security_group_ids - (Required) A list of security group IDs associated with the Lambda function.
variable "security_group_ids" {
  default = null
}

// ----------------------------------
// Lambda Alias
// ----------------------------------
# name - (Required) Name for the alias you are creating. Pattern: (?!^[0-9]+$)([a-zA-Z0-9-_]+)
variable "alias_name" {
  default = null
}

# description - (Optional) Description of the alias.
variable "alias_description" {
  default = null
}

# additional_version_weights - (Optional) A map that defines the proportion of events that should be sent to different versions of a lambda function.
variable "additional_version_weights" {
  default = null
}

// ----------------------------------
// Lambda Edge
// ----------------------------------
variable "edge" {
  default = false
}

// ----------------------------------
// Lambda Trigger
// ----------------------------------
variable "trigger_source_arn" {
  default = null
}
variable "trigger_principal" {
  default = null
}

