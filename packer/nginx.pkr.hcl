variable "image_tag" {
    type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_subnet_id" {
  type = string
}

source "yandex" "nginx" {
  folder_id           = "${var.yc_folder_id}"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_description   = "Nginx image for slurm lab"
  image_family        = "centos-7"
  image_name          = "nginx-${var.image_tag}"
  subnet_id           = "${var.yc_subnet_id}"
  disk_type           = "network-hdd"
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.nginx"]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}