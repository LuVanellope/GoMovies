class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :url_image, null: false, default: ''
      t.datetime :begin_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
