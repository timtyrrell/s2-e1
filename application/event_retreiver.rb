require 'patron'
require 'json/pure'

module EventRetreiver
  extend self

  def get_event_attendees(event_id, gowalla_key)
    sess = Patron::Session.new
    sess.timeout = 10
    sess.base_url = "http://api.gowalla.com"
    sess.headers['X-Gowalla-API-Key'] = gowalla_key
    sess.headers['Accept'] = 'application/json'
    sess.headers['Content-Type'] = 'application/json'

    resp = sess.get("/spots/#{event_id}/events")

    if resp.status < 400
      puts "***Sucessfully communicated with Gowalla's API***"
      result =  JSON.parse resp.body

      users = result["activity"]
      users.collect! do |returned_users|
        "#{returned_users["user"]["last_name"]}, #{returned_users["user"]["first_name"]}  "
      end
    else
      puts "Error during event retreival: Response code: #{resp.status}"
    end
  end
end

