#require 'gems/msgpack-ruby-master/lib/msgpack'
Dir.mkdir 'Data' unless Dir.exists?('Data')
simpleFile = File.new("Data/test.txt", "a+")

if simpleFile
	#data = simpleFile.syswrite("Yes , we should avoid rush in current situations")
	#puts data
	file_data = simpleFile.read
	puts file_data
	#puts data.methods
	#puts simpleFile.methods
	$game_message.face_name = 'People2'
	$game_message.face_index = 1
	$game_message.add(file_data)
	msg = MessagePack.pack($game_message)
	puts msg
else
	puts "Not able to access the file"
	$game_message.add("Not able to access the file")
end