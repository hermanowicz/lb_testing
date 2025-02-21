// docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

# resource "aws_lb" "nlb-test-labs" {
#   name                             = "nlb-test-labs"
#   internal                         = false
#   load_balancer_type               = "network"
#   security_groups                  = [aws_security_group.nlb-sg.id]
#   subnets                          = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
#   enable_cross_zone_load_balancing = true

#   enable_deletion_protection = false

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

# resource "aws_security_group" "nlb-sg" {
#   vpc_id      = module.vpc.vpc_id
#   name        = "nlb-sg"
#   description = "Security group for the NLB"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_lb_target_group" "nlb-via-id-group" {
#   name        = "nlb-via-id-group"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = module.vpc.vpc_id
#   target_type = "ip"

#   health_check {
#     enabled             = true
#     protocol            = "TCP"
#     port                = 80
#     interval            = 10
#     timeout             = 3
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }

# }

# resource "aws_lb_listener" "nlb-listener" {
#   load_balancer_arn = aws_lb.nlb-test-labs.arn
#   port              = 80
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.nlb-via-id-group.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "nlb-via-ip-group-attachment-1" {
#   target_group_arn = aws_lb_target_group.nlb-via-id-group.arn
#   target_id        = module.worker-one.private_ip
#   port             = 80
# }

# resource "aws_lb_target_group_attachment" "nlb-via-ip-group-attachment-2" {
#   target_group_arn = aws_lb_target_group.nlb-via-id-group.arn
#   target_id        = module.worker-two.private_ip
#   port             = 80
# }

