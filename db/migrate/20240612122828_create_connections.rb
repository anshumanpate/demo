class CreateConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :connections do |t|
      t.integer :requester_id
      t.integer :requestee_id
      t.string :status

      t.timestamps
    end
  end
end
