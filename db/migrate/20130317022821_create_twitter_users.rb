class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.integer :source_id
      t.string :screen_name
      t.string :full_name

      t.timestamps
    end
  end
end
