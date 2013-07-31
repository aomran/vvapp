class CreateAnnualSubmissions < ActiveRecord::Migration
  def change
    create_table :annual_submissions do |t|
      t.string :cv
      t.string :artist_statement
      t.string :expo_project
      t.string :special_needs
      t.string :image_list
      t.references :artist, index: true
      t.integer :year
      t.timestamps
    end
  end
end
