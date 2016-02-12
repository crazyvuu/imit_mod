class ImitMod < ActiveRecord::Base

  def self.x_form(table, x_pos)
    x = []
    result_column = table[0].length - 1
    (0...x_pos.length).each do |i|
      if (x_pos[i] != table[0].length)
        x[i] = table[i][result_column]
      else
        x[i] = 0
      end
    end
    x
  end

  def self.result_matrix_form(table, goal)
    table + goal
  end
end