class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.string :seat_id
      t.integer :row
      t.integer :column
      t.boolean :available, default: true
      t.belongs_to :venue

      t.timestamps
    end
  end
end
