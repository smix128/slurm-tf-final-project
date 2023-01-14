resource "yandex_compute_instance_group" "this" {
  name                = "instance-group"
  folder_id           = "${var.yc_folder_id}"
  service_account_id  = "${yandex_iam_service_account.this.id}"
  deletion_protection = false
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_vpc_subnet.this
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
      nat = false
    }

    network_settings {
      type = "STANDARD"
    }
  }

  application_load_balancer {
    target_group_name = "nginx-target-group"
  }

  allocation_policy {
    zones = var.az
  }

  scale_policy {
    fixed_scale {
      size = var.scale
    }
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}