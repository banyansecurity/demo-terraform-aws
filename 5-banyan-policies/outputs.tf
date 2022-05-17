output "web_policy_id" {
  value = banyan_policy_web.web_everyone_high.id
}

output "infra_policy_id" {
  value = banyan_policy_infra.infra_everyone_high.id
}