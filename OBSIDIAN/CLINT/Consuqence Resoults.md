
Hey i need you to take all the sections below and help me make it into proper decisions, please read all the rules and tips, and try to make me 10 really good descriptions, also make sure to format them in the same way shown in ### Structure: - Example: and in JSON format
### Structure: - Example:
here is an example of how you should structure your 
{
   1: {
   
        "KEYWORDS": ["dark"],
        
        "STORYDECISION": "You fall in a dark, deep hole filled with weird creatures and lost of oddly rainbowed moss, luckly your linux phone notified the rescue crew and they will come soon, walking around, you found another lost person, Do you want the crew to: \n\n[i]Rescue him first[/i] or [i]rescue you first[/i]",
        
        "DEC1" : "Him",
        
        "DEC2" : "You",
        
        "CONSEQUENCE1" : {"conseqenceText": "some consequence", "reputation": true, "time": false},
        
		"CONSEQUENCE2" : {"conseqenceText": "some consequence", "reputation": false, "time": true}
    }
# function Theme:
you are placed in a quite normal world, the storydecisions are situtations that could happen to you in real life, thats the whole point, they help you learn.. but dont have it too feneric and lessons people already know, make the decisions teach you a usefull lesson you might have not hear of before, take note a huge(but not all) part of the game is kinda self improvment and being better everyday...  while i need you to base the games decisions on what i just said, everything should be connected with giving you one of the consequences(written below) and i mean that, there shouldnt be any questions that dont directly relate to one of the consequences.. .you should also try to use meaning full keywords, but consequences is num.1 priority

## KEYWORDS

---REALLY IMPORTANT: keywords are static and run trough the whole game, so you cannot just make 2 keywords that are completly opposite and expect them to change as with the decision.. key words run trough the whole interaction or my whole system will brake and chrase, got it?

this is on "KEYWORDS" --- you can and you should put multiple if needed, just make it real good, also never put consequences into the keyword section or my game will crash here are the actual keywords you are able put in "KEYWORDS":
Available Keywords (dont put any out-side of these):
Loud
Quiet
Cold
Hot
Soft
Hard
Sweet
Smooth
Rough
Wet
Dry
Bright
Dim
Fast
Slow
Heavy
Sharp
Smooth
Spacious
Tight
Clear
Cloudy
Muted
Vibrant
## STORYDECISION
this is on STORYDECISION" --- Hey so now i need you to use function Theme's description to make a similar new "STORYDECISION"


## If, Else: - Statments:
this is on "DEC1"and "DEC2" --- ok, so this is basically where you assign what options you have relative to storydecision

## Consequences 
this is on "CONSEQUENCE1", "CONSEQUENCE2" --- i just need you to connect storydecision, if statments to make print what happends when you did chosen action, take note:
"DEC1" resoults in "CONSEQUENCE1" and "DEC2" resoults in "CONSEQUENCE2"

this is super important: i have a list of made results, and you cannot add any, also make sure they actually have some good as logic behind em... the list:

also, you ussaly shoudnt have all of the consuqences, just 1 or 2 maybe 3 really, really specifc to the story and decision

in the double quotation marks are the actual consequences you should put in the json structured file, but next to the there will be a: -Description: and anything thats after this, is just for you to have context and know how to make good story decisions based on these game variables

-"time"  - DESCRIPTION: if its true that means the player has to wait extra time for before the interaction is completed, kinda like he saved someone first and had to wait, false is the opposite, meaning that the player will have to wait less.

-"reputation"  - DESCRIPTION: if its true, the player has better reputation, leading to people liking him more and him being able to buy more things, get them at cheaper prices... and if its false, player will get the opposite, worse reputation.

-"socialconnections" - DESCRIPTION: if its true, the player will get better at social connections, if its false the player gets worse at social connections. The strength of the player's social network could influence their access to information, resources, and assistance from NPCs. Building and maintaining relationships with in-game characters could be crucial.

-"playercash"  - DESCRIPTION: if its true, player will gain a random ammount of cash, if its false, player will lose cash.... also its really important, that you never get gold and cash, you have to decide on either.

-"playergold"   - DESCRIPTION: if its true, player will gain a random ammount of gold, if its false, player will lose gold.... also its really important, that you never get gold and cash, you have to decide on either.
-tool Proficiency

-"fitnesslevel"   - DESCRIPTION: if its true, player will get better at fitness meaning more player speed, player jump height, and if its false players fitness gets worse.

-"health"  - DESCRIPTION: if its true player gains some health, if its false player losses some health.

-"knowledge"  - DESCRIPTION: if its true player gains some knowledge, meaning he gets more money from doing things, it affets other game variables and later on lets him discover new things, if its false player losses some knowledge.


and the way it works, that if you set playercash = true... then i will get money, and visaversa 