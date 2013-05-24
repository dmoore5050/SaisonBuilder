As an inexperienced homebrewer/saison drinker,<br>
In order to find a saison recipe that I can brew,<br>
And that will help me establish a baseline for the Saison style:<br>

 * To access initial menu, user runs > saison_builder
 * If the user is a first-time app user, User answers baseline skill survey, after which menu displays
 * To view preloaded recipes, user runs `saison_builder list`
 * User chooses a recipe based on style descriptions provided by typing `saison_builder open <recipe_name>`
 * User views provided saison recipe, and chooses to use it, OR
 * User returns to previous list of style descriptors, selects a different recipe, repeats.

<hr>

As an experienced homebrewer/inexperienced Saison drinker/brewer,<br>
In order to find a solid base saison recipe,<br>
That I can modify freely to meet my tastes:<br>

 * To access initial menu, user runs `saison_builder`
 * If the user is a first-time app user, User answers baseline skill survey, after which menu displays
 * To view preloaded recipes, user runs `saison_builder list`
 * User chooses a recipe based on style descriptions provided
 * User views provided saison recipe, and chooses to use it, OR
 * User returns to previous list of style descriptors, selects a different recipe, repeats.
 * Once a recipe is chosen, from recipe view user runs `saison_builder modify <recipe_name>`
 * User is guided through a series of ingredient choices.
 * When finished, user runs `saison_builder save <recipe_name>`
 * After entering a required short description, the recipe is saved

<hr>

As an experienced hombrewer/Saison drinker,<br>
In order to build a new Saison recipe from scratch:<br>

 * To access initial menu, user runs `saison_builder`
 * If the user is a first-time app user, User answers baseline skill survey
 * To initialize a new recipe, user runs `saison_builder build <recipe_name>`
 * User is then guided through the recipe building process by answering questions on
   every aspect of saison desired - gravity, malt bill, hops, yeast(s).
 * When finished, user runs `saison_builder save <recipe_name>`

<hr>

As a user who has prevously used the app to create and save recipes,<br>
In order to access or delete a previously created recipe:<br>

 * To access initial menu, user runs `saison_builder`
 * To list previously saved recipes, user runs `saison_builder list`
 * User opens a listed recipe by typing `saison_builder open <recipe_name>`
 * User deletes a listed recipe by typing `saison_builder delete <recipe_name>`

<hr>

As a user who wishes to learn more about the saison style,<br>
Or about specific ingredients or brewing techniques:<br>

 * User runs saison_builder to access initial menu
 * If the user is a first-time app user, User answers baseline skill survey, after which menu displays
 * To display options for additional reading, user runs `saison_builder learn`
 * To open style guide, user runs `saison_builder style`
 * To learn about specific saison-brewing techniques, user runs `saison_builder techniques`
 * User then selects a technique area to learn about by running `saison_builder techniques <technique_name>`
 * To learn about specific saison-brewing ingredients, user runs `saison_builder ingredients`
 * User then selects an ingredient area to learn about by running `saison_builder ingredients <technique_name>`

<hr>
