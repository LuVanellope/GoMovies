class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :document, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :name, null: false, default: ''
      t.string :cell_phone, null: false, default: ''
      t.date :reservation_date, null: false
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
