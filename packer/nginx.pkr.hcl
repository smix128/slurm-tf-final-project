variable "image_tag" {
    type = string
}

source "yandex" "nginx" {
  folder_id           = "b1g9uka7gvk8bkh2s9ae"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_description   = "Nginx image for slurm lab"
  image_family        = "centos-7"
  image_name          = "nginx-${var.image_tag}"
  subnet_id           = "e9b59oe9ppsptmu7n39m"
  disk_type           = "network-hdd"
  zone                = "enpbeno0scckjlt8jaa9"
}

build {
  sources = ["source.yandex.nginx"]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}