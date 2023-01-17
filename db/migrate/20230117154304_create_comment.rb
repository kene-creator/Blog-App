class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author_id, null: false, foreign_key: { to_table: :users }
      t.text :text
      t.references :post_references null: false, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
