class ChangeDestinationsTable < ActiveRecord::Migration
  def change
    remove_column :destinations, :country
    rename_column :destinations, :user_id, :country_id
  end
end
