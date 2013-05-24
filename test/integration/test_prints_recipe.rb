require_relative '../test_helper'

class TestPrintRecipe < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_prints_recipe
    actual = `ruby saisonbuilder view classic`

    expected = <<EOS

Name:          Classic
Batch size:    5 gallons
Mash:          90 mins @ 149F
Boil length:   90 mins

9.0 lbs Pilsner
1.0 lbs Munich
1.0 lbs Corn Sugar          Add during: Peak krausen
1.5 oz Styrian Goldings     Add during: Boil, @ 60 min
0.5 oz Saaz                 Add during: Boil, @ 15 min
1.0 pkg Dupont Strain       Add during: Primary. Mfg. code(s): White Labs WLP565, Wyeast 3724

Primary Fermentation Temp:  85F
EOS

    assert_equal(expected, actual)
  end

end