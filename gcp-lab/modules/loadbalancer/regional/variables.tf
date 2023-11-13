variable "convention" {
  description = "value"
}

variable "project_id" {
  description = "The Google Cloud project ID."
}

variable "region" {
  description = "The GCP region for the resources."
}

variable "instance_group" {
  description = "The instance group to use for the backend."
}

variable "network" {
  description = "The GCP network to use."
}

variable "lb_name" {
  description = "The Project Name."
}

variable "log_config" {
  type = map(object({
    enable      = bool
    sample_rate = number
  }))
  default = {
    log1 = {
      enable      = true
      sample_rate = 1.0
    }
  }
}

variable "backend" {
  type = map(object({
    balancing_mode  = string
    capacity_scaler = number
    max_utilization = number
  }))
  default = {
    backend1 = {
      balancing_mode  = "UTILIZATION"
      capacity_scaler = 1.0
      max_utilization = 0.8
    }
  }
}


variable "cert" {
  type = string
}

variable "cert_key" {
  type = string
}

variable "static_ip" {
  type = string
}

variable "url" {
  type = string
}