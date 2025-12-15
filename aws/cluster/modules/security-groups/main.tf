resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = merge(var.default_tags, each.value.tags, {
    Name = each.value.name
  })
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = local.ingress_rules_map

  security_group_id = aws_security_group.this[each.value.sg_key].id
  description       = each.value.description
  from_port         = each.value.protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.protocol == "-1" ? null : each.value.to_port
  ip_protocol       = each.value.protocol

  cidr_ipv4                    = try(each.value.cidr_blocks[0], null)
  cidr_ipv6                    = try(each.value.ipv6_cidr_blocks[0], null)
  referenced_security_group_id = each.value.source_security_group_id != null ? each.value.source_security_group_id : (each.value.source_security_group_key != null ? aws_security_group.this[each.value.source_security_group_key].id : null)
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = local.egress_rules_map

  security_group_id = aws_security_group.this[each.value.sg_key].id
  description       = each.value.description
  from_port         = each.value.protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.protocol == "-1" ? null : each.value.to_port
  ip_protocol       = each.value.protocol

  cidr_ipv4                    = try(each.value.cidr_blocks[0], null)
  cidr_ipv6                    = try(each.value.ipv6_cidr_blocks[0], null)
  referenced_security_group_id = each.value.source_security_group_id != null ? each.value.source_security_group_id : (each.value.source_security_group_key != null ? aws_security_group.this[each.value.source_security_group_key].id : null)
}
