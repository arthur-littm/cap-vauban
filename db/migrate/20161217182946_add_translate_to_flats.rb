class AddTranslateToFlats < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :description_english, :string
    add_column :flats, :description_italian, :string
  end
end
