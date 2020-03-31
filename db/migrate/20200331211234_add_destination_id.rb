class AddDestinationId < ActiveRecord::Migration
  def change
    add_column :destinations, :destination_id, :integer
  end
end
