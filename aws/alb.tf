// docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

# resource "aws_lb" "alb-test-labs" {
#   name                             = "alb-test-labs"
#   internal                         = false
#   load_balancer_type               = "application"
#   security_groups                  = [aws_security_group.alb-sg.id]
#   subnets                          = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
#   enable_cross_zone_load_balancing = true

#   enable_deletion_protection = false

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

# resource "aws_security_group" "alb-sg" {
#   vpc_id      = module.vpc.vpc_id
#   name        = "alb-sg"
#   description = "Security group for the ALB"

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

# resource "aws_lb_target_group" "alb-target-group" {
#   name        = "alb-test-labs"
#   port        = 3000
#   protocol    = "HTTP"
#   vpc_id      = module.vpc.vpc_id
#   target_type = "instance"

#   health_check {
#     enabled             = true
#     path                = "/ping"
#     matcher             = "200"
#     protocol            = "HTTP"
#     interval            = 10
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }
# }

# resource "aws_lb_listener" "alb-listener" {
#   load_balancer_arn = aws_lb.alb-test-labs.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb-target-group.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "alb-via-ip-group-attachment-1" {
#   target_group_arn = aws_lb_target_group.alb-target-group.arn
#   target_id        = module.worker-one.id
#   port             = 3000
# }

# resource "aws_lb_target_group_attachment" "alb-via-ip-group-attachment-2" {
#   target_group_arn = aws_lb_target_group.alb-target-group.arn
#   target_id        = module.worker-two.id
#   port             = 3000
# }

# resource "aws_lb_target_group_attachment" "alb-via-ip-group-attachment-3" {
#   target_group_arn = aws_lb_target_group.alb-target-group.arn
#   target_id        = module.worker-three.id
#   port             = 3000
# }
