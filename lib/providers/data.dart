const promptData = '''exam{"recipes": [
{
"name": "Omelet",
"cooktime": "15 minutes",
"description": "A quick and easy breakfast or lunch option.",
"instructions": "1. In a bowl, whisk together the eggs, milk, and salt and pepper.
2. Heat a little butter or oil in a nonstick skillet over medium heat.
3. Pour the egg mixture into the skillet and cook for 2-3 minutes, or until the eggs are set.
4. Add your favorite fillings, such as cheese, ham, bacon, or vegetables.
5. Fold the omelet in half and cook for an additional minute or two, or until the cheese is melted and the fillings are heated through.""",
"tips": "For a fluffier omelet, separate the eggs and beat the egg whites until stiff peaks form before adding them to the egg mixture.",
"ingredients": [
{
"name": "eggs",
"quantity": 3,
},
{
"name": "milk",
"quantity": 1/4 cup,
},
{
"name": "salt and pepper",
"quantity": "to taste",
},
{
"name": "fillings",
"quantity": "to taste",
},
]
},
{
"name": "Scrambled Eggs",
"cooktime": "10 minutes",
"description": "A classic breakfast option that is quick and easy to make.",
"instructions": "1. In a bowl, whisk together the eggs, milk, and salt and pepper.
2. Heat a little butter or oil in a nonstick skillet over medium heat.
3. Pour the egg mixture into the skillet and cook, stirring constantly, until the eggs are set and cooked through.",
"tips": "For creamier scrambled eggs, cook them over low heat and stir them less often.",
"ingredients": [
{
"name": "eggs",
"quantity": 3,
},
{
"name": "milk",
"quantity": 1/4 cup,
},
{
"name": "salt and pepper",
"quantity": "to taste",
},
]
},
{
"name": "Fried Eggs",
"cooktime": "5 minutes",
"description": "A simple but delicious breakfast or lunch option.",
"instructions": "1. Heat a little butter or oil in a nonstick skillet over medium heat.
2. Crack the eggs into the skillet and cook for 2-3 minutes, or until the whites are set and the yolks are cooked to your desired doneness.",
"tips": "For over-easy eggs, cook them for 2-3 minutes per side.
For over-medium eggs, cook them for 3-4 minutes per side.
For over-hard eggs, cook them for 4-5 minutes per side.",
"ingredients": [
{
"name": "eggs",
"quantity": 3,
},
]
},
{
"name": "Poached Eggs",
"cooktime": "5 minutes",
"description": "A delicate and delicious breakfast or lunch option.",
"instructions": "1. Bring a pot of water to a simmer.
2. Crack the eggs into a small bowl.
3. Carefully slip the eggs into the simmering water.
4. Cook for 3-4 minutes, or until the eggs are set and cooked through.",
"tips": "For a poached egg with a runny yolk, cook it for 3 minutes.
For a poached egg with a firm yolk, cook it for 4 minutes.",
"ingredients": [
{
"name": "eggs",
"quantity": 3,
},
]
},
{
"name": "Deviled Eggs",
"cooktime": "15 minutes",
"description": "A classic party appetizer that is always a crowd-pleaser.",
"instructions": "1. Hard-boil the eggs.
2. Peel the eggs and cut them in half lengthwise.
3. Remove the yolks and mash them with a fork.
4. Add your favorite fillings, such as mayonnaise, mustard, relish, and paprika.
5. Spoon the filling into the egg whites.",
"tips": "For a deviled egg with a more pronounced flavor, use a combination of mayonnaise and mustard as the filling.
For a deviled egg with a more delicate flavor, use only mayonnaise as the filling.",
"ingredients": [
{
"name": "eggs",
"quantity": 6,
},
{
"name": "mayonnaise",
"quantity": 1/4 cup,
},
{
"name": "mustard",
"quantity": 1 teaspoon,
},
{
"name": "relish",
"quantity": 1 tablespoon,
},
{
"name": "paprika",
"quantity": "to taste",
},
]
},
{
"name": "Egg Salad",
"cooktime": "15 minutes",
"description": "A classic sandwich filling or salad option that is both delicious and easy to make.",
"instructions": "1. Hard-boil the eggs.
2. Peel the eggs and chop them into small pieces.
3. In a bowl, combine the eggs, mayonnaise, celery, onion, and salt and pepper.
4. Mix well and serve on sandwiches, salads, or crackers.",
"tips": "For a creamier egg salad, use more mayonnaise.
For a more chunky egg salad, use less mayonnaise.",
"ingredients": [
{
"name": "eggs",
"quantity": 6,
},
{
"name": "mayonnaise",
"quantity": 1/4 cup,
},
{
"name": "celery",
"quantity": 1/4 cup,
},
{
"name": "onion",
"quantity": 1/4 cup,
},
{
"name": "salt and pepper",
"quantity": "to taste",
},
]
},
{
"name": "Chocolate Chip Cookies",
"cooktime": "12 minutes",
"description": "A classic cookie that is always a favorite.",
"instructions": "1. Preheat oven to 375 degrees F (190 degrees C).
2. In a large bowl, cream together the butter and sugars until light and fluffy.
3. Beat in the eggs one at a time, then stir in the vanilla.
4. In a separate bowl, whisk together the flour, baking soda, and salt.
5. Gradually add the dry ingredients to the wet ingredients, mixing until just combined.
6. Fold in the chocolate chips.
7. Drop by rounded tablespoons onto ungreased baking sheets.
8. Bake for 10-12 minutes, or until the edges are golden brown and the centers are set.",
"tips": "For chewier cookies, bake them for 10 minutes.
For crispier cookies, bake them for 12 minutes.",
"ingredients": [
{
"name": "butter",
"quantity": 1 cup,
},
{
"name": "sugar",
"quantity": 1 cup,
},
{
"name": "brown sugar",
"quantity": 1 cup,
},
{
"name": "eggs",
"quantity": 2,
},
{
"name": "vanilla",
"quantity": 1 teaspoon,
},
{
"name": "flour",
"quantity": 2 cups,
},
{
"name": "baking soda",
"quantity": 1 teaspoon,
},
{
"name": "salt",
"quantity": 1/2 teaspoon,
},
{
"name": "chocolate chips",
"quantity": 1 cup,
},
]
},
{
"name": "Brownies",
"cooktime": "25 minutes",
"description": "A rich and fudgy dessert that is perfect for any occasion.",
"instructions": "1. Preheat oven to 350 degrees F (175 degrees C).
2. Grease and flour a 9x13 inch baking pan.
3. In a large bowl, melt the butter and chocolate together in the microwave or over a double boiler.
4. Stir in the sugar, eggs, and vanilla.
5. In a separate bowl, whisk together the flour, baking powder, and salt.
6. Gradually add the dry ingredients to the wet ingredients, mixing until just combined.
7. Pour the batter into the prepared pan and bake for 25 minutes, or until a toothpick inserted into the center comes out clean.",
"tips": "For fudgier brownies, bake them for 25 minutes.
For cakier brownies, bake them for 30 minutes.",
"ingredients": [
{
"name": "butter",
"quantity": 1 cup,
},
{
"name": "chocolate chips",
"quantity": 1 cup,
},
{
"name": "sugar",
"quantity": 1 cup,
},
{
"name": "eggs",
"quantity": 2,
},
{
"name": "vanilla",
"quantity": 1 teaspoon,
},
{
"name": "flour",
"quantity": 1 cup,
},
{
"''';

const datateo = """
{
        "recipes": [
          {
            "name": "Easy Scrambled Eggs",
            "cooktime": "10 minutes",
            "description": "Simple and delicious, scrambled eggs are a great way to start your day.",
            "instructions": [
              "Whisk the eggs in a bowl.",
              "Heat a little olive oil in a non-stick skillet over medium heat.",
              "Pour the eggs into the skillet and cook, stirring constantly, until set and cooked through."
            ],
            "tips": "For fluffy scrambled eggs, cook them over low heat and stir gently.",
            "ingredients": [
              {
                "name": "eggs",
                "quantity": 3,
              }
            ]
          },
          {
            "name": "Pasta with Tomato Sauce",
            "cooktime": "30 minutes",
            "description": "A classic Italian dish, pasta with tomato sauce is easy to make and always a crowd-pleaser.",
            "instructions": [
              "Cook the pasta according to the package directions.",
              "While the pasta is cooking, heat the olive oil in a large skillet over medium heat.",
              "Add the onions and garlic to the skillet and cook until softened.",
              "Add the tomatoes to the skillet and cook, stirring occasionally, until the sauce has thickened.",
              "Add the cooked pasta to the skillet and stir to combine.",
              "Season with salt and pepper to taste."
            ],
            "tips": "For a richer flavor, use a combination of fresh and canned tomatoes.",
            "ingredients": [
              {
                "name": "pasta",
                "quantity": 1,
              },
              {
                "name": "olive oil",
                "quantity": 1,
              },
              {
                "name": "onions",
                "quantity": 3,
              },
              {
                "name": "garlic",
                "quantity": 1,
              },
              {
                "name": "tomatoes",
                "quantity": 2,
              }
            ]
          },
          {
            "name": "Chicken and Rice Soup",
            "cooktime": "1 hour",
            "description": "A comforting and healthy soup, chicken and rice soup is perfect for a cold day.",
            "instructions": [
              "In a large pot, brown the chicken breasts over medium heat.",
              "Add the onions, celery, and carrots to the pot and cook until softened.",
              "Add the chicken broth and water to the pot and bring to a boil.",
              "Add the rice and cook until tender.",
              "Season with salt and pepper to taste."
            ],
            "tips": "For a thicker soup, add more rice. For a thinner soup, add more broth or water.",
            "ingredients": [
              {
                "name": "chicken breasts",
                "quantity": 5,
              },
              {
                "name": "olive oil",
                "quantity": 1,
              },
              {
                "name": "onions",
                "quantity": 3,
              },
              {
                "name": "celery",
                "quantity": 1,
              },
              {
                "name": "carrots",
                "quantity": 1,
              },
              {
                "name": "chicken broth",
                "quantity": 1,
              },
              {
                "name": "rice",
                "quantity": 1,
              }
            ]
          },
          {
            "name": "Baked Potatoes",
            "cooktime": "1 hour",
            "description": "A simple but delicious side dish, baked potatoes are a great way to use up leftover potatoes.",
            "instructions": [
              "Preheat the oven to 400 degrees F (200 degrees C).",
              "Scrub the potatoes clean and pierce them with a fork.",
              "Place the potatoes on a baking sheet and bake for 1 hour, or until tender.",
              "Let the potatoes cool slightly before serving."
            ],
            "tips": "For a crispy skin, rub the potatoes with olive oil before baking.",
            "ingredients": [
              {
                "name": "potatoes",
                "quantity": 12,
              }
            ]
          },
          {
            "name": "Spinach Salad with Lemon Vinaigrette",
            "cooktime": "10 minutes",
            "description": "A refreshing and healthy salad, spinach salad with lemon vinaigrette is a great way to get your daily dose of greens.",
            "instructions": [
              "In a large bowl, combine the spinach, tomatoes, onions, and feta cheese.",
              "In a small bowl, whisk together the olive oil, lemon juice, salt, and pepper.",
              "Pour the dressing over the salad and toss to combine."
            ],
            "tips": "For a more flavorful salad, use a variety of greens, such as spinach, arugula, and romaine lettuce.",
            "ingredients": [
              {
                "name": "spinach",
                "quantity": 1,
              },
              {
                "name": "tomatoes",
                "quantity": 2,
              },
              {
                "name": "onions",
                "quantity": 3,
              },
              {
                "name": "feta cheese",
                "quantity": 1,
              },
              {
                "name": "olive oil",
                "quantity": 1,
              },
              {
                "name": "lemon juice",
                "quantity": 1,
              }
            ]
          }
        ]
      }""";

const datawe = """{
      "recipes":[
      {
      "name":"Baked Chicken and Rice",
      "cook_time":"45 minutes",
      "description":"This simple and flavorful dish is perfect for a weeknight meal. The chicken is juicy and tender, and the rice is fluffy and flavorful.",
      "instructions":"1. Preheat oven to 375 degrees F (190 degrees C).",
      "2. In a large bowl, combine chicken, rice, olive oil, salt, and pepper.",
      "3. Spread mixture in a 9x13 inch baking dish.",
      "4. Bake for 45 minutes, or until chicken is cooked through and rice is tender.",
      "tips":"For a more flavorful dish, use brown rice instead of white rice.",
      "ingredients":[
      {
      "name":"chicken breasts",
      "quantity": 5
      },
      {
      "name":"rice",
      "quantity": 1
      },
      {
      "name":"olive oil",
      "quantity": 1
      },
      {
      "name":"salt",
      "quantity": 1
      },
      {
      "name":"pepper",
      "quantity": 1
      }
      ]
      },
      {
      "name":"Scrambled Eggs with Bell Peppers and Onions",
      "cook_time":"15 minutes",
      "description":"This quick and easy breakfast is packed with protein and flavor.",
      "instructions":"1. In a large skillet, heat olive oil over medium heat.",
      "2. Add bell peppers and onions and cook until softened.",
      "3. Add eggs and cook until scrambled.",
      "4. Serve with toast or tortillas.",
      "tips":"For a more flavorful dish, add some cheese or salsa to the scrambled eggs.",
      "ingredients":[
      {
      "name":"eggs",
      "quantity": 3
      },
      {
      "name":"olive oil",
      "quantity": 1
      },
      {
      "name":"bell peppers",
      "quantity": 3
      },
      {
      "name":"onions",
      "quantity": 3
      }
      ]
      },
      {
      "name":"Pasta with Tomato Sauce",
      "cook_time":"30 minutes",
      "description":"This classic Italian dish is easy to make and always a crowd-pleaser.",
      "instructions":"1. In a large pot, bring water to a boil and cook pasta according to package directions.",
      "2. While pasta is cooking, heat olive oil in a large skillet over medium heat.",
      "3. Add tomatoes, garlic, and basil and simmer for 15 minutes.",
      "4. Add cooked pasta to the sauce and stir to combine.",
      "5. Serve with grated Parmesan cheese.",
      "tips":"For a more flavorful sauce, use fresh tomatoes instead of canned tomatoes.",
      "ingredients":[
      {
      "name":"pasta",
      "quantity": 1
      },
      {
      "name":"olive oil",
      "quantity": 1
      },
      {
      "name":"tomatoes",
      "quantity": 2
      },
      {
      "name":"garlic",
      "quantity": 1
      },
      {
      "name":"basil",
      "quantity": 1
      },
      {
      "name":"Parmesan cheese",
      "quantity": 1
      }
      ]
      },
      {
      "name":"Eggs with Spinach and Tomatoes",
      "cook_time":"20 minutes",
      "description":"This simple and healthy dish is a great way to start your day.",
      "instructions":"1. In a large skillet, heat olive oil over medium heat.",
      "2. Add spinach and cook until wilted.",
      "3. Add tomatoes and eggs and cook until eggs are cooked to your desired doneness.",
      "4. Serve with toast or tortillas.",
      "tips":"For a more flavorful dish, add some cheese or salsa to the eggs.",
      "ingredients":[
      {
      "name":"eggs",
      "quantity": 3
      },
      {
      "name":"olive oil",
      "quantity": 1
      },
      {
      "name":"spinach",
      "quantity": 1
      },
      {
      "name":"tomatoes",
      "quantity": 2
      }
      ]
      },
      {
      "name":"Peanut Butter and Jelly Sandwich",
      "cook_time":"5 minutes",
      "description":"This classic American sandwich is a quick and easy meal that's always a crowd-pleaser.",
      "instructions":"1. Spread peanut butter on one slice of bread.",
      "2. Spread jelly on the other slice of bread.",
      "3. Put the two slices of bread together and enjoy!",
      "tips":"For a more flavorful sandwich, use chunky peanut butter and grape jelly.",
      "ingredients":[
      {
      "name":"peanut butter",
      "quantity": 1
      },
      {
      "name":"jelly",
      "quantity": 1
      },
      {
      "name":"bread",
      "quantity": 2
      }
      ]
      },
      {
      "name":"Potatoes with Cheese and Onions",
      "cook_time":"45 minutes",
      "description":"This simple and flavorful dish is a great side dish for any meal.",
      "instructions":"1. Preheat oven to 375 degrees F (190 degrees C).",
      "2. In a large bowl, combine potatoes, olive oil, salt, and pepper.",
      "3. Spread mixture in a 9x13 inch baking dish.",
      "4. Top with cheese and onions.",
      "5. Bake for 45 minutes, or until potatoes are tender and cheese is melted.",
      "tips":"For a more flavorful dish, use a variety of cheeses, such as cheddar, mozzarella, and Parmesan.",
      "ingredients":[
      {
      "name":"potatoes",
      "quantity": 12
      },
      {
      "name":"olive oil",
      "quantity": 1
      },
      {
      "name":"salt",
      "quantity": 1
      },
      {
      "name":"pepper",
      "quantity": 1
      },
      {
      "name":"cheese",
      "quantity": 1
      },
      {
      "name":"onions",
      "quantity": 3
      }
      ]
      }
      ]
      }""";
