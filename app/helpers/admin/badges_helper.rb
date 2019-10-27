module Admin::BadgesHelper
  def rule_name(rule)
    BadgeService.rule_types[rule.to_sym]
  end
end
