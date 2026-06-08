# Cloud Provisioning Automation with Terraform and Ansible

This repository contains a DevOps pipeline to automate the deployment of a Python Flask web application on an AWS EC2 instance.

## Architecture & Tools
- **Terraform**: Initializes and provisions the AWS EC2 instance (`t3.micro` in the `eu-north-1` Stockholm region) and sets up Security Groups (ports 22 for SSH, 5000 for Flask).
- **Ansible**: Connects to the created instance via SSH, updates packages, installs Python 3, copies the application file, and configures a `systemd` service to run the app in the background.
- **Python & Flask**: A simple web app that serves a homepage and provides a `POST /data` endpoint to receive and log incoming user data.

## File Structure
- `main.tf` - Infrastructure as Code (IaC) for AWS.
- `playbook.yml` - Ansible playbook for server configuration.
- `inventory.ini` - Server IP address and connection settings.
- `app.py` - Flask web application code.
