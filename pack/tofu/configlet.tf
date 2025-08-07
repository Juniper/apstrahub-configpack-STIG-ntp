#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

locals {
  keys = sort(keys(var.ntp_servers))
  i_k_s_list = [for i in range(length(var.ntp_servers)) : {
    idx = i + 1
    key = var.ntp_servers[local.keys[i]]
    srv = local.keys[i]
  }]
  key_line     = "authentication-key $${keynum} type sha256 value $${keystr};"
  key_lines    = join("\n    ", [for i in local.i_k_s_list : templatestring(local.key_line, { keynum = i.idx, keystr = i.key })])
  server_line  = "server $${srvrip} key $${keynum};"
  server_lines = join("\n    ", [for i in local.i_k_s_list : templatestring(local.server_line, { srvrip = i.srv, keynum = i.idx })])
  template     = <<-EOT
    system {
      ntp {
        $${keys}
        $${servers}
        trusted-key [ $${key_nums} ];
    {% if management_ip %}
        source-address {{management_ip}};
    {% endif %}
      }
    }
    EOT
}

resource "apstra_datacenter_configlet" "a" {
  blueprint_id = var.blueprint_id
  condition    = "role in [\"superspine\", \"spine\", \"leaf\", \"access\"]"
  name         = var.name
  generators = [
    {
      config_style = "junos"
      section      = "top_level_hierarchical"
      template_text = templatestring(local.template, {
        keys      = local.key_lines
        servers   = local.server_lines
        key_nums  = substr(join(" ", range(length(local.keys) + 1)), 2, -1)
      })
    },
  ]
}
