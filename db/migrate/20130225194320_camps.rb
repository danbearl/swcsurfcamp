class Camps < ActiveRecord::Migration

  def change
    create_table :camps do |t|
      t.string :type
      t.date :start_date
      t.date :end_date
      t.float :price

      t.timestamps
    end
  end
end
