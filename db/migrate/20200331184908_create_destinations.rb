class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :description
      t.string :country
      t.integer :user_id
    end 
  end 
end 
