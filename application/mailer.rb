require 'mail'

module Mailer
  extend self

  def retreive_last_email(user_name, password)
    Mail.defaults do
    retriever_method :pop3, { :address             => "pop.gmail.com",
                              :port                => 995,
                              :user_name           => user_name,
                              :password            => password,
                              :enable_ssl          => true }
    end

    mail = Mail.last
    puts "***Email Retreived***"
    mail.subject
  end

  def send_results(attendees, user_name, password, outgoing_email)

    options = { :enable_starttls_auto => true,
                :address => "smtp.gmail.com",
                :port => "587",
                :authentication => :plain,
                :user_name => user_name,
                :password => password
              }

    Mail.defaults do
      delivery_method :smtp, options
    end

    mail = Mail.new do
          to outgoing_email
          from user_name
          subject "Attendees for Event"
          body (attendees)
    end

    mail.deliver
    puts "***Email Sent***"

  end
end

