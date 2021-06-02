class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :description
      t.references :tenant, index: true
      t.timestamps
    end
  end
end
