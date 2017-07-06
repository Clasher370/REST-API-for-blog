class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :author_id, index: true, foreing_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
