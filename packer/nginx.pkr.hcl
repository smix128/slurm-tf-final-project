variable "image_tag" {
    type = string
}

variable "YC_FOLDER_ID" {
  type = string
  default = env("YC_FOLDER_ID")
}

variable "YC_SUBNET_ID" {
  type = string
  default = env("YC_SUBNET_ID")
}

variable "YC_ZONE" {
  type = string
  default = env("YC_ZONE")
}

source "yandex" "nginx" {
  folder_id           = "${var.YC_FOLDER_ID}"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_description   = "Nginx image for slurm lab"
  image_family        = "centos-7"
  image_name          = "nginx-${var.image_tag}"
  subnet_id           = "${var.YC_SUBNET_ID}"
  disk_type           = "network-hdd"
  zone                = "${var.YC_ZONE}"
}

build {
  source = ["source.yandex.nginx"]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}