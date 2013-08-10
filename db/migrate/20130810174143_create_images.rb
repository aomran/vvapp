class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_file
      t.references :submission, index: true

      t.timestamps
    end
  end
end
