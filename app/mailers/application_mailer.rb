class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGugu" email@testguru.com}
  layout 'mailer'
end
