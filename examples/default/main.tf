provider "aws" {}

module "lambda" {
  source = "../.."

  function_name      = "Test"
  handler            = "index.handler"
  runtime            = "nodejs10.x"
  memory_size        = 512
  role_name          = "TestRole"
  source_dir         = "build"
  source_output_path = "dist/source.zip"
}

output "lambda" {
  value = module.lambda
}