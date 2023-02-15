#Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = 2
}


#### creating sns topic for all the auto scaling groups
resource "aws_sns_topic" "manager-sns" {
  name = "Default_CloudWatch_Alarms_Topic"
}

#creating notification for all the auto scaling groups
resource "aws_autoscaling_notification" "manager_notifications" {
  group_names = [
    aws_autoscaling_group.bastionASG.name,
    aws_autoscaling_group.nginxASG.name,
    aws_autoscaling_group.wordpressASG.name,
    aws_autoscaling_group.toolingASG.name,
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.manager-sns.arn
}