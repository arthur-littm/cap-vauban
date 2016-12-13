class AddBedroomToFlats < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :bedrooms, :integer
    add_column :flats, :beds, :integer
  end
end
