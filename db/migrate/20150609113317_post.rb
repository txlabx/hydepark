class Post < ActiveRecord::Migration
  def change
  
  	    change_table :posts do |t|
			  t.integer :mute ,null: false
			  t.timestamps
		end
  end
end
