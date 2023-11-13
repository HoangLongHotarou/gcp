output "instance_group" {
  description = "Instance-group url of managed instance group"
  value       = google_compute_region_instance_group_manager.instance.instance_group
}