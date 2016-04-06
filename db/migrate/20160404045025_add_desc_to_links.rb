class AddDescToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :desc, :text
  end
end
