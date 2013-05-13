As an inexperienced homebrewer/saison drinker, 
In order to find a saison recipe that I can brew,
And that will help me establish a baseline for the Saison style:

 * To access initial menu, user runs > saison_builder
 * If the user is a first-time app user, User answers baseline skill survey, after which menu displays 
 * To view preloaded recipes, user runs `saison_builder list`
 * User chooses a recipe based on style descriptions provided by typing `saison_builder open <recipe_name>`
 * User views provided saison recipe, and chooses to use it, OR
 * User returns to previous list of style descriptors, selects a different recipe, repeats.

<hr>

As an experienced homebrewer/inexperienced Saison drinker/brewer,
In order to find a solid base saison recipe,
That I can modify freely to meet my tastes:
 
 * To access initial menu, user runs `saison_builder`
 * If the user is a first-time app user, User answers baseline skill survey, after which menu displays 
 * To view preloaded recipes, user runs `saison_builder list`
 * User chooses a recipe based on style descriptions provided
 * User views provided saison recipe, and chooses to use it, OR
 * User returns to previous list of style descriptors, selects a different recipe, repeats.
 * Once a recipe is chosen, from recipe view user runs `saison_builder modify`
 * User is guided through a series of ingredient choices.
 * When finished, user runs `saison_builder save <recipe_name>`
 * After entering a required short description, the recipe is saved

<hr>

As an experienced hombrewer/Saison drinker,
In order to build a new Saison recipe from scratch:

 * To access initial menu, user runs `saison_builder`
 * If the user is a first-time app user, User answers baseline skill survey
 * To initialize a new recipe, user runs `saison_builder build <recipe_name>`
 * User is then guided through the recipe building process by answering questions on
   every aspect of saison desired - gravity, malt bill, hops, yeast(s).
 * When finished, user runs `saison_builder save <recipe_name>`

<hr>

As a user who has prevously used the app to create and save recipes,
In order to access or delete a previously created recipe:

 * To access initial menu, user runs `saison_builder`
 * To list previously saved recipes, user runs `saison_builder list`
 * User opens a listed recipe by typing `saison_builder open <recipe_name>`
 * User deletes a listed recipe by typing `saison_builder delete <recipe_name>`

<hr>

As a user who wishes to learn more about the saison style,
Or about specific ingredients or brewing techniques:

 * User runs saison_builder to access initial menu
 * If the user is a first-time app user, User answers baseline skill survey, after which menu displays 
 * To open style guide, user runs `saison_builder style`
 * To learn about specific saison-brewing techniques, user runs `saison_builder techniques`
 * User then selects a technique/ingredient area to learn about by running `saison_builder <ingredient/technique_name>`

<hr>


#Rough draft:

####as a _ homebrewing newbie ...
* in order to _ find an easy to brew recipe
 * that is _ a classic style example
 * that is _ hop-centric, rustic
 * that is _ bright, citrusy
 * that uses _ rye
 * that uses _ wheat

####as a _ experienced homebrewer/saison_newbie ...
* in order to _ find a quick recipe
 * that is _ a classic style example (Dupont, pils, bit of munich, restrained saaz)
 * that is _ hop-centric (Dupont strain, backload saaz)
 * that is _ bright, citrusy (3711, zest, sorachi/motueka)
* in order to _ experiment with Brett
 * that has _ subtle brett presence (hybrid yeast, or finish with Brett)
 * that is _ hop-centric w/ subtle brett (hybrid yeast, or finish with Brett, saaz backload)
 * that is _ bright, citrusy (3711, zest, sorachi/motueka, brett C?)
 * that is _ solely fermented with Brett (variant...)

####as a _ saison_vet/adjunct newbie ...
* in order to _ focus on a specific adjunct flavor
 * that is _ floral (classic base, floral addition)
 * that is _ spiced (specific spices)

####as a _ saison/adjunct vet
* in order to _ find a unique/experimental combination of ingredients
 * that is _ floral/brett-finished/rye
 * that is _ all brett/fruit/zest
 * that is _ black_saison/brett-finished/spiced
