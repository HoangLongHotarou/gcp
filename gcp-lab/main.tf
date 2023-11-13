locals {
  convention  = "${var.owner}-${var.region}-${var.env}-${var.app}"
  ssh_keyfile = "${var.owner}:${file("${abspath(path.module)}/keys/id_rsa.pub")}"
  template    = file("${abspath(path.module)}/scripts/customize.sh")
  cert        = file("${abspath(path.module)}/keys/ssl/certificate.cert")
  cert_key    = file("${abspath(path.module)}/keys/ssl/private.key")
}

module "network" {
  source       = "./modules/network"
  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = var.routing_mode
  subnets      = var.subnets
  firewalls    = var.firewalls
}

module "compute_engine" {
  source                            = "./modules/compute-engine"
  project_id                        = var.project_id
  instance_name                     = var.instance_name
  machine_type                      = var.machine_type
  region                            = var.region
  target_size                       = var.target_size
  named_port_name                   = var.named_port_name
  named_port_port                   = var.named_port_port
  max_replicas                      = var.max_replicas
  min_replicas                      = var.min_replicas
  cpu_utilization_target            = var.cpu_utilization_target
  load_balancing_utilization_target = var.load_balancing_utilization_target
  startup_script                    = local.template
  sshkey_file                       = local.ssh_keyfile
  convention                        = local.convention
  source_image                      = var.source_image
  subnetwork_name                   = var.subnetwork_name
  network_name                      = var.instance_network_name
  owner                             = var.owner
  zones                             = var.zones
  depends_on                        = [module.network]
}

module "load_balancing" {
  source         = "./modules/loadbalancer/regional"
  project_id     = var.project_id
  lb_name        = var.instance_name
  static_ip      = var.static_ip
  url            = var.url
  instance_group = module.compute_engine.instance_group
  region         = var.region
  network        = module.network.network_id
  convention     = local.convention
  cert           = local.cert
  cert_key       = local.cert_key
  depends_on     = [module.compute_engine]
}

module "alert" {
  source = "./modules/alert"
  mail   = var.mail
}
