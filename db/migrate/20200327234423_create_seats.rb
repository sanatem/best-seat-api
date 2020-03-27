class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.string :seat_id
      t.string :row
      t.string :string
      t.integer :column
      t.boolean :status
      t.belongs_to :venue

      t.timestamps
    end
  end
end
