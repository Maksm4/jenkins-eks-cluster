resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  count             = local.az_count
  availability_zone = var.az[count.index]
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, local.dynamic_newbits, count.index)

  map_public_ip_on_launch = true

  tags = {
    "Name"                                                         = "${var.environment}-public-${count.index + 1}-${var.az[count.index % length(var.az)]}"
    "kubernetes.io/role/elb"                                       = "1"
    "kubernetes.io/cluster/${var.environment}-${var.project_name}" = "owned"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = local.az_count
  availability_zone = var.az[count.index % length(var.az)]
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, local.dynamic_newbits, count.index + local.az_count)

  tags = {
    "Name"                                                         = "${var.environment}-private-${count.index + 1}-${var.az[count.index % length(var.az)]}"
    "kubernetes.io/role/internal-elb"                              = "1"
    "kubernetes.io/cluster/${var.environment}-${var.project_name}" = "owned"
  }
}