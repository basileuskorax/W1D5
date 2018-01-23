class PolyTreeNode
  
  attr_reader :children, :value, :parent
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)
  end  


  def add_child(node)
    @children << node 
    node.parent = self
  end
  
  def remove_child(node)
    raise 'error' unless self.children.include?(node)
    node.parent = nil
    self.children.delete(node)
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      found = child.dfs(target_value)
      return found unless found.nil?
    end
    nil  
  end
  
  def bfs(target_value)
    q = [self]
    until q.empty?
      cur = q.shift
      return cur if cur.value == target_value
      q += cur.children
    end
    nil
  end
  
  def inspect
    @value.inspect
  end    
    
  
end

#Node1.parent = Node2