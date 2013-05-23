
module Menu

  def self.render_menu
    logo = <<EOS
    ____     _                ___       _ __   __
   / _____ _(_______  ___    / _ )__ __(_/ ___/ ___ ____
  _\\ \\/ _ `/ (_-/ _ \\/ _ \\  / _  / // / / / _  / -_/ __/
 /___/\\_,_/_/___\\___/_//_/ /____/\\_,_/_/_/\\_,_/\\__/_/

EOS

    menu = <<EOS
                    by Dustin Moore

Return to this menu:             sb
Learn about the saison style:    sb style
Learn about brewing techniques:  sb techniques
Learn about ingredients:         sb ingredients
View recipe library:             sb list
Build a new recipe:              sb build <recipe_name>
Modify an existing recipe:       sb modify <recipe_name>
Delete an existing recipe:       sb delete <recipe_name>
View an existing recipe:         sb view <recipe_name>
EOS

    puts logo + menu
  end

end