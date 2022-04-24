# godot-grave-remade
## About
HeartBeast's Hack and Slash tutorial for GameMaker: Studio 2, remade in Godot 3.4.

**This little project** is my first approach on Godot, an open source game development engine. Rather than just following tutorials, i want to try to build up an old tutorial as a pratical thing to see if i could understand my first lines of code in Godot, while engine differences and simplifications apply.

The ultimate objective is to aim to create a (nearly) identical reproduction of said source material, no matter which programming patterns i may end up use.

The videos were made around June - September 2018, and are years far before HeartBeast switched to Godot for his future game development, but the tutorial content itself is pretty compatible. 

**Original videos:** https://www.youtube.com/playlist?list=PL9FzW-m48fn0mblTG_KFDg81AMXDPKBE5

**Original game:** https://uheartbeast.itch.io/grave (with assets). All assets belong to HeartBeast while this conversion is made purely by me basing off from the video tutorials.

## Differences i discovered
- GDScript, the Node system and the signals are a game changer, but at this process the use of separate scripts from GameMaker: Studio 2 is sacrified. In GameMaker: Studio 2, an object's event consists of a script akin to a init(), step(), draw() process, but are separate rather than being done in one script. Godot Engine kinds of compresses the necessity of scripts by associating scripts on scenes. Also to note separate files such as Sprites, Objects, Rooms, Paths, etc. don't exist anymore as individual things with the use of the Nodes. Signals, instead, are their own methods associated from types of Nodes, and allow for more easier control over game flow in specific functions, such as AnimationPlayer.
- Godot has its own animation system, both with AnimatedSprite and AnimationPlayer. I had never used GameMaker's Sequences or whatsoever but these nodes take away some bits of mechanism with the node-specific options included from them, allowing for a more cleaner and organized sprite control.
- Autoload in Godot allows you to load scenes and scripts (that are also not associated with any scene whatsoever), allowing you to also include a global signal bus for better signal control.
- The input mapping system is present in the Project Settings so you don't have to manually code your own input system alone in GMS2.
