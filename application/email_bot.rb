require './mailer.rb'
require './event_retreiver.rb'
require 'yaml'

yml = YAML::load(File.open('./config.yml'))

bot_email_address = yml['bot_email_address']
bot_email_password = yml['bot_email_password']
gowalla_key = yml['gowalla_key']
outgoing_email_address = yml['outgoing_email_address']

event_id =  Mailer.retreive_last_email bot_email_address, bot_email_password
event_attendees =  EventRetreiver.get_event_attendees event_id, gowalla_key
Mailer.send_results event_attendees, bot_email_address, bot_email_password, outgoing_email_address

