variable "location" {
  type        = string
  description = "Azure region for deployment of TreyResearch"
}

variable "plaform_mgmt_rg_name" {
  type        = string
  description = "TreyResearch-mgmt"
}

variable "plaform_connectivity_rg_name" {
  type        = string
  description = "TreyResearch-Connectivity"
}

variable "plaform_identity_rg_name" {
  type        = string
  description = "TreyResearch-Identity"
}