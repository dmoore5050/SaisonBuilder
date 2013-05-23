class CreateRecipes < ActiveRecord::Migration

  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :boil_length
      t.string :primary_fermentation_temp
    end
  end

end