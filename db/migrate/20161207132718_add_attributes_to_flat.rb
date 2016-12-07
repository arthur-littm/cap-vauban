class AddAttributesToFlat < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :capacity, :integer
    add_column :flats, :bathroom, :integer
    add_column :flats, :toilet, :integer
  end
end
