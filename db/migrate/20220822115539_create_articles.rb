class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :user_id,  null: false
      t.string :title,     null: false
      t.string :content,   null: false
      t.string :tag,       null: false

      t.timestamps
    end
  end
end