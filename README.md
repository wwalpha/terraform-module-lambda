# terraform-modules-lambda

## Prerequisites

[Terraform](https://www.terraform.io/downloads.html) >= 0.12

## Usage

```
module "test" {
  source = "github.com/wwalpha/terraform-modules-lambda"

  log_retention_in_days = 14

  filename         = "dummy.zip"
  function_name    = "AAAAA"
  handler          = "index.handler"
  role_name        = "AAAAARole"
  role_policy_json = []
  runtime          = "nodejs8.10"

  alias_name = "dev"
}

```

### Use Dummy File

```
module "test" {
  source = "github.com/wwalpha/terraform-modules-lambda"

  enable_dummy   = true

  function_name    = "AAAAA"
  handler          = "index.handler"
  role_name        = "AAAAARole"
  runtime          = "nodejs8.10"
}

```

### Create Function Alias

```
module "test" {
  source = "github.com/wwalpha/terraform-modules-lambda"

  enable_dummy   = true

  function_name    = "AAAAA"
  handler          = "index.handler"
  role_name        = "AAAAARole"
  runtime          = "nodejs8.10"

  alias_name       = "dev"
}

```

## Outputs

```
arn = arn:aws:lambda:ap-northeast-1:311178267809:function:AAAAA
invoke_arn = arn:aws:apigateway:ap-northeast-1:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:311178267809:function:AAAAA/invocations
kms_key_arn =
last_modified = 2019-06-08T09:47:52.644+0000
qualified_arn = arn:aws:lambda:ap-northeast-1:311178267809:function:AAAAA:$LATEST
version = $LATEST
```
