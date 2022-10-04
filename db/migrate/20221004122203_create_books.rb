class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.text :url, null: false

      t.timestamps
    end
  end
end
