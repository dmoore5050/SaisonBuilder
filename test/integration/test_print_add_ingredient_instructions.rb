require_relative '../test_helper'

class TestPrintAddIngredientInstructions < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_print_add_ingredient_instructions
    actual = `ruby sb add ingredient`

    expected = <<EOS

To add an ingredient, use the following format:

ruby sb add ingredient <ingredient_name>: <ingredient_type> <white_lab_mfg_code> <wyeast_mfg_code>

The following are valid <ingredient_types>:
grain, hops, yeast, fruit, spices, botanicals, adjuncts.

White Lab and Wyeast mfg codes are used only when adding Yeast.
White Lab uses a 3 digit number, Wyeast a 4 digit number.

Examples of valid commands:

ruby sb add ingredient red wheat malt: grain
ruby sb add ingredient american ale: yeast 060 1056

EOS

    assert_equal actual, expected
  end


end