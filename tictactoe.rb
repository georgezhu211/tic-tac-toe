class TicTacToe
  def initialize
    puts "A new game of tic-tac-toe has been created!"
    @board = Board.new
    @playerX = Player.new('X')
    @playerO = Player.new('O')
    @current_player = @playerX
  end

  def start_game
    @board.display
    loop do
      index = @current_player.pick_slot
      mark = @current_player.mark
      @board.update(index, mark)
      @board.display
      break if game_over?
      switch_players
      
    end
  end

  def switch_players
    if @current_player == @playerX
      @current_player = @playerO
    else
      @current_player = @playerX
    end
  end

  def game_over?
    if @board.won?(@current_player.mark)
      puts "The winner is player #{@current_player.mark}"
      true
    else
      false
    end
    
  end
end

class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def pick_slot 
    puts "choose an empty spot from 1-9: "
    index = gets.chomp.to_i - 1
    if index.between?(0,8)
      index
    else
      pick_slot
    end
  end
end

class Board
  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @WIN_COMBINATIONS = [ 
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [6,4,2] 
      ]
  end

  def display
   puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def update(index, mark)
    if @board[index].strip.empty?
      @board[index] = mark 
    else
      puts "that slot is already taken"
    end
  end

  def won?(current_mark)
    @WIN_COMBINATIONS.each do |combination|
      temp = combination.map do |index|
        @board[index]
      end
      return true if temp.all? { |mark| mark == current_mark}
    end
    return false
  end
end

game = TicTacToe.new
game.start_game