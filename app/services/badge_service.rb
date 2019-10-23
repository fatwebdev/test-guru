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
      case badge.rule_type.to_sym
      when :by_category
        add_badge!(badge) if all_tests_category?(badge.rule_param)
      when :by_level
        add_badge!(badge) if completed_all_test_by_level?(badge.rule_param.to_i)
      when :by_first_try
        add_badge!(badge) if test_first_try?(badge.rule_param)
      end
    end
  end

  private

  def add_badge!(badge)
    @user.badges << badge
  end

  def all_tests_category?(category)
    if @passing_test.test.category.title == category
      passed_count = PassingTest.correct_passed_tests(@user)
                                .pluck('DISTINCT test_id')
                                .count
      Category.find_by(title: category).tests.count == passed_count
    end
  end

  def test_certaion_level?(level)
    @passing_test.test.level == level if @passing_test.done
  end

  def test_first_try?(title)
    if @passing_test.test.title == title && @passing_test.done
      @user.tests.where(title: title).count == 1
    end
  end
end
