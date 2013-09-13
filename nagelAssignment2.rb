# Author: Corey Nagel
# Email: corey.nagel@colorado.edu
# github: https://github.com/coreynagel/hw2.git

# Assignment 2: Programming in Ruby
puts "Assignment 2: Programming in Ruby\n\n"

# Part 0: finished parts 3 and 4 from Lab2
puts "Part 0: finished parts 3 and 4 from Lab2\n\n"

# Lab 2: PART 3: ROCK PAPER SCISSORS
puts "Lab2: PART 3: ROCK PAPER SCISSORS\n\n"

class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
	raise WrongNumberOfPlayersError unless game.length == 2
	raise NoSuchStrategyError unless game[0][1].match(/[rpsRPS]/) && game[1][1].match(/[rpsRPS]/)
	game[0][1].upcase!
	game[1][1].upcase!

	

	if game[0][1] === game[1][1]
		return game[0]
	else
		if game[0][1] === 'R'
			if game [1][1] === 'S'
				return game[0]
			else 
				return game[1]
			end
		elsif game[0][1] === 'S'
			if game[1][1] === 'P'
				return game[0]
			else 
				return game[1]
			end
		else	# p1 === P
			if game[1][1] === 'R'
				return game[0]
			else
				return game[1]
			end
		end
	end
end

puts "rps_game_winner TEST"
testgame = [["Armando", "R"], ["Dave", "S"]]
puts testgame.to_s
winner = rps_game_winner(testgame)
puts "winner = " + winner.to_s + "\n\n"

def rps_tournament_winner(tournament)
	round_winners = Array.new()
	puts tournament.to_s
	if tournament[0][0].class != round_winners.class
		tournament = rps_game_winner(tournament)
		puts tournament.to_s + "Round Winner"
		return tournament
	end
	rps_tournament_winner([rps_tournament_winner(tournament[0]),
						   rps_tournament_winner(tournament[1])])
	
end

tournament1 =[
    	[
        	[ ["Armando", "P"], ["Dave", "S"] ],
        	[ ["Richard", "R"],  ["Michael", "S"] ],
    	],
    	[
       		[ ["Allen", "S"], ["Omer", "P"] ],
        	[ ["David E.", "R"], ["Richard X.", "P"] ]
    	]
	]

puts "rps_tournament_winner TEST\n\n"
puts "\n" + rps_tournament_winner(tournament1).to_s + "Grand Champion\n\n"


# Lab2: PART 4: ANAGRAMS
puts "Lab2: PART 4: ANAGRAMS\n\n"

def combine_anagrams(words)
	anagrams = Array.new
	words.each do |word|
		foundanagram = false
		wordinarray = Array.new([word])
		if anagrams.empty?			
			anagrams.push(wordinarray)
		else
			anagrams.each do |anagram|
				sortword = word.downcase.chars.sort.join
				sortanagram = anagram[0].downcase.chars.sort.join
				if sortword == sortanagram
					foundanagram = true
					anagram.push(word)
				end
			end
			if foundanagram != true
				anagrams.push(wordinarray)
			end
		end
	end
	return anagrams
end

puts "combine_anagrams test\n\n"
testwords = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'] 
puts "Input: " + testwords.to_s 
puts "Output: " + combine_anagrams(testwords).to_s
puts "\n"


# Part 1: Classes
puts "Part 1: Classes\n"

# Part 1: A 

class Dessert
    def initialize(name, calories)
        @name = name
        @calories = calories
    end

    def healthy?
        return @calories <= 200
    end

    def delicious?
        return true
    end
end

puts "\ndessert class testing\n\n"
cake = Dessert.new("cake", 300)
puts "cake is healthy? " + cake.healthy?.to_s
puts "cake is delicious? " + cake.delicious?.to_s
smallercake = Dessert.new("smallercake", 150)
puts "smallercake is healthy? " + smallercake.healthy?.to_s
puts "smallercake is delicious? " + smallercake.delicious?.to_s

# Part 1: B

class JellyBean < Dessert
    def initialize(name, calories, flavor)
        @name = name
        @calories = calories
        @flavor = flavor
    end

    def delicious?
        if @flavor.downcase == "black licorice"
        	return false
        end
        return true
    end
end

puts "\nJellyBean class testing\n\n"
goodbean = JellyBean.new("goodbean", 10, "good flavor")
puts "goodbean is healthy? " + goodbean.healthy?.to_s
puts "goodbean is delicious? " + goodbean.delicious?.to_s
badbean = JellyBean.new("badbean", 10, "black licorice")
puts "badbean is healthy? " + badbean.healthy?.to_s
puts "badbean is delicious? " + badbean.delicious?.to_s


# Part 2: Object Oriented Programming
puts "\nPart 2: Object Oriented Programming"

class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attribute's getter
        attr_reader attr_name+"_history" # create bar_history getter
        class_eval %Q{
        	def #{attr_name}= (value)
        		if #{attr_name+'_history'}.nil?
        			@#{attr_name+'_history'} = [nil]
        		end
        		@#{attr_name+'_history'}.push value
        		@#{attr_name} = value
        	end

        	def #{attr_name+'_history'}
        		@#{attr_name+'_history'}
        	end
        }
    end
end

class Foo
    attr_accessor_with_history :bar
end

puts "\n attr_accessor_with_history test with foo\n\n"
f = Foo.new
puts "f.bar = 1" 
f.bar = 1
puts "f.bar = 2"
f.bar = 2
puts "f.bar_history = " + f.bar_history.to_s 
# => if your code works, should be [nil, 1, 2]


# Part 3: More OOP
puts "\nPart 3: More OOP\n\n"

# Part 3: A

class Numeric
 	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
 	def method_missing(method_id)
   		singular_currency = method_id.to_s.gsub( /s$/, '')
   		if @@currencies.has_key?(singular_currency)
     		self * @@currencies[singular_currency]
   		else
     		super
   		end
 	end
 	def in(new_currency)
 		singular_new_currency = new_currency.to_s.gsub( /s$/, '')
 		if @@currencies.has_key?(singular_new_currency)
 			self / @@currencies[singular_new_currency]
 		else
 			super
 		end
 	end
end

puts "Currency conversion test\n\n"

puts "5 dollars in euros is "
puts 5.dollars.in(:euros)
puts "10 euros in rupees is "
puts 10.euros.in(:rupees)
puts "8 dollars in dollars is "
puts 8.dollars.in(:dollars)
puts "1 dollar in rupees is "
puts 1.dollar.in(:rupees) 
puts "10 rupees in euros is "
puts 10.rupees.in(:euro)

# Part 3: B

# palindrome function from part 2 from lab2
def palindrome?(string)
	string.downcase!
	string = string.gsub(/\W+/, '')
	if string === string.reverse
		return true
	else
		return false
	end
end

class String
	def palindrome?
		Object.send(:palindrome?, self)
	end
end

puts "\nstring.palindrome? test\n\n"

puts "Is foo a palindrome?"
puts "foo".palindrome?
puts "Is abba a palindrome?"
puts "abba".palindrome?

# Part 3: C 

module Enumerable
	def palindrome?
		return self.collect{|item| item} == self.collect{|item| item}.reverse
	end
end

puts "Is [1,2,3,2,1] a palindrome?"
puts [1,2,3,2,1].palindrome? # => true
puts "Is [1,3,3,2,1] a palindrome?"
puts [1,3,3,2,1].palindrome?
puts "do hashes cause an error"
hash = {"item1" => 1, "item2" => 2, "item3" => 2}
puts hash.palindrome?

# Part 4: Blocks

class CartesianProduct
    include Enumerable

    def initialize(array1, array2)
    	@array1 = array1
    	@array2 = array2
  	end

    def each
    	@array1.each do |element1|
    		@array2.each do |element2|
    			yield [element1, element2]
    		end
    	end
    end

end

puts "\nCartesianProduct Testing\n\n"

c = CartesianProduct.new([:a,:b], [4,5])
puts "The CartesianProduct of [:a,:b] and [4,5] is "
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

c = CartesianProduct.new([:a,:b], [])
puts "The CartesianProduct of [:a,:b] and [] is "
c.each { |elt| puts elt.inspect }
# Nothing printed since Cartesian product of anything with an empty collection is empty

puts "\n... hm, must be empty"

