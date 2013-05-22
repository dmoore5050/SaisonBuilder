class AddFksToIngredients < ActiveRecord::Migration

  def up
    add_column :ingredients, :grain_profile_id, :integer
    add_column :ingredients, :hop_profile_id, :integer
    add_column :ingredients, :yeast_profile_id, :integer
    add_column :ingredients, :other_ingredient_profile_id, :integer
  end

end