require File.dirname(__FILE__) + '/../lib/viewpoint'
vp = Viewpoint.instance
vp.find_folders
mail = vp.get_folder("Inbox")
msgs = mail.get_todays_messages

puts "Sender		| Subject		| Recieved"
msgs.each do |msg|
	puts "#{msg.sender}		| #{msg.subject}		|#{msg.date_time_recieved}"
end
