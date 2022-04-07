output "security_group_id" {
  value = aws_security_group.alb_sg.name
}
output "alb_tg_arn" {
  value = aws_alb_target_group.target_group-1.arn
}
output "alb_tg_name" {
  value = aws_alb_target_group.target_group-1.name
}
output "aws_alb_listener" {
  value = aws_alb_listener.listener-1
}
output "aws_alb_listener2" {
  value = aws_alb_listener.listener-2
}
