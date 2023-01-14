resource "yandex_alb_backend_group" "this" {
  name = "alb-backend"
  
  http_backend {
    name                   = "http-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = [
      tolist(yandex_compute_instance_group.this.application_load_balancer).0.target_group_id
    ]
    load_balancing_config {
      panic_threshold      = 90
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15 
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name   = "alb-http-router"
}

resource "yandex_alb_virtual_host" "this" {
  name           = "alb-virtual-host"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "nginx-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout          = "3s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {
  name        = "alb-load-balancer"
  network_id  = yandex_vpc_network.this.id
  depends_on = [
    yandex_vpc_subnet.this
  ]

  allocation_policy {
    location {
      zone_id   = var.az[0]
      subnet_id = yandex_vpc_subnet.this[var.az[0]].id
    }
  }

  listener {
    name = "nginx-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 9000 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }
}