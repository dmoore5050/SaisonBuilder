class CreateYeastProfiles < ActiveRecord::Migration

  def change
    create_table :yeast_profiles do |t|
      t.integer :recipe_id
      t.string :usage
    end
  end

end