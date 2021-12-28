# frozen_string_literal: true
puts 'in time.rb'
# MessagePack extention packer and unpacker for built-in Time class
module MessagePack
  module Time
	puts 'in time module'
    # 3-arg Time.at is available Ruby >= 2.5
    TIME_AT_3_AVAILABLE = begin
                            !!::Time.at(0, 0, :nanosecond)
                          rescue ArgumentError
                            false
                          end
	puts 'after time at 3 available check'
    Unpacker = if TIME_AT_3_AVAILABLE
                 lambda do |payload|
                   tv = MessagePack::Timestamp.from_msgpack_ext(payload)
                   ::Time.at(tv.sec, tv.nsec, :nanosecond)
                 end
               else
				 puts 'unpack when time at 3 is not available'
                 lambda do |payload|
                   tv = MessagePack::Timestamp.from_msgpack_ext(payload)
				   puts tv
                   ::Time.at(tv.sec, tv.nsec / 1000.0r)
                 end
               end

    Packer = lambda { |time|
      MessagePack::Timestamp.to_msgpack_ext(time.tv_sec, time.tv_nsec)
    }
  end
end
puts 'outside the messagePack module'