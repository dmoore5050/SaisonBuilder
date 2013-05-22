class CreateHopProfiles < ActiveRecord::Migration

  def change
    create_table :hop_profiles do |t|
      t.integer :recipe_id
      t.integer :quantity
      t.string :usage
      t.string :duration
    end
  end

end