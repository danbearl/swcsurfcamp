class RenameTypeInCamps < ActiveRecord::Migration
  def change
    change_table :camps do |t|
      t.rename :type, :camp_type
    end
  end
end
