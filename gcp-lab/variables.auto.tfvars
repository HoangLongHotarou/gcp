# provider
region = "us-central1"
owner  = "longvdh3"
env    = "test"
app    = "google-lab"

# Network
project_id   = "adept-now-400809"
network_name = "tf-mynetwork"
routing_mode = "GLOBAL"

subnets = [
  {
    subnet_name   = "subnet-01"
    subnet_ip     = "10.1.2.0/24"
    subnet_region = "us-central1"
  },
  {
    subnet_name   = "proxy-only-subnet"
    subnet_ip     = "10.129.0.0/23"
    role          = "ACTIVE"
    purpose       = "REGIONAL_MANAGED_PROXY"
    subnet_region = "us-central1"
  }
]

firewalls = [
  {
    firewall_name = "tf-allow-ssh"
    protocol      = "tcp"
    ports         = ["22"]
    source_tags   = ["load-balanced-backend"]
    source_ranges = ["35.235.240.0/20"]
  },
  {
    firewall_name = "tf-allow-proxy"
    protocol      = "tcp"
    ports         = ["80", "443"]
    source_tags   = ["load-balanced-backend"]
    source_ranges = ["10.129.0.0/23"]
  },
  {
    firewall_name = "tf-allow-check-health"
    protocol      = "tcp"
    ports         = ["80", "443"]
    source_tags   = ["allow-health-check"]
    source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  }
]

# instance
instance_name                     = "nginx-instance"
machine_type                      = "e2-micro"
source_image                      = "packer-nginx-ubuntu-image-1699845557"
instance_network_name             = "tf-mynetwork"
subnetwork_name                   = "subnet-01"
target_size                       = 2
named_port_name                   = "http"
named_port_port                   = 80
max_replicas                      = 4
min_replicas                      = 2
cooldown_period                   = 60
cpu_utilization_target            = 0.5
load_balancing_utilization_target = 0.5
zones                             = ["us-central1-a", "us-central1-f"]
# zones                             = ["us-central1-a"]
# mail
mail = "longvdh3@yopmail.com"

# load balancer
static_ip = "35.209.106.147"
url       = "rongu.site"
