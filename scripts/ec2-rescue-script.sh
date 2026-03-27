#!/bin/bash
# AWS EC2 User Data script used for emergency disaster recovery
# Bypasses lost SSH keys and strict firewalls to allow temporary password authentication

echo "admin:RescuePassword2026!" | chpasswd
echo "PasswordAuthentication yes" > /etc/ssh/sshd_config.d/99-rescue.conf
systemctl restart ssh
