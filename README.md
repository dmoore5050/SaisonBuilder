NSS Saison Builder project
=====================

Purpose
-------
This is my Unit 2 (Ruby) Capstone project for Nashville Software School Software Development Fundamentals course.

The constraints of the project are that they must use standard library Ruby with the exception of being able to use ActiveRecord as an ORM. The concept with this capstone is to demonstrate mastery of Ruby itself.

The goal of this project is to create an app to help novice and veteran experts alike navigate the nearly-limitless options available when designing and brewing an all-grain Saison, or Belgian Farmhouse ale.

Project Status / TODO
---------------------
This project is currently in the planning stages.

Features
--------
The primary feature of this app will be the ability to pick and choose from a broad spectrum of ingredients and techniques to design an all-grain Saison recipe to the user's custom specifications and skill level.

Dynamically generated recipes can then be saved in a user-specific library for later retrieval.

Additionally, a small library of pre-generated recipes will be available as well.

Usage Instructions
------------------
Planned usage is as follows:

To begin using the app, type:

    > saison_builder

This will bring up a graphic with the following options:

    > To learn more about saisons, use --learn
      > To learn about the saison style, use --style
      > To learn about more advanced saison techniques use --techniques
      > To learn about specific saison ingredients use --ingredients
    > To design a new recipe, use --build 
    > To list preloaded and previously saved recipes, use --list
    > To access an existing recipe, use --open <recipe_name>
    > To modify an existing recipe, use --modify <recipe_name>
    > To save a new or modified recipe, use --save <recipe_name>
    > To delete and existing recipe, use --delete <recipe_name>
    > To return to this menu, use --menu

To begin a new design session:

    > saison_builder build <recipe_name>

The user is then guided through a series of questions to formulate an appropriate recipe:

**Baseline knowledge question set** <br>
This will be required initially, with an option to edit after first use:

    > What is your skill level?
    >         Options are: 'beginner', 'intermediate', 'expert'
    > How familiar are you with Saisons and Farmhouse ales?
    >         Options are: 'not at all', 'somewhat', 'very'
    > What range of fermentation temperatures will you have access too?
    >         Options are: '65-75F', '65-85F', '75-85F'

**Subsequent questions will be built around the baseline set** <br>
For example, someone with little to no Saison/homebrewing experience would be
guided towards a more basic option set than someone who considers themselves to
be very familiar with the style.

The process will be a straight-forward prompt-and-response experience for the
user, adjusted to their experience level.

To be continued...

Demo
----
Once it's released, please download the app and try it out - it's free!

Known Bugs
----------
Don't worry, there will be bugs.

Author
------
Dustin Moore

Changelog
---------

5/10/2013 - Created initial repository with README
5/13/2013 - Refined/fleshed out README and user_stories

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
