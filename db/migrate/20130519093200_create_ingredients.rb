class CreateIngredients < ActiveRecord::Migration

  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :description
      t.integer :type_code
      t.integer :yeast_code_wyeast
      t.integer :yeast_code_wl
    end
  end

end