class CreateRsvps < ActiveRecord::Migration[7.0]
  def change
    create_table :rsvps do |t|
      t.boolean :attending
      t.integer :event_id, required: true
      t.integer :user_id, required: true

      t.timestamps
    end
  end
end
