resource "aws_iam_role" "iam_tg01" {
  name = "iam_tg01"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "tg_alert" {
  s3_bucket = "systemd.tk"
  s3_key    = "tg01.zip"
  function_name    = "tg_alert"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  role             = aws_iam_role.iam_tg01.arn
  timeout          = 180


  environment {
    variables = {
      ip = aws_instance.ubuntu-exam.public_ip
    }
  }
}