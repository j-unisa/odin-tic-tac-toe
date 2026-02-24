# TODO: Remove pry-byebug after project is complete
require "pry-byebug"
require_relative "lib/player"

# Valid space method
def empty_space?(arr, row, column)
  arr[row][column] == " "
end

puts "Enter your name: "
player_name = gets.chomp

# TODO: Add input validation (e.g. while loop)
puts "Choose x or o"
player_mark = gets.chomp

player = Player.new(player_name, player_mark)

cpu_mark = player_mark == "x" ? "o" : "x"
cpu = Player.new("CPU", cpu_mark)

grid = Array.new(3) { Array.new(3, " ") }

while grid.flatten.include?(" ")
  puts ""

  grid.each_with_index do |row, row_index|
    row.each_with_index do |column, column_index|
      print column
      print "|" unless column_index == row.length - 1
    end

    puts "\n-----" unless row_index == grid.length - 1
  end

  puts "\n\nChoose row 1, 2, or 3."
  player_row = gets.chomp.to_i - 1
  puts "Choose column 1, 2, or 3."
  player_column = gets.chomp.to_i - 1

  until empty_space?(grid, player_row, player_column)
    puts "The space you chose is taken."
    puts "Please choose an empty space."
    puts "Choose row 1, 2, or 3."
    player_row = gets.chomp.to_i - 1
    puts "Choose column 1, 2, or 3."
    player_column = gets.chomp.to_i - 1
  end

  grid[player_row][player_column] = player.mark

  # TODO: Add cpu turn
end
