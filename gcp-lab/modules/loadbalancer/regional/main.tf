resource "google_compute_region_backend_service" "default" {
  provider              = google-beta
  project               = var.project_id
  name                  = "backend-${var.convention}"
  region                = var.region
  health_checks         = [google_compute_region_health_check.default.id]
  timeout_sec           = 10
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = "http"

  dynamic "log_config" {
    for_each = var.log_config
    content {
      enable      = log_config.value.enable
      sample_rate = log_config.value.sample_rate
    }
  }

  dynamic "backend" {
    for_each = var.backend
    content {
      group           = var.instance_group
      balancing_mode  = backend.value.balancing_mode
      capacity_scaler = backend.value.capacity_scaler
      max_utilization = backend.value.max_utilization
    }
  }
}

resource "google_compute_region_health_check" "default" {
  provider = google-beta
  project  = var.project_id
  name     = "healthcheck-${var.convention}"
  region   = var.region
  tcp_health_check {
    port = "80"
  }
  check_interval_sec = 5
  timeout_sec        = 5
}

# reserved IP address
# resource "google_compute_address" "default" {
#   provider     = google-beta
#   project      = var.project_id
#   region       = var.region
#   name         = "website-ip-1"
#   network_tier = "STANDARD"
# }

# forwarding rule
# resource "google_compute_forwarding_rule" "http" {
#   provider              = google-beta
#   name                  = "fr-http-${var.convention}"
#   project               = var.project_id
#   region                = var.region
#   port_range            = "80"
#   network_tier          = "STANDARD"
#   load_balancing_scheme = "EXTERNAL_MANAGED"
#   network               = var.network
#   target                = google_compute_region_target_http_proxy.default.id
#   ip_address            = google_compute_address.default.id
# }

resource "google_compute_forwarding_rule" "https" {
  provider              = google-beta
  name                  = "fr-https-${var.convention}"
  project               = var.project_id
  region                = var.region
  port_range            = "443"
  network_tier          = "STANDARD"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  network               = var.network
  target                = google_compute_region_target_https_proxy.default.id
  ip_address            = var.static_ip

  # ip_address            = google_compute_address.default.id
}

# HTTPS proxy when ssl is true
resource "google_compute_region_target_https_proxy" "default" {
  name             = "thp-${var.convention}"
  region           = var.region
  url_map          = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_region_ssl_certificate.default.id]
}

resource "google_compute_region_ssl_certificate" "default" {
  name        = "ssl-${var.convention}"
  private_key = var.cert_key
  certificate = var.cert
  # private_key = file("path/to/private.key")
  # certificate = file("path/to/certificate.crt")
}

# resource "google_compute_region_target_http_proxy" "default" {
#   provider = google-beta
#   name     = "httpproxy-${var.convention}"
#   region   = var.region
#   project  = var.project_id
#   url_map  = google_compute_region_url_map.default.id
# }

# resource "google_compute_region_url_map" "default" {
#   provider        = google-beta
#   name            = "urlmap-${var.convention}"
#   project         = var.project_id
#   region          = var.region
#   default_service = google_compute_region_backend_service.default.id
# }

resource "google_compute_region_url_map" "default" {
  provider = google-beta
  name     = "urlmap-${var.convention}"
  region   = var.region
  project  = var.project_id

  default_service = google_compute_region_backend_service.default.id

  # host_rule {
  #   hosts        = [var.url]
  #   path_matcher = "allpaths"
  # }

  # path_matcher {
  #   name            = "allpaths"
  #   default_service = google_compute_region_backend_service.default.id

  #   path_rule {
  #     paths   = ["/*"]
  #     service = google_compute_region_backend_service.default.id
  #   }
  # }
}
