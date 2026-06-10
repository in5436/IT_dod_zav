# AWS EC2 Deployment with Terraform & Ansible

It automates the process of creating a simple virtual server on AWS and running a Python Flask application on it.

## What it does

* **Terraform:** Creates a `t3.micro` instance in the `eu-north-1` region. It opens inbound ports 22 (for SSH) and 5000 (for the Flask app). Outbound traffic is restricted to ports 80 and 443 for security updates.
* **Ansible:** Configures the server using a structured role-based approach:
  * `setup` — updates system packages and installs Python 3 with Flask.
  * `app_install` — deploys the Python script and configures the background service via a Jinja2 systemd template.
  * `verification` — performs a basic automated health check to ensure the website is responding.
* **Flask Web App:** A simple Python script that serves a home page and logs incoming JSON data via a `POST /data` endpoint.

## Project Structure

* `main.tf` — Terraform configuration file for AWS infrastructure.
* `playbook.yml` — Main Ansible file that triggers the configuration roles.
* `inventory.ini` — Contains the server IP address for Ansible connection.
* `roles/` — Directory containing separate Ansible roles (`setup`, `app_install`, `verification`).
