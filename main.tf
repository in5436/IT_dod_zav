# Вказуємо, що працюємо з AWS
provider "aws" {
  region = "eu-north-1" #
}

# Створюємо правила доступу
resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Allow HTTP and SSH"

  # Дозволяємо підключатися до сервера по SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Дозволяємо доступ до нашої програми на Flask
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Дозволяємо серверу виходити в інтернет
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Знаходимо найсвіжіший образ Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Створюємо сам сервер
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "my_aws_key"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "MyPythonAppServer"
  }
}

# Виводимо IP-адресу сервера після його створення
output "server_public_ip" {
  value = aws_instance.web_server.public_ip
}