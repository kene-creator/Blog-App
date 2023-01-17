class RemovePostRefrencesToComment < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :post_references_id, :string
  end
end
