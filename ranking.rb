class Event
	attr_reader :rounds, :couples, :current_round, :current_round_num, :num_rounds#, :start_num_couples

	def initialize (num_rounds, couples)
		@rounds = Array.new
		@num_rounds = num_rounds
		@current_round_num = num_rounds
		#@start_num_couples = couples.size
		start_next_round couples
	end

	def start_next_round (couples)
		@couples = couples
		@current_round = Round.new current_round_num, couples
		@current_round_num -= 1
		#@start_num_couples /= 2
		@rounds.push @current_round
	end
end

class Round
	attr_reader :round_num, :recall_num, :couples, :num_couples
 
	def initialize (round_num, couples)
		@round_num = round_num
		@recall_num = couples.size
		@couples = Hash.new
		couples.each { |x| @couples[x] = Array.new }
		@num_couples = couples.size
	end

	def add_scores (scores, name)
		scores.each do |key, val|
			@couples[key].push val
		end
		calculate
	end

	def add_recalls (recalls)
		recalls.each do |key, val|
			@couples[key].push val
		end
		calculate
	end

	def calculate
		# Final
		if @round_num == 1
			# Frequency of numbers
			couples_scores = @couples.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |k,v| v }
			couples_scores.each do |name, scores|
				
			end
		else
			# Recalls
			recalls = Hash.new
			@couples.each do |name, scores|
				sum = scores.inject { |sum,x| sum + x }
				recalls[name] = sum
			end
			recalls.sort_by { |k,v| v }.reverse.take(@recall_num)
		end
	end
end

class Couple
	def initialize (man_name, woman_name)
		@man = man_name
		@woman = woman_name
	end

	def get_combined_name
		"{@man}/{@woman}"
	end
end

couples = Array.new
couples.push Couple.new "one", "one"
couples.push Couple.new "two", "two"
couples.push Couple.new "three", "three"
couples.push Couple.new "four", "four"
couples.push Couple.new "five", "five"
couples.push Couple.new "six", "six"
couples.push Couple.new "seven", "seven"

event  = Event.new 1, couples
event.current_round