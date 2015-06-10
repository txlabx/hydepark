class CreateUsers < ActiveRecord::Migration
 

  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.text :profile_link
      t.text :cover_link
      t.string :profile_type
      t.string :cover_type
      t.integer :is_celeb
      t.text :password
      t.string :account_type
      t.text :session_token
      t.integer :last_login, :limit => 5
      t.date :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
