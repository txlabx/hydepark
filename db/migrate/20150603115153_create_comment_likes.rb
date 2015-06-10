class CreateCommentLikes < ActiveRecord::Migration
  def change
    create_table :comment_likes do |t|
    	  t.integer :comment_id, null: false
		  t.integer :user_id, null: false
      t.timestamps
    end
  end
end
