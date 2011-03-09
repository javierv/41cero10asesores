class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject << message.bcc.join(" ")
    message.to = message.cc = []
    message.bcc = [APP_CONFIG["email"]]
  end
end

unless Rails.env.test?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end
