class Array

  def sum
    self.inject{|sum, n| sum + n}
  end

  def shave!(&block)
    indeces_to_delete = []
    self.each_with_index do |element, index|
      if(block.call(element))
        indeces_to_delete << index
      end
    end
    # Need to be careful about index reordering.
    indeces_to_delete.reverse.each do |index|
      self.delete_at(index)
    end
    return indeces_to_delete.length
  end
end
