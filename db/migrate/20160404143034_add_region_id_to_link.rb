class AddRegionIdToLink < ActiveRecord::Migration
  def change
    add_column :links, :region_id, :integer
  end
end
