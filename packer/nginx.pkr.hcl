variable "image_tag" {
    type = string
}

source "openstack" "nginx" {
  source_image_filter {
    filters {
      name = "Centos-7.9-202107"
    }
    most_recent = true
  }

  flavor = "Basic-1-1-10"
  ssh_username = "centos"
  securiy_groups = ["all"]
  volume_size = 10
  config_drive = "true"
  use_blockstorage_volume = "true"
  network
}