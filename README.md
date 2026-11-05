# Flicker-Clicker

flicker clicker is an simpler idle clicker game 
where you click a button to light up the bulb while trying to generate power 
balance the power consumption and power generation. 

demo on itch.io : https://bsastudio601.itch.io/flicker-clicker
official release: http://github.com/bsastudio601/flicker-clicker/releases/tag/Flicker-Clicker-V0.0

# Screenshots 

Some gameplay footage:
	
![alt-text](assets/one.png)
![alt-text](assets/two.png)
![alt-text](assets/three.png)
![alt-text](assets/four.png)

# How to install

Its mainly made for android so it has The stable android build.

Go to the release section then download and install the latest apk. And the just open the game as you would open any 
other game!

for demo I also made a build for itch.io

# Feature

* news to add to the gameplay
* multiple different upgrades
* Satisfying clicking sound
* autosaving
* pixelart style
* probably some cool stuff im lazy to add just play it.

# AI Usage

FIRST OF ALL NO AI WAS USED IN MAKING THE ART FOR THE GAME.

mainly ai was used for debugging but ther major places i used ai was :
1. Making the code to record data to adjust balancing for future (a script that records the total value changes ans stuff in a csv file)
2. Using claude to make initial adjustment to every value (basically gave claude the data and asked to generate a spreadsheet of rough value of everything)
3. Making the news description (this is still a initial version)

# Conclusion

I started working on this game as a practice for my other upcomming game tank-clicker which is an another idle clciker game BUT MUCH MORE EPIC!
BUT it turned into a fully fleged project. but it turned out really good! but here are a few main things i learnt. That always sort game code and files neatly. 
and try to make each part as modular as possible (its gonna make debugging and changing things a lot easier). for idle clicker game its a good idea to just store all the value of the game into a single file.
i think its gonna make changing value or doing something with the values a lot easier. Thats the highlight ig :) 

# Tips if you want to edit this game 

* All the values are stored in GameData.gd but change its reset_game func to actually see it being applied.
* The news item are instanced from one tscn scene so dont remove and paste its code as it might change its custom value in the main scene.
* ig thats the main issue i had to struggle with but enjoy! :) 
