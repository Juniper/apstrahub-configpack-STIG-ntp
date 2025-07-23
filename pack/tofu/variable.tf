#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "blueprint_id" {
  type = string
}

variable "name" {
  type    = string
  default = "STIG ntp"
}

variable "ntp_servers" {
  type = map (string)
  description = "Map of NTP SHA256 authentication strings keyed by server IP address."
  default = {
  }
}

variable "source_ip" {
  type = string
  description = "Source IP to be used when sending NTP traffic."
}