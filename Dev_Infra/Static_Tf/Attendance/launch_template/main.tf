resource "aws_launch_template" "Attendance_Launch_Template" {
  name          = var.template_name
  description   = var.template_description
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name

  network_interfaces {
    security_groups         = var.security_group_ids
    subnet_id               = var.subnet_ID
  }

  user_data = filebase64("./script.sh")
  tags = {  
    Name                  = var.template_name
  }

}
