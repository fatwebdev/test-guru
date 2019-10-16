# Preview all emails at http://localhost:3000/rails/mailers/tests_mailer
class TestsMailerPreview < ActionMailer::Preview
  def complited_test
    passing_test = PassingTest.new(
      user: User.first,
      test: Test.first
    )

    TestsMailer.complited_test(passing_test)
  end
end
