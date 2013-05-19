Saison Builder: a @NashSoftware capstone project
================================================

Purpose
-------
This is my Unit 2 (Ruby) Capstone project for Nashville Software School Software Development Fundamentals course.

The constraints of the project are that they must use standard library Ruby with the exception of being able to use ActiveRecord as an ORM. The concept with this capstone is to demonstrate mastery of Ruby itself.

The goal of this project is to create an app to help novice and veteran experts alike navigate the nearly-limitless options available when designing and brewing an all-grain Saison, or Belgian Farmhouse ale.

Project Status
--------------
Basic database add-remove-list functionality in place.

Features
--------
The primary feature of this app will be the ability to pick and choose from a broad spectrum of ingredients and techniques to design an all-grain Saison recipe to the user's custom specifications and skill level.

Dynamically generated recipes can then be saved in a user-specific library for later retrieval.

Additionally, a small library of pre-generated recipes will be available.

Usage Instructions
------------------
Planned usage is as follows:

To begin using the app, type either:

    > saison_builder
or

    > sb

This will bring up a menu displaying the following options:

    > To learn more about saisons,  type 'sb learn'
      > To learn about the saison style, type 'sb style'
      > To learn about more advanced saison techniques, type 'sb techniques'
      > To learn about specific saison ingredients, type 'sb ingredients'
    > To view recipe library, type 'sb list'
    > To build a new recipe, type 'sb add <recipe_name>'
    > To access an existing recipe, type 'sb open <recipe_name>'
    > To modify an existing recipe, type 'sb modify <recipe_name>'
    > To delete an existing recipe, type 'sb remove <recipe_name>'
    > To return to this menu, type 'sb home'

**The user is then guided through a series of questions to determine and/or modify an appropriate recipe.**

(work in progress)

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
