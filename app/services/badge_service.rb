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

  def initialize(passing_test)
    @passing_test = passing_test
    @user = passing_test.user
  end

  def call
    Badge.find_each do |badge|
      @user.badges << badge if send("#{badge.rule_type}_award?", badge.rule_param)
    end
  end

  private

  def by_category_award?(category)
    if @passing_test.test.category.title == category
      passed_count = PassingTest.correct_passed_tests(@user)
                                .pluck('DISTINCT test_id')
                                .count
      Category.find_by(title: category).tests.count == passed_count
    end
  end

  def by_level_award?(level)
    @passing_test.test.level == level.to_i if @passing_test.done
  end

  def by_first_try_award?(title)
    if @passing_test.test.title == title && @passing_test.done
      @user.tests.where(title: title).count == 1
    end
  end
end
