# TODO: Remove pry-byebug after project is complete
require "pry-byebug"
require_relative "lib/player"

WINNING_COMBINATIONS = [[[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]],
                        [[0, 0], [1, 0], [2, 0]], [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]],
                        [[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]]

# Valid space method
def empty_space?(arr, row, column)
  arr[row][column] == " "
end

# TODO: Add #winner? method
def winner?(grid)
  WINNING_COMBINATIONS.each do |set_of_coordinates|
    marks = set_of_coordinates.map do |coordinates|
      grid[coordinates[0]][coordinates[1]]
    end
    return true if marks.all?("x") || marks.all?("o")
  end
  false
end

def get_winner(grid)
  WINNING_COMBINATIONS.each do |set_of_coordinates|
    marks = set_of_coordinates.map do |coordinates|
      grid[coordinates[0]][coordinates[1]]
    end
    return marks[0][0] if marks.all?("x") || marks.all?("o")
  end
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

until winner?(grid)
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

  if grid.flatten.include?(" ")
    cpu_row = rand(0..2)
    cpu_column = rand(0..2)
    until empty_space?(grid, cpu_row, cpu_column)
      cpu_row = rand(0..2)
      cpu_column = rand(0..2)
    end
    grid[cpu_row][cpu_column] = cpu.mark
  end

  if !grid.flatten.include?(" ") || winner?(grid) # rubocop:disable Style/Next
    grid.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        print column
        print "|" unless column_index == row.length - 1
      end

      puts "\n-----" unless row_index == grid.length - 1
    end

    puts ""

    if winner?(grid)
      puts get_winner(grid) == player.mark ? "#{player.name} wins!" : "You lose to #{cpu.name}..."
    else
      puts "Game Over"
      puts "No one wins..."
    end
    break
  end
end
