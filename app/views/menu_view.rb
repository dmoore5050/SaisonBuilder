
module MenuView

  def self.logo
    logo = <<EOS
    ____     _                ___       _ __   __
   / _____ _(_______  ___    / _ )__ __(_/ ___/ ___ ____
  _\\ \\/ _ `/ (_-/ _ \\/ _ \\  / _  / // / / / _  / -_/ __/
 /___/\\_,_/_/___\\___/_//_/ /____/\\_,_/_/_/\\_,_/\\__/_/

                    by Dustin Moore

EOS
  end

  def self.menu
    menu = <<EOS
Return to this menu:             ruby sb
Learn about the saison style:    ruby sb style
Learn about brewing techniques:  ruby sb techniques
Learn about ingredients:         ruby sb ingredients
View recipe library:             ruby sb list
Adding an ingredient:            ruby sb add ingredient
Change or add a description:     ruby sb describe
Build a new recipe:              ruby sb build
Modify a recipe:                 ruby sb modify
View an existing recipe:         ruby sb view <recipe_name>
Delete an existing recipe:       ruby sb delete recipe <recipe_name>
Delete an existing ingredient:   ruby sb delete ingredient <ingredient_name>
EOS
  end

  def self.render_menu
    puts logo + menu
  end

end