class AddCoordinatesToFlats < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :latitude, :float
    add_column :flats, :longitude, :float
    add_column :flats, :address, :string
  end
end
