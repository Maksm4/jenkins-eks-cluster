
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

}

resource "aws_nat_gateway" "nat" {
  allocation_id     = aws_eip.nat.id
  vpc_id            = aws_vpc.main.id
  availability_mode = "regional"
}