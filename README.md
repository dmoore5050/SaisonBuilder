SaisonBuilder:<br /> a [Nashville Software School](http://www.nashvillesoftwareschool.com) capstone project
================================================


Purpose
-------
SaisonBuilder is my Unit 2 (Ruby) Capstone project for Nashville Software School Software Development Fundamentals course.

The constraints of the project are that they must use standard library Ruby with the exception of using ActiveRecord as an ORM. The concept with this capstone is to demonstrate mastery of Ruby itself.

The goal of this project is to create an app to help novice and veteran homebrewers alike navigate the nearly-limitless options available when designing and brewing an all-grain Saison, or Belgian Farmhouse ale.

Project Status
--------------

[![Build Status](https://travis-ci.org/dmoore5050/SaisonBuilder.png)](https://travis-ci.org/dmoore5050/SaisonBuilder)

Basic database add-remove-list functionality in place.
Migrations/models in place.
Seed files in place.
The following commands are fully functional:

* sb
* sb style
* sb techniques
* sb ingredients
* sb list
* sb view <recipe name>
* sb delete <recipe name>
* sb build

###To do:

+ Refactor
+ Bugfix

Features
--------
The primary feature of this app is the ability to view one of six preloaded saison recipes, or to modify any of the six recipes to the user's custom specifications, and to save the modified recipe to the user's library. Modification are guided by a series of questions, allowing the user to make specific modifications to single elements of the recipe (ie, increase only a specific type of aroma hops, or remove a specific grain).

Additionally, a small library of ingredients and style/technique definitions is included.

In the future, saison builder will include the ability to generate recipes from the ground up, ingredient by ingredient, that can then be saved in a library for later use.

Usage Instructions
------------------
Planned usage is as follows:

To begin using the app, cd to the SaisonBuilder directory and type:

    ruby saisonbuilder

Optionally, add the following to your .zshrc or .bash_profile files in your root directory to open with a single 'sb' or 'saisonbuilder' command:

    alias sb='ruby ~/your/file/path/saisonbuilder'
    alias saisonbuilder='ruby ~/your/file/path/saisonbuilder'

In either case, executing the command will bring up a menu displaying the following options:

    Return to this menu:             ruby saisonbuilder
    Learn about the saison style:    ruby saisonbuilder style
    Learn about brewing techniques:  ruby saisonbuilder techniques
    List available ingredients:      ruby saisonbuilder ingredients
    View recipe library:             ruby saisonbuilder list
    Build a recipe:                  ruby saisonbuilder build
    View an existing recipe:         ruby saisonbuilder view <recipe_name>
    Delete an existing recipe:       ruby saisonbuilder delete <recipe_name>

Most of these options are self-exlanatory. The one exception is the command that forms the core of SaisonBuilder's functionality:

    Build a recipe:                  ruby saisonbuilder build

When executed, sb build guides the user through a series of questions that allow the user to change practically any aspect(s) of any of the five base recipes. After the user is finished modifying the recipe, the saved recipe can then be found in the library, and can be viewed, further modified, or deleted by the user. This process can then be repeated as often as the user wishes, for any recipe - base or modified - that is in the library.

Demo
----
Please download the app and try it out - it's free!

Known Bugs
----------
There will be bugs.

Changelog
---------

+ 2013-5-10 - Created initial repository with README
+ 2013-5-13 - Refined/fleshed out README and user_stories
+ 2013-5-14 - Added initial gemfile, rakefile, bootstrap_ar, model, tests.
+ 2013-5-15 - Added initial migration, db structure.
+ 2013-5-18 - Added default recipe and ingredient list markdowns.
+ 2013-5-19 - Implemented main menu, style, and techniques commands, seeding ingredients.
+ 2013-5-20 - Implemented initial controllers, question_set module.
+ 2013-5-21 - Implemented initial REPL.
+ 2013-5-22 - Restructured and simplified database schema. Began work on seeding initial recipes.
+ 2013-5-23 - Completed initial recipe seeding. Implemented view recipe command.
+ 2013-5-24 - Fixed display bugs, streamlined recipe seeding and view method. Modify now clones base recipe.
+ 2013-5-25 - Added majority of modify recipe ingredient methods.
+ 2013-5-26 - Added last mod recipe ingr methods, and refactored those methods.
+ 2013-5-27 - Shifted recipe_ingredient mod methods into recipe.

Acknowledgements
----------------
I would like to thank the following NSS staff/mentors who have lent advice and perspective on this project:

+ Eliza Brock
+ Hassan Shamim
+ Ben Bridges
+ Adam Scott
+ Jeff Felchner
+ James Fryman

Author
------
Dustin Moore

License
-------
Copyright (c) 2013 Dustin Moore

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
