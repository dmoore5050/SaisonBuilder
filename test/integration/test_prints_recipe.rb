require_relative '../test_helper'

class TestPrintRecipe < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_prints_recipe
    actual = `ruby saisonbuilder view classic`

    expected = %Q(
Name:          Classic
Batch size:    5 gallons
Mash:          90 mins @ 149F
Boil length:   90 mins

#{'9.0 lbs Pilsner'.ljust(28)}
#{'1.0 lbs Munich'.ljust(28)}
1.0 lbs Corn Sugar          Add during: Peak krausen
1.5 oz Styrian Goldings     Add during: Boil, @ 60 min
0.5 oz Saaz                 Add during: Boil, @ 15 min
1.0 pkg Dupont Strain       Add during: Primary. Mfg. code(s): White Labs WLP565, Wyeast 3724

Primary Fermentation Temp:  85F
)

    assert_equal(expected, actual)
  end

#   def test_prints_recipe_multiword_name
#     actual = `ruby saisonbuilder view new world`

#     expected = %Q(
# Name:          New World
# Batch size:    5 gallons
# Mash:          90 mins @ 149F
# Boil length:   60 mins

# #{'7.0 lbs Pale Malt'.ljust(28)}
# #{'2.0 lbs White Wheat Malt'.ljust(28)}
# #{'1.0 lbs Munich'.ljust(28)}
# 1.0 lbs Turbinado Sugar     Add during: Peak krausen
# 1.5 oz Hallertau            Add during: Boil, @ 60 min
# 1.0 oz Amarillo             Add during: Boil, @ 10 min
# 1.0 oz Motueka              Add during: Boil, @ 1 min
# 1.0 oz Amarillo             Add during: Dryhop, @ 5 days
# 1.0 oz Simcoe               Add during: Dryhop, @ 5 days
# 1.0 pkg French Saison       Add during: Primary. Mfg. code(s): White Labs WLP656, Wyeast 3711

# Primary Fermentation Temp:  65-72F
# )

#     assert_equal(expected, actual)
#   end

end