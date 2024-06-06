#Create Elastic IP
resource "aws_eip" "maheshEIP" {
  instance = aws_instance.maheshec2.id
  domain = "vpc"
#Meta Argumets depends on
depends_on = [ aws_internet_gateway.maheshIGW ]
}