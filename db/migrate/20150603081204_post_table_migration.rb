class PostTableMigration < ActiveRecord::Migration
 def change
    create_table :posts do |t|
    	  
		  t.integer :user_id , null: false 
		  t.text :caption ,null: false
		  t.text :video_link , null: false
		  t.text :video_thumbnail_link , null: false
		  t.text :image_link, null: false
		  t.text :video_angle , null: false
		  t.string :privacy , null: false
		  t.integer :topic_id , null: false
		  t.integer :reply_count , null:false
		  t.string :beam_type , null:false
    end
  end
end
