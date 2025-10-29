# ##################################################################################
# # IMPORTS
# ##################################################################################

# import {
#   to = module.main.aws_vpc.this[0]
#   id = "vpc-06856444d210a11bd" #VPC
# }

# import {
#   to = module.main.aws_subnet.public[0]
#   id = "subnet-03fbb78624c750650" #PublicSubnet1
# }

# import {
#   to = module.main.aws_subnet.public[1]
#   id = "subnet-06428aad40713a7aa" #PublicSubnet2
# }

# import {
#   to = module.main.aws_internet_gateway.this[0]
#   id = "igw-028a968923b33ecdf" #InternetGateway
# }

# import {
#   to = module.main.aws_route.public_internet_gateway[0]
#   id = "rtb-00e4b585d185c085c_0.0.0.0/0" #DefaultPublicRoute
# }

# import {
#   to = module.main.aws_route_table.public[0]
#   id = "rtb-00e4b585d185c085c" #PublicRouteTable
# }

# import {
#   to = module.main.aws_route_table_association.public[0]
#   id = "subnet-03fbb78624c750650/rtb-00e4b585d185c085c" #PublicSubnet1/PublicRouteTable
# }

# import {
#   to = module.main.aws_route_table_association.public[1]
#   id = "subnet-06428aad40713a7aa/rtb-00e4b585d185c085c" #PublicSubnet2/PublicRouteTable
# }

# import {
#   to = aws_security_group.ingress
#   id = "sg-0477f4c4ef66215a7" #NoIngressSecurityGroup
# }
