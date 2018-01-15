class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.references :city, foreign_key: true
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
