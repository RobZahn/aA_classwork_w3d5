require "byebug"
class PolyTreeNode

    attr_reader :children

    def initialize(val)
        @value = val
        @parent = nil
        @children = []
    end

    def parent
        @parent
    end

    def parent_nil?
        @parent.nil?
    end

    def children
        @children
    end

    def value
        @value
    end

    # (1) sets the parent property and 
    # (2) adds the node to their 
    # parent's array of children (unless we're setting parent to nil).
    def parent=(par)
        if self.parent
            self.parent.children.delete(self) #delete ourselves 
        end
        
        @parent = par
        self.parent.children << self unless self.parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Not a child" if child_node.parent.nil?
        child_node.parent = nil 
    end

    def inspect
        @value.inspect
    end

    def dfs(target) #depth first search, 
        return nil if self.nil?
        return self if self.value == target
        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target)
        arr = [self]

        while arr.length > 0
            current_node = arr.shift
            if current_node.value == target
                return current_node
            end
            arr += current_node.children
        end
        nil
    end

end

#   1
#  / \
# 2   3

class KnightPathFinder

    attr_accessor :considered_positions, :root_node

    #2d array indices 0-7
    #possible moves [+2,+1] [+1,+2]
    #kpf = KnightPathFinder.new([0, 0])

    #  0 1 2 3 4 5 6 7 
    # 0
    # 1  p   p
    # 2p       p
    # 3    K
    # 4p       p
    # 5  p   p 
    # 6
    # 7

    #if knight was in [3,2] 
    #possible moves are:
    # [1,1]     -2,-1
    # [1,3]     -2,+1
    # [2,0]     -1,-2
    # [2,4]     -1,+2
    # [4,0]     +1,-2
    # [4,4]     +1,+2
    # [5,1]     +2,-1
    # [5,3]     +2,+1

    POSSIBLE_MOVES = [
        [-2,-1],
        [-2,1],
        [-1,-2],
        [-1,2],
        [1,-2],
        [1,2],
        [2,-1],
        [2,1]
    ]


    def self.valid_moves(pos) #current pos
        row, col = pos[0],pos[1]
        valid_moves = []
        POSSIBLE_MOVES.each do |move|
            sum = [pos,move].transpose.map{|ele|ele.sum}
            valid_moves << sum if (sum[0] >= 0 && sum[0] <= 7) && (sum[1] >= 0 && sum[1] <= 7)
        end
        valid_moves
    end


    def initialize(start_pos)
        @start = start_pos
        
        @considered_positions = [@start]
        self.build_move_tree
    end

    def build_move_tree
    
        self.root_node = PolyTreeNode.new(@start)
        queue = [root_node]
        
        until queue.empty? #self.new_move_positions(@start).length #@considered_positions.length !=64
            current_node = queue.shift

            self.new_move_positions(current_node.value).each do |next_position|
                new_node = PolyTreeNode.new(next_position)
                current_node.add_child(new_node)
                queue << new_node
                # debugger
                # p "inner"
            end
        end

        #We get the objects with the value of our starting position
        #We make more objects given the new_move_positions 
        #and add it to our queue 
        
    end

    def new_move_positions(pos)
        # check_moves = KnightPathFinder.valid_moves(pos)
        # #filter out considered positions
        # check_moves.each do |ele|
        #     @considered_positions << ele unless @considered_positions.include?(ele)
        # end
        KnightPathFinder.valid_moves(pos)
            .reject { |new_pos| considered_positions.include?(new_pos) }
            .each { |new_pos| considered_positions << new_pos }
    end

   def find_path(end_pos)
        end_node = root_node.bfs(end_pos)
        trace_path_back(end_node) #array
   end


   def trace_path_back(node) #goes up until it gets to the root
    arr = [node]
    parent_obj = node.parent
    #loop 
    while parent_obj != root_node
        arr.unshift(parent_obj)
        parent_obj = parent_obj.parent
    end
    arr.unshift(root_node)
   end
end



kpf = KnightPathFinder.new([0,0])
p kpf.root_node
p kpf.find_path([7, 6])
#p KnightPathFinder.valid_moves([0,0])

# p kpf.considered_positions
# p kpf.new_move_positions([0,0])
# p kpf.new_move_positions([1,2])



# disp queue 
# disp current_node
# disp new_node

