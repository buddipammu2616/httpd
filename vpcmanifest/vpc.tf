#Create VPC
resource "aws_vpc" "maheshvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "maheshvpc"
  }
}
#Create SUBNETS
resource "aws_subnet" "maheshubnet" {
  vpc_id = aws_vpc.maheshvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}
#Create INTERNET GATE WAY
resource "aws_internet_gateway" "maheshIGW" {
  vpc_id = aws_vpc.maheshvpc.id
}
#Create ROUTE TABLE
resource "aws_route_table" "maheshRT" {
  vpc_id = aws_vpc.maheshvpc.id
}
#Create a Route in Route Table for Internet Access
resource "aws_route" "maheshR" {
  route_table_id = aws_route_table.maheshRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.maheshIGW.id
}
#Associate the Route Table with the subnet
resource "aws_route_table_association" "maheshRTSassociate" {
  route_table_id = aws_route_table.maheshRT.id
  subnet_id = aws_subnet.maheshubnet.id
}
#Create SECURITY GROUP
resource "aws_security_group" "maheshSG" {
    name = "maheshSG"
  description = "Mahesh Security Group"
  vpc_id = aws_vpc.maheshvpc.id
  tags = {
    "Name" = "Mahesh Security Group"
  }

#Specify Inbound Rule for port 22
 ingress {
    description = "Allow port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
#Specify Inbound Rule for port 80
 ingress {
    description = "Allow port 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
#Specify outbound Rules
 egress {
    description ="Allow all outbound traffic"
    from_port = 0
    to_port =0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}














