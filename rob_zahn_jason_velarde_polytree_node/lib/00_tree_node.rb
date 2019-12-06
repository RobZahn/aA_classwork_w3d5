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
        return self if self.value == target
        arr = [self]

        while arr.length > 0
            current_node = arr.pop
            if current_node.value == target
                return current_node
            end
            
            current_node.children.each do |child|
                arr.push(child)
            end
            p arr
        end
        nil
    end

end


    # Haseeb's psuedo
    # def dfs(root, target)
    #     return nil if root is nil
    #     return root if root.value == target
    #     root.children.each do |child|
    #         search_result = dfs(child, target)
    #         return search_result unless search_result.nil?
    #     end
    #     nil
    # end


    #     1
    #    / \
    #   2   4
    #  /   / \
    # 3   5   6

    #node 1 has [node 2,node 4] in children, has value of 1
    #node 2 has [node 3] in children, has value of 2, parent 1
    #node 3 has? nil children has val 3, parent 2
    #node 4 has [node 5, node 6] children and has val 4 parent 1
    #node 5 has? nil children has val 5, parent 4
    #node 6 has? nil children has val 6, parent 4