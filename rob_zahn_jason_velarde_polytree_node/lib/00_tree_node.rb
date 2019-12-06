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

class KnightPathFinder

end