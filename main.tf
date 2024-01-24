
# This block will create a IAM user with the given name
resource "aws_iam_user" "admin-users" {
  count = length(var.admin-users-list)
  name  = var.admin-users-list[count.index]

  tags = {
    Description = "User of Technical Team "
  }

}

# This block will create a iam_policy from the given json file
resource "aws_iam_policy" "admin-user-policy" {
  name   = "AdminUsers"
  policy = file("admin-policy.json")

}

# This resouce block will attach the given policy to the user
resource "aws_iam_user_policy_attachment" "admin-access" {

  count      = length(var.admin-users-list)
  user       = var.admin-users-list[count.index]
  policy_arn = aws_iam_policy.admin-user-policy.arn

  depends_on = [aws_iam_user.admin-users]

}
