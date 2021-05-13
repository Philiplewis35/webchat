class CreateUserChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :user_channels do |t|
      t.integer :user_id
      t.integer :channel_id
      t.index :user_id
      t.index :channel_id
      t.timestamps
    end
  end
end
