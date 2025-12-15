locals {
  # Flatten ingress rules for iteration
  ingress_rules = flatten([
    for sg_key, sg in var.security_groups : [
      for idx, rule in sg.ingress_rules : {
        sg_key                    = sg_key
        rule_key                  = "${sg_key}-ingress-${idx}"
        description               = rule.description
        from_port                 = rule.from_port
        to_port                   = rule.to_port
        protocol                  = rule.protocol
        cidr_blocks               = rule.cidr_blocks
        ipv6_cidr_blocks          = rule.ipv6_cidr_blocks
        source_security_group_id  = rule.source_security_group_id
        source_security_group_key = rule.source_security_group_key
      }
    ]
  ])

  # Flatten egress rules for iteration
  egress_rules = flatten([
    for sg_key, sg in var.security_groups : [
      for idx, rule in sg.egress_rules : {
        sg_key                    = sg_key
        rule_key                  = "${sg_key}-egress-${idx}"
        description               = rule.description
        from_port                 = rule.from_port
        to_port                   = rule.to_port
        protocol                  = rule.protocol
        cidr_blocks               = rule.cidr_blocks
        ipv6_cidr_blocks          = rule.ipv6_cidr_blocks
        source_security_group_id  = rule.source_security_group_id
        source_security_group_key = rule.source_security_group_key
      }
    ]
  ])

  # Convert flattened lists to maps for for_each
  ingress_rules_map = {
    for rule in local.ingress_rules : rule.rule_key => rule
  }

  egress_rules_map = {
    for rule in local.egress_rules : rule.rule_key => rule
  }
}
