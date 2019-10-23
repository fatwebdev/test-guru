# Preview all emails at http://localhost:3000/rails/mailers/feedbacks_mailer
class FeedbacksMailerPreview < ActionMailer::Preview
  def feedback
    feedback = User.first.feedbacks.new(title: 'Hi', body: 'You are awesome!')

    FeedbacksMailer.feedback(feedback)
  end
end
