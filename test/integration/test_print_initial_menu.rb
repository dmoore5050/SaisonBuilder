require_relative '../test_helper'

class TestPrintMenu < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_prints_main_menu
    actual = `ruby sb`

    logo = <<EOS
    ____     _                ___       _ __   __
   / _____ _(_______  ___    / _ )__ __(_/ ___/ ___ ____
  _\\ \\/ _ `/ (_-/ _ \\/ _ \\  / _  / // / / / _  / -_/ __/
 /___/\\_,_/_/___\\___/_//_/ /____/\\_,_/_/_/\\_,_/\\__/_/

EOS

    menu = <<EOS
                    by Dustin Moore

Return to this menu:             ruby sb
Learn about the saison style:    ruby sb style
Learn about brewing techniques:  ruby sb techniques
Learn about ingredients:         ruby sb ingredients
View recipe library:             ruby sb list
Add an ingredient or recipe:     ruby sb add
Change a description:            ruby sb describe
Modify a recipe:                 ruby sb build
View an existing recipe:         ruby sb view <recipe_name>
Delete an existing recipe:       ruby sb delete recipe <recipe_name>
Delete an existing ingredient:   ruby sb delete ingredient <ingredient_name>
EOS

    expected = logo + menu

    assert_equal expected, actual
  end

end