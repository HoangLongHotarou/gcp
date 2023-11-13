# Provider
variable "owner" {
  type = string
}

variable "zone" {
  description = "The zone of the Google Cloud project"
  type        = string
  default = "us-central1-a"
}

variable "env" {
  description = "value"
}

variable "app" {
  description = "value"
}

variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}
###########################################################

# network
variable "network_name" {
  description = "The name of the Google Cloud VPC network"
  type        = string
}

variable "routing_mode" {
  description = "The routing mode for the VPC network (e.g., REGIONAL or GLOBAL)"
  type        = string
}

variable "subnets" {
  description = "A list of subnets to create within the VPC network"
  type = list(object({
    subnet_name   = string
    subnet_ip     = string
    subnet_region = string
    role          = optional(string)
    purpose       = optional(string)
  }))
}

variable "firewalls" {
  description = "A list of firewalls to create within the VPC network"
  type = list(object({
    firewall_name = string
    protocol      = string
    ports         = list(string)
    source_tags   = list(string)
    source_ranges = list(string)
  }))
}
#########################################################



variable "instance_name" {
  description = "The name of the Google Compute Instance"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the Google Compute Instance Template"
  type        = string
  default     = "e2-micro"
}

variable "region" {
  description = "The region for the Google Compute Instance Template"
  type        = string
}

variable "source_image" {
  description = "The source image for the Google Compute Instance Template"
  type        = string
}

variable "instance_network_name" {
  description = "The name of the network for the Google Compute Instance Template"
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the subnetwork for the Google Compute Instance Template"
  type        = string
}

variable "target_size" {
  description = "The target size for the Google Compute Instance Group Manager"
  type        = number
  default     = 2
}

variable "named_port_name" {
  description = "The name of the named port for the Google Compute Instance Group Manager"
  type        = string
  default     = "http"
}

variable "named_port_port" {
  description = "The port for the named port for the Google Compute Instance Group Manager"
  type        = number
  default     = 80
}

variable "max_replicas" {
  description = "The maximum number of replicas for the Google Compute Autoscaler"
  type        = number
  default     = 10
}

variable "min_replicas" {
  description = "The minimum number of replicas for the Google Compute Autoscaler"
  type        = number
  default     = 1
}

variable "cooldown_period" {
  description = "The cooldown period for the Google Compute Autoscaler"
  type        = number
  default     = 60
}

variable "cpu_utilization_target" {
  description = "The CPU utilization target for the Google Compute Autoscaler"
  type        = number
  default     = 0.6
}

variable "load_balancing_utilization_target" {
  description = "The load balancing utilization target for the Google Compute Autoscaler"
  type        = number
  default     = 0.6
}


variable "zones" {
  type = list(string)
}


variable "mail" {
  type = string
}

# Load balancing
# "35.209.106.147"
variable "static_ip" {
  type = string 
}

variable "url" {
  type = string
}