#authors Will Nance and Sanket Prabhu

class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "wllnance@gmail.com"
  end
end
