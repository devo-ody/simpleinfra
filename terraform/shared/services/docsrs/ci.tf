// This file contains the configuration for the rust-lang/crater's CI.

module "ecr" {
  source = "../../modules/ecr-repo"
  name   = "docsrs"
}

resource "aws_iam_user" "ci" {
  name = "ci--rust-lang--docs-rs"
}

resource "aws_iam_access_key" "ci" {
  user = aws_iam_user.ci.name
}

resource "aws_iam_user_policy_attachment" "ci_push" {
  user       = aws_iam_user.ci.name
  policy_arn = module.ecr.policy_push_arn
}

resource "aws_iam_user_policy_attachment" "ci_pull" {
  user       = aws_iam_user.ci.name
  policy_arn = module.ecr.policy_pull_arn
}
