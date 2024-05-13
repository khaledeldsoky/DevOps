resource "null_resource" "hosts_file" {
  depends_on = [ module.ec2 ]
  provisioner "local-exec" {
    command = <<EOT
    ../Bash/hosts.sh ${module.ec2.ec2_pb_ip}
    EOT
  }
}

resource "null_resource" "ansible" {
  depends_on = [ null_resource.hosts_file ]
  provisioner "local-exec" {
    command = <<EOT
    cd ../Ansible/
    ansible-playbook playbook.yaml 
    EOT
  }
}