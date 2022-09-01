class CreateArticleTags < ActiveRecord::Migration[6.1]
  def change
    create_table :article_tags do |t|
      t.references :article,  foreign_key: true
      t.references :tag,      foreign_key: true

      t.timestamps
    end

     add_index :article_tags, [:article_id, :tag_id], unique: true

  end
end
