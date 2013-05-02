#authors Will Nance and Sanket Prabhu, with help from tutorials
require 'MailInterceptor'

#authors Will Nance and Sanket Prabhu

#using instructions from this video: http://railscasts.com/episodes/206-action-mailer-in-rails-3
ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 587,
  :domain => 'mail.google.com',
  :user_name  => "doctorselfstudy@gmail.com",
  :password  => "dsspassword",
  :authentication  => 'plain',
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000" if Rails.env.development?
ActionMailer::Base.default_url_options[:host] = "doctorselfstudy.herokuapp.com" if Rails.env.production?
# TODO uncomment this to correctly send emails in production mode
Mail.register_interceptor(MailInterceptor) if Rails.env.development?