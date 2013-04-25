class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.integer :position
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :wishes, :user_id
  end
end
