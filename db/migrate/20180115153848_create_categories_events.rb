class CreateCategoriesEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_events do |t|
      t.references :category, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
    add_index :categories_events, [:category_id, :event_id], unique: true
  end
end
