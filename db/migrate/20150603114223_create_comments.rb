class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
	t.integer	:parent_id, null: false
	t.integer  :post_id, null: false
	t.text  :caption 
	t.text  :file_path 
      t.timestamps
    end
  end
end
