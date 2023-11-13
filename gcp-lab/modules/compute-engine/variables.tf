variable "convention" {
  type = string
}

variable "owner" {
  type = string
}

variable "project_id" {
  description = "The ID of the project where subnets will be created"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the Google Compute Instance Template"
  type        = string
}

variable "region" {
  description = "The region for the Google Compute Instance Template"
  type        = string
}

variable "source_image" {
  description = "The source image for the Google Compute Instance Template"
  type        = string
}

variable "network_name" {
  description = "The name of the network for the Google Compute Instance Template"
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the subnetwork for the Google Compute Instance Template"
  type        = string
}

variable "instance_name" {
  description = "The name of the Google Compute Instance"
  type        = string
}

variable "zones" {
  description = "The zones of the Google Compute Instance Group"
  type        = list(string)
}

variable "base_instance_name" {
  description = "The base instance name for the Google Compute Instance Group Manager"
  type        = string
  default     = "app"
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
  default     = 4
}

variable "min_replicas" {
  description = "The minimum number of replicas for the Google Compute Autoscaler"
  type        = number
  default     = 2
}

variable "cooldown_period" {
  description = "The cooldown period for the Google Compute Autoscaler"
  type        = number
  default     = 60
}

variable "cpu_utilization_target" {
  description = "The CPU utilization target for the Google Compute Autoscaler"
  type        = number
}

variable "load_balancing_utilization_target" {
  description = "The load balancing utilization target for the Google Compute Autoscaler"
  type        = number
}

variable "startup_script" {
}

variable "sshkey_file" {
  
}