
module Menu

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
Return to this menu:             sb
Learn about the saison style:    sb style
Learn about brewing techniques:  sb techniques
Learn about ingredients:         sb ingredients
View recipe library:             sb list
Modify a recipe:                 sb build <recipe_name>
View an existing recipe:         sb view <recipe_name>
Delete an existing recipe:       sb delete recipe <recipe_name>
EOS
  end

  def self.render_menu
    puts logo + menu
  end

end