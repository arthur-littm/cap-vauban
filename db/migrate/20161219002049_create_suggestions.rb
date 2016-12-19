class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.string :title
      t.string :content
      t.string :content_english
      t.string :content_italian
      t.string :link
      t.string :address

      t.timestamps
    end
  end
end
