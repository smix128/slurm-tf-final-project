resource "yandex_compute_instance_group" "this" {
  name                = "${var.ig_name}"
  folder_id           = "${var.yc_folder_id}"
  service_account_id  = "${yandex_iam_service_account.this.id}"
  deletion_protection = false
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.this,
  ]
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${var.yc_image_id}"
        size     = 10
      }
    }

    metadata = {
      ssh-keys = "yc-user:${file("~/.ssh/id_rsa.pub")}"
    }

    network_interface {
      network_id = yandex_vpc_network.this.id
      nat = true
    }

    network_settings {
      type = "STANDARD"
    }
  }

    allocation_policy {
      zones = ["ru-central1-a"]
    }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}