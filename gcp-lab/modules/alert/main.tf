
resource "google_monitoring_notification_channel" "email" {
    display_name = "Notification Channel"
    type         = "email"
    labels = {
        email_address = var.mail
    }
}

resource "google_monitoring_alert_policy" "alert_scale"{
    display_name = "Group size"
    combiner = "OR"
    conditions {
        display_name = "Group condition"
        condition_threshold {
            filter    = "resource.type = \"instance_group\" AND resource.labels.instance_group_name = \"igm-longvdh3-us-central1-test-google-lab\" AND metric.type = \"compute.googleapis.com/instance_group/size\""
            duration = "0s"
            comparison = "COMPARISON_GT"
            aggregations {
                alignment_period = "60s"
                per_series_aligner = "ALIGN_MAX"
            }
        }
    }
    notification_channels = [ google_monitoring_notification_channel.email.id]
}

# resource "google_monitoring_alert_policy" "alert"{
#     display_name = "VMs Alert"
#     combiner = "OR"
#     conditions {
#         display_name = "VM Creation/Deletion Condition"
#         condition_threshold {
#             filter    = "resource.type = \"autoscaler\" AND metric.type = \"autoscaler.googleapis.com/capacity\""
#             duration = "0s"
#             comparison = "COMPARISON_GT"
#             aggregations {
#                 alignment_period = "60s"
#                 cross_series_reducer = "REDUCE_NONE"
#                 per_series_aligner = "ALIGN_MAX"
#             }
#             trigger {
#                 count = 1
#             }
#             threshold_value = 2
#         }
#     }
#     notification_channels = [ google_monitoring_notification_channel.email.id]
# }