NSS Saison Builder project
=====================

Purpose
-------
This is my Unit 2 (Ruby) Capstone project for Nashville Software School Software Development Fundamentals course.

The constraints of the project are that they must use standard library Ruby with the exception of being able to use ActiveRecord as an ORM. The concept with this capstone is to demonstrate mastery of Ruby itself.

The goal of this project is to create an app to help novice and veteran experts alike navigate the nearly-limitless options available when designing and brewing a Saison, or Belgian Farmhouse ale.

Project Status / TODO
---------------------
This project is currently in the planning stages.

Features
--------
The primary feature of this app will be the ability to pick and choose from a broad spectrum of characteristics and techniques to design a Saison recipe to the user's custom specifications and skill level.

Usage Instructions
------------------
Planned usage is as follows:

To begin a new design session:

    > saison_builder build 'new Saison'

The user will then be guided through a series of questions to formulate an appropriate recipe:
______________________________________________________________________________________________

#####Baseline knowledge question set.
This will be required initially, with an option to edit after first use:

    > What is your skill level? 'beginner', 'intermediate', 'novice'
    > How do you prefer to brew? 'extract', 'partial mash', 'all-grain'
    > How familiar are you with Saisons and Farmhouse ales? 'not at all', 'somewhat', 'very'

#####Subsequent questions will be built around the baseline set.
For example, someone with little to no Saison experience would be guided
towards a more basic option set than someone who considers themselves to be
very familiar with the style.




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
