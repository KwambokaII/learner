class CreateCommunications < ActiveRecord::Migration[7.1]
  def change
    create_table :communications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :message

      t.timestamps
    end
  end
end
