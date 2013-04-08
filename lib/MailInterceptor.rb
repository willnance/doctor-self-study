# To change this template, choose Tools | Templates
# and open the template in the editor.

class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "wllnance@gmail.com"
  end
end
