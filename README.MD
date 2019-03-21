# Last'n'Furious
v1.0.4



## Game info

'Last & Furious' is a top-down racing game created in Adventure Game Studio, featuring single track, two physics modes, wonky collision system and hastily set up opponent AI.

Made for the 2017 November MAGS competition. It has won the competition itself and later became the winner of 2017 AGS Awards in two categories: as "Best Non-adventure Game created with AGS" and "Best Programming".

**Authors:**

- Ivan Mogilko: Code
- Jim Reed: Graphics
- IniFile module by Ferry "Wyz" Timmers (https://www.adventuregamestudio.co.uk/forums/index.php?topic=46631.0)
- Music by Eric Matyas (www.soundimage.org) and Kevin MacLeod (https://incompetech.com/)


![In-game screenshot](https://i.imgur.com/NhM9RUk.png)


**Controls:** arrow keys.

**Car behavior:** can thrust forward, steer and brake (no backpedal, sorry).

**Physics setup:** when starting new race choose between "Safe" and "Wild" physics mode (they will give you two different experiences!). It is also possible to disable car-vs-car collisions (they still collide with the walls though).

Physics model in this game is actually configurable. If you feel adventurous, go to "Data" subdirectory. There you will find "race_safe.ini" and "race_wild.ini" files which contain parameters for related game modes.

**Game in the AGS database:** https://www.adventuregamestudio.co.uk/site/games/game/2216/

**Release forum thread:** https://www.adventuregamestudio.co.uk/forums/index.php?topic=55534.0

**Couple of videos made by players:**

https://www.youtube.com/watch?v=cIuRMBXJlfg

https://www.youtube.com/watch?v=AKzTENe1EwQ




## On the source

I believe that the script is in a pretty good shape. But due time constraints some parts were written hastily, have various hacks; the code style is also not always consistent.
Comments were added only during development, when time permitted and I was in the mood :).

Some of the script modules are not used by the game anymore, namely VehicleSimple is the first variant of car physics, and RotatedView is a module that is used to dynamically create rotated versions of a sprite and assign them to the given view (silly idea when I wanted car to have only 8 or 16 visual directions).

At the moment the game does not support multiple tracks, quite a few things need to be changed to allow switching maps.
For example, right now it does not distinguish checkpoints file, ai setup file etc between the tracks - it will always read same ones.
A lot of code is unnecessarily put into room script, for example UI drawing should be extracted into separate script.




### 1. On building.

You need AGS 3.4.1 or higher to build the project. In theory, scripts could be imported into AGS 3.4.0 game (not tested).

Please note that the game source must be located in "Last'n'Furious" folder in order to produce binary of same name (a quirk of AGS).

"Data" subfolder contains data that game reads at runtime. After you build the game for the first time, copy Data folder to the Compiled/Windows (Linux, etc).



### 2. Briefly on Data files and development tools.

First of all, many race and car parameters may be edited by hand. This relates to following files in "Data" folder:

* airegions.bmp - this is an AI instruction mask for the "safe physics" mode.
* airegions.ini - this is a legend for airegions.bmp.
* race_safe.ini and race_wild.ini - these are parameters for track areas and cars, for "safe" and "wild" physics mode respectfully.

Other files in "Data" folder are being edited from in-game.

If you build the game in Debug mode, number of developer tools become available in game, allowing you to edit race checkpoints and "wild" race AI mode.

First of all, I strongly recommend to change "Custom shared data path" in the Default Setup and point it to the "Data" folder either in the project's root or Compiled/Windows, whichever you find convenient.
This way everything you do will be saved there (instead of usual APPDATADIR path, which is in "C:/ProgramData/Adventure Game Studio/Last'n'Furious").

This is required because AGS 3.3.5 and higher do not allow you explicitly write files in the place where game is installed.

Another way to enable developer tools, even if the game is not built in debug mode, is to open "options.ini" file in the saved games folder for this game, and put following there:
<pre>
[main]
debug_mode=1
</pre>

Anyhow, when development tools are on, you may use following commands during the race:

* Q - toggles a small infobox with information about player's car physics.
* W - toggles car info overlay: displays car boundary box, direction and velocity vectors.
* E - toggles AI overlay: displays AI path nodes and current directions for each AI controlled car. This only works in "wild physics" mode.
* R - toggles checkpoint overlay: displays race checkpoints and current checkpoint ties for each car (human or AI controlled).
* A - toggles AI builder for the "wild physics" mode.
* Z - toggles checkpoints editor.
* Ctrl+S - saves AI paths and checkpoints.
* Ctrl+L - reloads AI paths and checkpoints.



### 3. Creating and setting up a racing track.

The game uses walkable areas to define different kinds of terrain. You need to draw/import walkable mask to make race work properly.

Cars and terrain parameters are read from Data/race_safe.ini and race_wild.ini. Their meaning is following:

<pre>
[track]
gravity 		- gravity value (float) used when calculating car wheels' grip and friction.
air_resistance		- air resistance factor (float) slows car down.
</pre>

<pre>
[areaX] - where X is a number from 0 to 15
is_obstacle 		- is it an obstacle (0/1) (cars collide with obstacles).
slide_friction		- friction factor (float) for sliding (side-move or when brakes are applied).
roll_friction 		- friction factor (float) for rolling (moving in direction the wheels are facing).
grip 			- grip factor, 0.0 -> 1.0, when grip is < 1, thrust and steering is worse.
env_resistance 		- additional resistance factor (good for water, sand dunes, etc).
</pre>

<pre>
[car]
bodyLength 		- length of a car, in pixels (this and following are floats); by default it's calculated from the sprite, so I commented these.
bodyWidth 		- width of a car.
distanceBetweenAxles 	- distance between axle of steering wheels and driving wheels. Used to calculate turning speed. By default equals to 1/2 of a car.
bodyMass 		- used anywhere where forces are applied to make velocity, also increases friction.
bodyAerodynamics 	- dumb factor, used only with air resistance, the less the better.
hardImpactLossFactor 	- how much of current velocity is lost when car bumps into the obstacle.
softImpactLossFactor	- same for colliding with other cars.
engineMaxPower 		- defines acceleration and max speed. The actual speed limit is imposed mostly by air resistance factor, because air resistance increases with speed.
stillTurningVelocity 	- how fast the car is allowed to turn if its standing still. I made it so players could get out of any situation, but setting to 0.0 will disable it.
driftVelocityFactor 	- defines how early the drifts begin with higher velocity. The actual formula is non-linear, but less value means earlier drift issues.
</pre>

<pre>
[car_control]
steeringAngle		- the angle (in degrees) the car wheels are turning by when player presses arrow keys.
</pre>



### 4. Editing checkpoints.

Checkpoints are used to detect the racers' placement. They are like invisible "nodes" placed on track, and have to be passed in correct order to win the race.

Checkpoints data are read from the Data/checkpoints.dat, where they are stored in binary format (for faster loading), so only way to edit them is using in-game editor.

The checkpoints editor is toggled by 'Z' key in game (if the development tools are enabled, as explained in section 2).

Editor controls:
* LMB 		- select and drag existing node.
* RMB 		- append node to the end of list.
* Insert 		- insert node between SELECTED node and neighbour which is nearest to mouse cursor (node is inserted in the middle of existing connection).
* Delete 		- delete SELECTED node.
* Ctrl+S 		- save your work.
* Ctrl+L 		- reload (will undo changes if you did not save).

The checkpoints are forming a double-linked looped list, meaning that each node remembers connection to previous and next node, and the last placed node is always connected to the first one.



### 5.1. Editing AI. Safe physics mode.

In safe mode the game uses region-based AI system. It reads AI mask from Data/airegions.bmp and legend from Data/airegions.ini. Mask can have up to 16 different regions, where each region has an assigned direction. When AI-controlled car moves over the region, it turns to the direction associated with the region.

Airegions.bmp may be drawn in any gfx editor.

The structure of airegions.ini is following:
<pre>
[regionX] - where X is a number from 0 to 15
color_r
color_g
color_b		- these are color components of the region on bitmap
angle		- direction angle (in degrees) associated with this region.
</pre>



### 5.2. Editing AI. Wild physics mode.

In wild mode the game uses graph-based AI system. It reads node graph from Data/aipaths.dat, where they are stored in binary format, so only way to edit them is using in-game editor.

The AI graph editor is toggled by 'A' key in game (if the development tools are enabled, as explained in section 2).

Editor controls:
* LMB 		- select and drag existing node.
* RMB 		- append node to the end of list.
* Insert 		- insert node between SELECTED node and neighbour which is nearest to mouse cursor (node is inserted in the middle of existing connection).
* Delete 		- delete SELECTED node.
* Home 		- edit node's SPEED value.
* PageUp 		- edit node's CHECK RADIUS value.
* PageDown 	- edit node's DIRECTION THRESHOLD value.
* Ctrl+S 		- save your work.
* Ctrl+L 		- reload (will undo changes if you did not save).

The AI nodes are forming a double-linked looped list, meaning that each node remembers connection to previous and next node, and the last placed node is always connected to the first one.

Node's SPEED value is the speed the AI will try to keep when approaching this node.

Node's RADIUS value is the radius at which the AI will "check out" from this node and switch to the next one. The larger radius is, the further away AI car may be to pass this checkpoint. This is useful when the cars are supposed to drift around the node, because they may pass the node by the very edge of the road.

Node's DIRECTION THRESHOLD is the allowed "offset" from the center of node, used when the AI car is aiming at it. The larger threshold is, the less accurately car will be steering at the node. This is useful when you need to make cars move more freely (with larger offset), or contrary, when you need cars to turn to a very precise direction (with smaller offset).
