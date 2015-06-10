class PostAddFilterColumn < ActiveRecord::Migration
  def change
  		change_table :posts do |t|
			  t.string :filter ,null: false
			  t.integer :video_length , null: false
		end
  end
end
