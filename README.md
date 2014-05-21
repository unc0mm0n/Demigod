oops :P

Hello
=======================================
    This is just some self practice project where I try to create a bigger game using ruby

The game
--------
    is an island building game, where you need to manage your resources in
    order to unleash the dragon from a dragon shrine and get his
    powers and immortality.. Yeah, very original..

How to play
----------
    Each turn you can choose a tile and either raise it (using favor), or build on it (using other resources).
    Sea (_) turns into Plains (P) which turns into either a forest (F) or a mountain ridge (R). Forests can still be converted to mountains.
    The building are houses, sheeps, woodcutters, chapels, mines and dragon shrine, which give you population, food, wood, favor and iron respectivelt
    Building the dragon shrine is winning the game (not yet implemened)

Buildings
---------
    **houses:**
        can be built on plains and in forests, provide 1 population per turn
    **sheeps:**
        can only be built on plains, provides 1 food per turn
        note: you lose 1 food per population you have, and lost population if you lack food
    **woodcutters:**
        provide 1 wood per turn, which is your basic building resource
    **chapels:**
        provide 1 favor per 10 population you have (not yet implemented in that way)
    **mines:**
        provide 1 iron per turn
    **dragon shrine:**
        win condition, build this and you win!
more info
---------
    most of the hard data will still probably change, so it will remain for you to find it out :P