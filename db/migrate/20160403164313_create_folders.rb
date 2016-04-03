class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title
      t.text :desc

      t.timestamps null: false
    end
  end
end
