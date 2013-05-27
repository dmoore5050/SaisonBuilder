SaisonBuilder:<br /> a [Nashville Software School](http://www.nashvillesoftwareschool.com) capstone project
================================================


Purpose
-------
SaisonBuilder is my Unit 2 (Ruby) Capstone project for Nashville Software School Software Development Fundamentals course.

The constraints of the project are that they must use standard library Ruby with the exception of using ActiveRecord as an ORM. The concept with this capstone is to demonstrate mastery of Ruby itself.

The goal of this project is to create an app to help novice and veteran experts alike navigate the nearly-limitless options available when designing and brewing an all-grain Saison, or Belgian Farmhouse ale.

Project Status
--------------
Basic database add-remove-list functionality in place.
Migrations/models in place.
The following commands are fully functional:

* sb
* sb style
* sb techniques
* sb ingredients
* sb list
* sb view <recipe name>
* sb delete <recipe name>
* sb build

####To do:

+ Refactor
+ Bugfix

Features
--------
The primary feature of this app will be the ability to use or modify a library of saison recipes to the user's custom specifications. Modification will be guided by a series of questions, allowing the user to make specific modifications to single elements of the recipe (ie, increase only a specific type of aroma hops, or add a specific spice).

Additionally, a small library of ingredients and style/technique definitions will be included.

In the future, saison builder will include the ability to dynamically generate recipes from the ground up that can then be saved in a library for later retrieval.

Usage Instructions
------------------
Planned usage is as follows:

To begin using the app, cd to the SaisonBuilder directory and type:

    > ruby saisonbuilder

Optionally, add the following to your .zshrc or .bash_profile files to open
with a single 'sb' or 'saisonbuilder' command:

    > alias sb='ruby ~/your/file/path/saisonbuilder'
    > alias saisonbuilder='ruby ~/your/file/path/saisonbuilder'

This will bring up a menu displaying the following options:

    > Return to this menu:             sb
    > Learn about the saison style:    sb style
    > Learn about brewing techniques:  sb techniques
    > Learn about ingredients:         sb ingredients
    > View recipe library:             sb list
    > Build a recipe:                  sb build
    > View an existing recipe:         sb view <recipe_name>
    > Delete an existing recipe:       sb delete <recipe_name>

**The user is then guided through a series of questions to determine and/or modify an appropriate recipe.**

Demo
----
Please download the app and try it out - it's free!

Known Bugs
----------
There will be bugs.

Author
------
Dustin Moore

Changelog
---------

5/10/2013 - Created initial repository with README
5/13/2013 - Refined/fleshed out README and user_stories
5/14/2013 - Added initial gemfile, rakefile, bootstrap_ar, model, tests.
5/15/2013 - Added initial migration, db structure.
5/18/2013 - Added default recipe and ingredient list markdowns.
5/19/2013 - Implemented main menu, style, and techniques commands, seeding ingredients.
5/20/2013 - Implemented initial controllers, question_set module.
5/21/2013 - Implemented initial REPL.
5/22/2013 - Restructured and simplified database schema. Began work on seeding initial recipes.
5/23/2013 - Completed initial recipe seeding. Implemented view recipe command.
5/24/2013 - Fixed display bugs, streamlined recipe seeding and view method. Modify now clones base recipe.
5/25/2013 - Added majority of modify recipe ingredient methods.
5/26/2013 - Added last mod recipe ingr methods, and refactored those methods.
5/27/2013 - Shifted recipe_ingredient mod methods into recipe.

Acknowledgements
----------------

I would like to thank the following staff and mentors who have lent advice and perspective on this project:

+ Eliza Brock
+ Hassan Shamim
+ Ben Bridges
+ Adam Scott
+ Jeff Felchner

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
