require_relative "skeleton/lib/00_tree_node.rb"
require 'byebug'

class KnightPathFinder
  attr_reader :start_pos, :board
  
  def initialize(pos)
    @start_pos = pos
    @board = Board.new
    @visited_positions = Hash.new(){false}
    @visited_positions[@start_pos] = true
  end
  
  def find_path(destination)
    result = []
    final = self.find_destination_node(destination)
    result << final
    current = final
    until current.parent.nil?
      current = current.parent
      result.unshift(current.value)
    end
    result
  end
  
  def find_destination_node(destination)
    root = self.build_move_tree(destination)
    destination_node = root.bfs(destination)
  end  
  
  def new_move_positions(pos)
    x, y = pos.first, pos.last
    abstract_possible = [[x+1, y+2], [x-1, y+2], [x+2, y+1], [x-2, y+1], [x+1, y-2], [x-1, y-2], [x+2, y-1], [x-2, y-1]]
    real_possible = abstract_possible.select{|pos| board.is_on_board?(pos) && @visited_positions[pos] == false}
    real_possible.each{|pos| @visited_positions[pos] = true}
    real_possible
  end
  
  def build_move_tree(destination)
    root = PolyTreeNode.new(@start_pos)
    queue = [root]
    until @visited_positions[destination]
      nxt_pos = self.new_move_positions(queue.first.value)
      nxt_pos.each do |pos|
        node = PolyTreeNode.new(pos)
        queue << node
        queue.first.add_child(node)
      end
      queue.shift  
    end
    root
  end  
  
end

class Board
  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end
  
  def [](pos)
    x, y = pos.first, pos.last
    @grid[x][y]
  end
  
  def []=(pos, val)
    x, y = pos.first, pos.last
    @grid[x][y] = val
  end  
  
  def is_on_board?(pos)
    x, y = pos.first, pos.last
    x.between?(0,7) && y.between?(0,7)
  end
end

kpf = KnightPathFinder.new([0,0])
p kpf.find_path([7,6])