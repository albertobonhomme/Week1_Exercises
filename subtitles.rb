require 'time'

class Filereader
	attr_accessor :input, :input_array, :index_to_modify, :output
	def initialize
		@input = IO.read("timing.txt")
		@index_to_modify = []
		@index_back = []
		@t = Date.new
		@output = []
	end

	def modify_displaying(interval)
		@input_array = @input.split("\n")
		find_timing(interval)
	end

	def find_timing(interval)
		@input_array.each do |line|
			if line.include?("-->")
				@index_to_modify.push(@input_array.index(line))
			end
		end
		get_time_to_modify(interval)
	end

	def get_time_to_modify(interval)
		@index_to_modify.each do |index|
			@index_back.push(@input_array[index].split(" --> "))	
		end
		add_interval_to_all(interval)
	end

	def add_interval_to_all(interval)
		@index_back.each do |pair|
			@result1 = (Time.parse(pair[0])+(interval/1.000000)).strftime("%H:%M:%S.%N")
			@result2 = (Time.parse(pair[1])+(interval/1.000000)).strftime("%H:%M:%S.%N")
			@output.push("#{@result1}" +" --> " + "#{@result2}")
		end
		result_timings
	end

	def result_timings
		i = 0
		@index_to_modify.each do |pair|
			@input_array[pair.to_int] = @output[i]
			i += 1
		end
		puts @input_array
	end
end



autoread = Filereader.new
# time delay added (in seconds)
autoread.modify_displaying(1)

