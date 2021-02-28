resource "aws_instance" "ubuntu-exam" {
    ami = "ami-0932440befd74cdba"
    instance_type = "t2.micro"
    key_name = "key_frankfurt"
    subnet_id = aws_subnet.exam_itea_subnet.id
    vpc_security_group_ids = [aws_security_group.exam_itea_sg.id]
    tags = {
        "Name" = "ubuntu-exam"
    }
}