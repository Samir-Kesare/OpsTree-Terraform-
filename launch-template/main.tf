*-------------------------------------------------------------------------------------------*
//Launch-Template
resource "aws_launch_template" "salary_launch_template" {
  name_prefix   = var.launch_template_name_prefix
  description   = var.launch_template_description

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
    }
  }

  instance_type        = var.instance_type
  security_group_names = var.security_group_names

  # You can add more configurations as needed
}

*---------------------------------------------------------------------------------------------------*
