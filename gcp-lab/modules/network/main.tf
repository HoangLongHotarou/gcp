resource "google_compute_network" "network" {
  name                    = var.network_name
  routing_mode            = var.routing_mode
  project                 = var.project_id
  auto_create_subnetworks = false
}

locals {
  subnets = {
    for x in var.subnets :
    "${x.subnet_region}/${x.subnet_name}" => x
  }
  firewalls = {
    for x in var.firewalls :
    "${x.firewall_name}" => x
  }
}

resource "google_compute_subnetwork" "subnetwork" {
  network = google_compute_network.network.id
  project = var.project_id

  for_each         = local.subnets
  name             = each.value.subnet_name
  ip_cidr_range    = each.value.subnet_ip
  region           = each.value.subnet_region
  description      = lookup(each.value, "description", null)
  purpose          = lookup(each.value, "purpose", null)
  role             = lookup(each.value, "role", null)
  stack_type       = lookup(each.value, "stack_type", null)
  ipv6_access_type = lookup(each.value, "ipv6_access_type", null)
}

resource "google_compute_firewall" "firewall" {
  network = google_compute_network.network.id
  project = var.project_id

  for_each = local.firewalls
  name     = each.value.firewall_name

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
  source_tags   = each.value.source_tags
  source_ranges = each.value.source_ranges

  depends_on = [google_compute_subnetwork.subnetwork]
}
