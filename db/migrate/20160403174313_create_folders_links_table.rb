class CreateFoldersLinksTable < ActiveRecord::Migration
  def change
    create_table :folders_links, :id => false do |t|
      t.integer :folder_id
      t.integer :link_id
    end

    add_index :folders_links, [:folder_id, :link_id]
  end
end
