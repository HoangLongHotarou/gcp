resource "google_compute_region_instance_template" "instance" {
  project        = var.project_id
  name           = "it-${var.convention}"
  machine_type   = var.machine_type
  region         = var.region
  can_ip_forward = false

  disk {
    source_image = var.source_image
    auto_delete  = false
    boot         = true
  }

  # disk {
  #   source      = google_compute_region_disk.disk.self_link
  #   auto_delete = false
  #   boot        = false
  # }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  labels = {
    project_name = var.project_id,
    owner        = var.owner
  }

  metadata_startup_script = var.startup_script

  metadata = {
    ssh-keys = var.sshkey_file
  }
}

resource "google_compute_region_instance_group_manager" "instance" {
  project                   = var.project_id
  name                      = "igm-${var.convention}"
  base_instance_name        = "instance-${var.convention}"
  region                    = var.region
  distribution_policy_zones = var.zones

  version {
    instance_template = google_compute_region_instance_template.instance.self_link
  }

  target_size = var.target_size

  named_port {
    name = var.named_port_name
    port = var.named_port_port
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }

  depends_on = [google_compute_region_instance_template.instance]
}

resource "google_compute_region_autoscaler" "instance" {
  project = var.project_id
  name    = "autoscale-${var.convention}"
  target  = google_compute_region_instance_group_manager.instance.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period

    cpu_utilization {
      target = var.cpu_utilization_target
    }

    load_balancing_utilization {
      target = var.load_balancing_utilization_target
    }
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}
