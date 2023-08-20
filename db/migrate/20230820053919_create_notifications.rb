class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :action_type, null: false
      t.boolean :checked
      t.references :user, foreign_key: true
      t.references :subject, polymorphic: true

      t.timestamps
    end
  end
end
