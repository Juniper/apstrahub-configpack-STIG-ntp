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

# variable "servers" {
#   type = list(string)
#   description = "List of NTP server IP addresses, must have the same length as the `keys` list."
#   default = [
#     "192.2.0.11",
#     "192.2.0.12",
#   ]
# }
#
# variable "keys" {
#   type = list(string)
#   description = "List of SHA256 key strings, must have the same length as the `servers` list."
#   default = [
#     "foo",
#     "bar",
#   ]
# }

variable "ntp_servers" {
  type = map (string)
  description = "Map of NTP authentication strings keyed by server IP address."
  default = {
    "192.2.0.11" = "foo"
    "192.2.0.12" = "bar"
  }
}

variable "source_ip" {
  type = string
  description = "Source IP to be used when sending NTP traffic."
  default = "192.2.0.1"
}