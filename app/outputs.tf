output "public_instance_ip_addr_private" {
  value = module.ec2_instance_rhel_public.private_ip
}

output "public_instance_ip_addr_public" {
  value = module.ec2_instance_rhel_public.public_ip
}

output "security_group_id" {
  value = module.server-sg.security_group_id
}
