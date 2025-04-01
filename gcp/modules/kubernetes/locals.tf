locals {
  node_locations_to_use = var.GCP_LOCATION_IDS == null ? null : (
    length(var.GCP_LOCATION_IDS) > 0 ? var.GCP_LOCATION_IDS : null
  )
}
