resource "aws_eip" "eip" {
  count      = min(length(data.aws_availability_zones.azs.names), var.az_count)
  vpc        = true
  depends_on = [aws_internet_gateway_attachment.attach_gateway]
}
