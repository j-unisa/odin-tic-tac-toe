# TODO: Add player choice as an instance variable
# TODO: Add method to ask player for row choice
# TODO: Add method to ask player for column choice
# TODO: Hard code grid with any choices made and print it out when asking player for next choice
# TODO: Create an array of 3 arrays representing the 3 rows of choices
#       Each nested array will initially have 3 empty strings
# TODO: Choices will be saved to the nested arrays
# TODO: Use nested #each method to iterate through choices and print them out
#       After each choice is printed, print a "|", unless it's the last choice
#       After the outer #each method is done, print a new line with 5 dashes, unless it's the last array

require_relative "lib/player"

puts "Enter your name: "
player_name = gets.chomp

puts "Choose x or o"
player_mark = gets.chomp

player = Player.new(player_name, player_mark)

cpu_mark = player_mark == "x" ? "o" : "x"
cpu = Player.new("CPU", cpu_mark)

p player
p cpu
