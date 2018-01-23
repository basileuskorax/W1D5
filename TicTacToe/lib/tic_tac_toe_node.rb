require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    ##base case
    return self.board.over? && self.board.winner != evaluator
    
    ##inductive step
    x = (evaluator == next_move_mark) && (self.children.all? {|node| losing_node?(node)})
    y = (evaluator != next_move_mark) && (self.children.any? {|node| losing_node?(node)})
    
    x || y
  end

  def winning_node?(evaluator)
    
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_boards_hash = self.return_new_boards
    array_of_children = []
    
    new_boards_hash.each do |board, previous_pos|
      child = TicTacToeNode.new(board, self.return_opp_mover_mark, previous_pos)
      array_of_children << child
    end
    
    array_of_children
      
  end
  
  def return_new_boards
    empty_squares = self.return_all_empty_pos(self.board)
    new_boards = Hash.new
    
    empty_squares.each do |pos|
      new_board = self.board.dup
      new_board[pos] = next_mover_mark 
      new_boards[new_board] = pos
    end
    
    new_boards        
  end  
  
  def return_all_empty_pos(board)
    all_pos = []
    (0..2).each do |row|
      (0..2).each do |col|
        all_pos << [row, col]
      end
    end
    all_pos.select{|pos| board.empty?(pos)}
  end
  
  def return_opp_mover_mark
    next_mover_mark == :x ? :o : :x
  end  
end


