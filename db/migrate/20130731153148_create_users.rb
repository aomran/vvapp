class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :phone_number
      t.string :street_address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
