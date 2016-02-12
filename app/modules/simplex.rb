class Simplex
  attr_accessor :table, :old_table, :goal, :free_elems
  attr_reader :x_pos

  def initialize(conditions, goal, free_elems)
    @table = conditions
    @goal = goal
    @free_elems = free_elems
    @x_pos = Array.new(@table[0].length - 1) { @table[0].length }
  end

  def iteration
    while (@goal.any? { |n| n < 0 })
      set_key_elem
      jordan_conversion
      @free_elems = @table.map { |row| row[row.length - 1] }
    end
    if (@goal[@goal.length - 1] % 1 != 0)
      @x = ImitMod::x_form(@table, @x_pos)
      set_new_conditions(@x)
      iteration
    end
  end

  def set_key_elem
    negative_elem = @goal.find { |elem| elem < 0 }
    key_column_index = @goal.find_index(negative_elem)
    key_column = @table.map { |row| row[key_column_index] }
    i = 0
    ratio_array = []
    @free_elems.each do |elem|
      ratio_array[i] = elem / key_column[i] if (key_column[i] > 0)
      i+=1
    end
    key_row_index = ratio_array.reject { |val| val.nil? }.find_index(ratio_array.min)
    @key_elem = @table[key_row_index][key_column_index]
    @key_elem_coords = [key_row_index, key_column_index]
    set_x_pos
  end

  def jordan_conversion
    i = 0
    new_table = Array.new(@table.size) { Array.new(2) { 0 } }
    @table.each do |row|
      j = 0
      if (i == @key_elem_coords[0])
        row.each do |elem|
          if (j == @key_elem_coords[1])
            new_table[i][j] = 1/@key_elem
          else
            new_table[i][j] = elem/@key_elem
          end
          j+=1
        end
      else
        row.each do |elem|
          if (j == @key_elem_coords[1])
            new_table[i][j] = -elem/@key_elem
          else
            new_table[i][j] = (elem*@key_elem - @table[@key_elem_coords[0]][j]*@table[i][@key_elem_coords[1]])/@key_elem
          end
          j+=1
        end
      end
      i+=1
    end
    self.goal_conversion
    @table = new_table
  end

  def goal_conversion
    i = 0
    @goal.each do |elem|
      if (i != @key_elem_coords[1])
        @goal[i] = (elem*@key_elem - @table[@key_elem_coords[0]][i]*@goal[@key_elem_coords[1]])/@key_elem
      end
      i+=1
    end
    @goal[@key_elem_coords[1]] = -@goal[@key_elem_coords[1]]/@key_elem
  end

  def set_x_pos
    if (@x_pos.include?(@key_elem_coords[0]))
      @x_pos[@x_pos.bsearch { |x| x == @key_elem_coords[0] }] = @table[0].length
      @x_pos[@key_elem_coords[1]] = @key_elem_coords[0]
    else
      @x_pos[@key_elem_coords[1]] = @key_elem_coords[0]
    end
  end

  def set_new_conditions(x_array)
    x_current = x_array.detect { |x| x % 1 > 0 }
    @x_current_cond = [x_current.to_i, x_current.to_i + 1]
  end
end