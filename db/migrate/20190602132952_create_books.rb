class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover
      t.text :description
      t.string :author
      t.string :file

      t.timestamps
    end
  end
end
