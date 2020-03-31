class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :description
      t.integer :country_id
    end
  end
end
