class BadgeService
  def self.rule_types
    {
      by_category: I18n.t('service.badge.by_category'),
      by_level: I18n.t('service.badge.by_level'),
      by_first_try: I18n.t('service.badge.by_first_try')
    }
  end

  def self.options_for_select
    rule_types.map(&:reverse)
  end
end
