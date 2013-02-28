class AddLocationToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :location, :string
  end
end
