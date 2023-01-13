resource "yandex_compute_image" "this" {
  name       = "nginx-1"
}

resource "yandex_compute_instance_group" "this" {
  name                = "nginx-ig"
  folder_id           = "b1g9uka7gvk8bkh2s9ae"
  service_account_id  = "${yandex_iam_service_account.this.id}"
  deletion_protection = true
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${yandex_compute_image.this.id}"
        size     = 4
      }
    }
    network_interface {
      network_id = yandex_vpc_network.this.id
      subnet_ids = ["${yandex_vpc_subnet.subnet-ru-central1-a.id}"]
    }
    metadata = {
      ssh-keys = "yc-user:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}