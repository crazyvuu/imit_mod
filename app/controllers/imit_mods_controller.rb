class ImitModsController < ApplicationController
  require "#{Rails.root}/app/modules/simplex"
  require 'json'

  # GET //imit_mod/simplex/count
  def data_table
  end

  # [[2.0, 1.0, 17.0],[5.0, 4.0, 49.0]]
  # [17.0, 49.0]
  # [-23.0, -18.0, 0.0]

  # POST /imit_mod/simplex/count
  def simplex_count
    conditions = JSON.parse params[:conditions]
    goal = JSON.parse params[:goal]
    free_elems = conditions.map { |row| row[row.length - 1] }
    simplex = Simplex.new(conditions, goal, free_elems)
    @steps = 0
    while (simplex.goal.any? { |n| n < 0 })
      simplex.set_key_elem
      simplex.jordan_conversion
      simplex.free_elems = simplex.table.map { |row| row[row.length - 1] }
      @steps += 1
    end
    if (simplex.goal[simplex.goal.length - 1] % 1 != 0)
    end
    @table = (simplex.table + [simplex.goal])
    @x = ImitMod::x_form(@table, simplex.x_pos)
# y3 = [1.0, 0.0, x11.to_f]
# free_elems = [y1[y1.length - 1], y2[y2.length - 1], y3[y3.length - 1]]
# goal = [-23.0, -18.0, 0.0]
# simplex = Simplex.new([y1, y2, y3], goal, free_elems)
# steps = 0
# while (simplex.goal.any? { |n| n < 0 })
#   simplex.set_key_elem
#   simplex.jordan_conversion
#   simplex.free_elems = simplex.table.map { |row| row[row.length - 1] }
#   steps += 1
# end
# puts "steps count - " + steps.to_s
# simplex.table.each do |row|
#   puts row.inspect
# end
# puts simplex.goal.inspect
#
# y3 = [-1.0, 0.0, -(x12.to_f)]
# free_elems = [y1[y1.length - 1], y2[y2.length - 1], y3[y3.length - 1]]
# goal = [-23.0, -18.0, 0.0]
# simplex = Simplex.new([y1, y2, y3], goal, free_elems)
# steps = 0
# while (simplex.goal.any? { |n| n < 0 })
#   simplex.set_key_elem
#   simplex.jordan_conversion
#   simplex.free_elems = simplex.table.map { |row| row[row.length - 1] }
#   steps += 1
# end
# puts "steps count - " + steps.to_s
# simplex.table.each do |row|
#   puts row.inspect
# end
# puts simplex.goal.inspect
  end
end
