require 'mail'
require 'patron'
require 'json/pure'

Mail.defaults do
   retriever_method :pop3, { :address             => "pop.gmail.com",
                             :port                => 995,
                             :user_name           => 'gowallabot@gmail.com',
                             :password            => '',
                             :enable_ssl          => true }
 end

mail = Mail.last
mail_command = mail.body.decoded

sess = Patron::Session.new
sess.timeout = 10
sess.base_url = "http://api.gowalla.com"
sess.headers['X-Gowalla-API-Key'] = ''
sess.headers['Accept'] = 'application/json'
sess.headers['Content-Type'] = 'application/json'

resp = sess.get("/spots/2380289/events")

if resp.status < 400
  result =  JSON.parse resp.body

  users = result["activity"]
  users.collect! do |returned_users|
    "#{returned_users["user"]["last_name"]}, #{returned_users["user"]["first_name"]}"
  end
#  if mail_command == 'all'
#    puts "Return #{users.length} users"
#  elsif mail_command.is_a?(Integer)
#    random_users = users.shuffle!.first(mail_command)
#    puts "Return #{random_users.length} users"
#  else
#    puts "Unsuccessful Gowalla API call with #{mail_command}."
#  end
    random_users = users.shuffle!.first(mail_command.to_i)
    puts "Return #{random_users.length} users"
else
  puts resp.status
end

