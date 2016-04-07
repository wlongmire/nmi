class AddFaviconToLinks < ActiveRecord::Migration
  def change
    add_column :links, :favicon, :string
  end
end
