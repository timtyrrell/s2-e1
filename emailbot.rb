require 'mail'

Mail.defaults do
   retriever_method :pop3, { :address             => "pop.gmail.com",
                             :port                => 995,
                             :user_name           => 'gowallabot@gmail.com',
                             :password            => '',
                             :enable_ssl          => true }
 end

mail = Mail.first
puts mail.body.decoded

#I know this is shit, I was just doing some testing

