class CreateGrainProfiles < ActiveRecord::Migration

  def change
    create_table :grain_profiles do |t|
      t.integer :recipe_id
      t.integer :quantity
    end
  end

end