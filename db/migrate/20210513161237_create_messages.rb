class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :channel_id
      t.integer :user_id

      t.index :channel_id
      t.index :user_id
      t.timestamps
    end
  end
end
