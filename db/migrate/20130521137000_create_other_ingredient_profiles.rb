class CreateOtherIngredientProfiles < ActiveRecord::Migration

  def change
    create_table :other_ingredient_profiles do |t|
      t.integer :recipe_id
      t.integer :quantity
      t.string :usage
    end
  end

end