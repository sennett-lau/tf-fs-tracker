resource "aws_sns_topic" "support_sns_topic" {
  name = "${var.project}-${var.env}-support-sns-topic"
}

resource "aws_sns_topic_subscription" "support_sns_topic_subscription" {
  topic_arn  = aws_sns_topic.support_sns_topic.arn
  protocol   = "email"
  endpoint   = var.support_email
  depends_on = [aws_sns_topic.support_sns_topic]
}
