class CreateRecipeIngredients < ActiveRecord::Migration

  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.float :quantity
      t.string :usage
      t.string :duration
    end
  end

end