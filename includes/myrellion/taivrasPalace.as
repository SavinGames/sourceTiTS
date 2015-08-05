import classes.Items.Miscellaneous.GemSatchel;
//flags["CRYSTAL_GOO_DEFEAT"] - 1 = HP, 2 = LUST, 3 = you fucked her after winning (or got egged)

public function showTaivra(nude:Boolean = false):void
{
	if (nude) showBust("TAIVRA_NUDE");
	else showBust("TAIVRA");
	showName("QUEEN\nTAIVRA");
}
public function showQueensguard():void
{
	showName("\nQUEENSGUARD");
	showBust("QUEENSGUARD");
}

public function showRival():void
{
	userInterface.showBust(chars["RIVAL"].short.toUpperCase());
	userInterface.showName(chars["RIVAL"].short.toUpperCase());
}

//Add to the Gates of Taivra’s Palace square”</i>
public function taivrasPalaceSquareBonus():Boolean
{
	//if Praetorian fight not won:
	if(flags["FOUGHT_PRAETORIANS"] == undefined)
	{
		output("\n\nA pair of nyrea huntresses stand in front of the towering stone gates, under the light of a pair of <i>“torches”</i> filled with glowing blue fungus. The pair of women are clad in bands of metal armor in addition to their trademark bikini mail, and each holds a long spear in her hands. They look impassively at you, but make no move to attack.");
		//[Approach]
		addButton(0,"Approach",approachNyreanGuardsFirstTime,undefined,"Approach","Talk to the nyrea guards and see if you can get passage past the gate. You’re almost sure the coordinates you got for Dad’s probe lead to a position right near here...");
	}
	//{if PC has done Praetoran fite:}
	else
	{
		//KING NYREA!
		if(9999 == 0)
		{
			output("\n\nA pair of nyrean huntresses in light armor and carrying spears stand outside the gates, staring impassively into the corridor. When you approach, they awkwardly press their open palms to their hearts and bow. <i>“My liege,”</i> one of them says by way of greeting.");
		}
		//within 12 hours:
		if(flags["PRAETORIAN_RESPAWN"] != 0 && flags["PRAETORIAN_RESPAWN"] != undefined) output("\n\nA squad of armed and armored nyrean huntresses are scattered around the ground, recovering from the ass-kicked you gave them earlier. When they see you standing around, they either get small or play dead in a hurry.");
		//13+ hours, BEAT DUNGEON SOME OTHER WAY!
		else if(9999 == 0) 
		{
			output("\n\nThe gates are sealed, and nobody is standing outside. There doesn’t seem to be any way you can get the gate open without a lot of help...");
			//9999 make sure gate be sealed yo?
		}
		
		//13+ hours, PC hasn’t finished dungeon OR PC got rekt by the Praetorian last time:
		else
		{
			output("\n\nThe queen’s bodyguard seems to have recovered and are prepared to fight you off again!");
			//PC can’t advance past until they [Fight], which leads straight into another battle.
			clearMenu();
			addButton(0,"Fight",startCombat,"Nyrean Praetorians");
			return true;
		}
	}
	return false;
}

//[Approach]
//Talk to the nyrea guards and see if you can get passage past the gate. You’re almost sure the coordinates you got for Dad’s probe lead to a position right near here...
public function approachNyreanGuardsFirstTime():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("You walk over to the guards, hoping to talk to them. Instead, the guardswomen plant their feet and cross their spears over the heavy stone gate, an unnecessary but obvious sign that you’re about to be refused passage.");
	output("\n\n<i>“Turn back, star-walker,”</i> one of the women says; the other twists her black lips into a distinct frown. <i>“Queen Taivra has decreed no more offworlders are to be permitted in the palace. Your kind have done us enough insult.”</i>");
	output("\n\n<i>“What?”</i> you ask. Definitely weren’t expecting that answer.");
	output("\n\nThe other guard grunts. <i>“Our queen was attacked by one of you space-creatures. One who said " + pc.mf("he","she") + " wished to talk diplomacy. We will not suffer such an insult again... you kind is no longer welcome here.”</i>");
	output("\n\nShit. Something tells you this sociopathic star-walker they’re talking about just might be your dear cousin " + chars["RIVAL"].mf("Jack","Jill") + "...");
	processTime(2);
	//[Leave] [Attack] [Persuade]
	clearMenu();
	addButton(14,"Leave",mainGameMenu);
	addButton(0,"Attack",attackDemAntBiyotches,undefined,"Attack","Unfortunately for these bitches, you need to get into that palace. If your cousin’s inside, so too must be the probe...");
	addButton(1,"Persuade",tryAndPerseudeFutaBugSlootsToMooooove,undefined,"Persuade","Try and talk your way into the nyrean camp. Surely the three of you could work something out...");

}

//[Attack]
//Unfortunately for these bitches, you need to get into that palace. If your cousin’s inside, so too must be the probe...
public function attackDemAntBiyotches():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("<i>“I’m going in. Like it or not,”</i> you tell the guards, drawing your [pc.weapon].");
	output("\n\nThe guards lower their spears at you, and one of them grabs a rope behind her, leading into the wall. A bell resounds inside, and a moment later the gate is creaking open and several more nyrean huntresses are pouring out. And suddenly, your odds look a little less great...");
	processTime(1);
	//[Fight!]
	clearMenu();
	addButton(0,"Next",startCombat,"Nyrean Praetorians");
}

//[Persuade]
//Try and talk your way into the nyrean camp. Surely the three of you could work something out...
public function tryAndPerseudeFutaBugSlootsToMooooove():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("<i>“Come on, can’t we work something out?”</i> you ask, putting on your most diplomatic smile.");
	output("\n\nThe two guards exchange a glance, and one of them puts a hand on her hip. <i>“Hmm, at least this one understands parley. Very well, perhaps we could convince the queen to see you. If you have something of sufficient value...");
	processTime(1);
	clearMenu();
	//[Leave] [Sex] [Plat190] [Credits]
	addButton(14,"Leave",mainGameMenu);
	addButton(0,"Sex",sexYourWayIntoTaivras,undefined,"Sex","Sacrifice your dignity for diplomacy... fuck the guards to get in.");
	addButton(1,"Credits",bribeTaivrasGateGuards,undefined,"Credits","Offer to give the guards some credits. Surely they like good old bribery down here...");
}

//[Sex]
//Sacrifice your dignity for diplomacy... fuck the guards to get in.
public function sexYourWayIntoTaivras():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("<i>“No,”</i> one of the guards scowls when you offer to let them have their way with you. <i>“We’ve an entire village of virile males down below. Exotic... and attractive... as you are, pleasures of the flesh aren’t worth the queen’s ire.”</i>");
	output("\n\n<i>“If that’s the best you have to offer, begone,”</i> the other guard says.");
	processTime(1);
	//[Next] back to map
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[Credits]
//Offer to give the guards some credits. Surely they like good old bribery down here...
public function bribeTaivrasGateGuards():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("You pull out your credit stick invitingly, only to receive confused looks from the guards. <i>“What’s that?”</i> one asks, snatching it and looking it over. <i>“Some kind of weapon?”</i>");
	output("\n\n<i>“No, no,”</i> you say, condensing an economics lesson into as few words as possible: you tell her that credits are star-walker money, and they can buy whatever they want that way.");
	output("\n\nThe other guard grabs the credstick out of the first’s hand and shoves it back into yours. <i>“Your money isn’t worth much down here,”</i> she says. <i>“We trade in gemstones and precious minerals. Not... imaginary money.”</i>");
	output("\n\nGemstones? Minerals? ");
	processTime(2);
	if(!pc.hasKeyItem("Platinum 190")) 
	{
		output("Where’re you going to get some of those?");
		clearMenu();
		addButton(0,"Next",mainGameMenu);
	}
	else 
	{
		output("Oh, is that what they want...?");
		clearMenu();
		addButton(0,"Plat. 190",offerTaivraGuardsPlat190,undefined,"Plat. 190","Offer your chunk of Platinum 190. Surely these ladies can appreciate the rare beauty of precious metals!");
		addButton(4,"Back",mainGameMenu);
	}
}

//[Plat190]
//Offer your chunk of Platinum 190. Surely these ladies can appreciate the rare beauty of precious metals!
public function offerTaivraGuardsPlat190():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("<i>“How about this?”</i> you ask, taking the chunk of gleaming platinum out of your pack.");
	output("\n\nThe huntresses’ eyes go wide, and one of them takes hold of the shard of ore and looks it over. <i>“It’s beautiful,”</i> she says, waving her comrade over. <i>“Where did you get this?”</i>");
	output("\n\nYou grin and explain that you found the shard in the heart of a dead, alien planet that had been sewn together from two other half-planets. It’s a rare and awesomely expensive isotope of platinum - surely it would fetch a good price down here in the depths, or if they try to sell it to an off-worlder.");
	output("\n\n<i>“This will do nicely,”</i> one of the guards smiles, slipping the platinum shard into a pouch on her belt. <i>“Very well, follow us. We can take you to the queen’s chambers, but I cannot guarantee she’ll want to listen to whatever you have to say.”</i>");
	output("\n\n<i>“Follow us,”</i> the other says, pushing the front gate open and beckoning you on.");
	//[Next] //To <i>“Meeting the Queen,”</i> as if you’d done the whole fucken dungeon. YA CHEETER.
	processTime(15);
	clearMenu();
	addButton(0,"Next",queenTaivrasThrone,true);
	pc.removeKeyItem("Platinum 190");
	flags["PLAT190 USED AS NYREA BRIBE"] = 1;
}

//Spear Flurry
//Several light Penetrating attacks.

public function spearFlurryNyreaShit():void
{
	output("Several of the huntresses leap forward from one side, jabbing their spears at your chest.\n");
	attack(foes[0],pc,true,1);
	output("\n");
	attack(foes[0],pc,true,1);
	output("\n");
	attack(foes[0],pc,true,1);
	output("\n");
	attack(foes[0],pc,true,1);
	output("\n");
	attack(foes[0],pc,true,1);
	processCombat();
	//{You manage to dodge, block, and parry every attack they send your way! // You block and dodge most of the attacks, but a few still manage to get through, hammering you down. // You try to defend yourself, but most if not all of the strikes get through, battering you brutally.}
}

//Backstab
//One heavy Penetrating attack that inflicts a bleeding/some crippling condition
public function nyreaGroupBackstabby():void
{
	output("Several of the huntresses attack you for the front, jabbing and stabbing and pushing you back. As they do, though, you ");
	if(combatMiss(foes[0],pc))
	{
		output("just barely notice another nyrea attempting to stab you in the back. You quickly spin around and shove her back, preventing the attack.");
	}
	else
	{
		output("fail to notice one of their sisters behind you grabbing a dagger and leaping to attack you, sinking the dagger into ");
		if(pc.shields() <= 0) output("you");
		else output("your shields");
		output(".");
		//Hacky way to force backstab proc!
		pc.createStatusEffect("Blind");
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
		pc.removeStatusEffect("Blind");
	}
	foes[0].energy(-10);
	processCombat();
}

//Posion Blade
//Light Penetrating attack, moderate Lust (Chemical) damage. Shields must be down.
public function poisonBlade():void
{
	output("One of the nyrea takes a pouch of some pulsating pink fungus from her belt and smears it all over the tip of her long spear. Once she’s done, the huntress leaps forward and lunges at you with her spear. ");
	if(combatMiss(foes[0],pc))
	{
		output("You manage to grab her spear before it can hit you, and you quickly snap the head off, tossing the poison aside.");
	}
	else
	{
		output("You try and dodge, but her sisters give you no room to maneuver; you end up getting sliced by it! Hissing with pain, you recoil and grab your bloodied [pc.skinNoun]... and quickly begin to feel the poison boiling through you, making your body burn with unbidden arousal.");
		applyDamage(new TypeCollection( { drug: 15, kinetic: foes[0].meleeDamage() } ), foes[0], pc, "minimal");
		//4 rounds of lust damage!
		if(!pc.hasStatusEffect("Aphro")) pc.createStatusEffect("Aphro",5,4,0,0,false,"Icon_DrugVial","An aphrodisiac is in your blood, exciting you over time! It should fade quickly... unless you get redosed.",true,0);
		else 
		{
			output(" <b>The chemical in your blood is getting stronger!</b>");
			pc.addStatusValue("Aphro",1,3);
			pc.setStatusValue("Aphro",2,4);
		}
	}
	foes[0].energy(-5);
	processCombat();
}

//Spear Butt
//Bonk with spear for moderate Bludgeon damage. Chance to stun.
public function nyreanSpearButt():void
{
	output("One of the nyrea spins her spear around before swinging the blunt end at you like a club.");
	if(combatMiss(foes[0],pc)) output("\nYou dodge out of the way, narrowly avoiding a crushing blow.");
	else 
	{
		output("\nYou don’t manage to dodge in time, and get a thunderous wallop on the head for your trouble! You stagger back, clutching your aching head.");
		if(foes[0].physique()/2 + rand(20) + 1 > pc.physique()/2 + 10 && !pc.hasStatusEffect("Stunned"))
		{
			output(" <b>You are stunned!</b>");
			pc.createStatusEffect("Stunned",2,0,0,0,false,"Stun","You cannot act until you recover!",true,0);
		}
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
	}
	foes[0].energy(-5);
	processCombat();
}

//Spear Wall
//Dramatically increases the Praetorians’ Dodge vs. Melee for a few turns
public function spearWallGoooo():void
{
	output("The huntresses form a tighter ring, shoulder to shoulder, and brace their spears against you. It’s almost impossible to move now, and <b>hitting the huntresses is going to be damn hard.</b>");
	//+50% dodge vs ERRYTHING.
	foes[0].createStatusEffect("Evasion Boost",50,0,0,0,false,"Icon_DefUp","The nyrea have created a wall of spears, granting them a 50% evade chance!",true,4);
	foes[0].energy(-20);
	processCombat();
}

public function praetorianAI():void
{
	if(!foes[0].hasStatusEffect("Evasion Boost") && foes[0].energy() >= 20 && (rand(4) == 0 || foes[0].HP() < 100)) spearWallGoooo();
	else if(foes[0].energy() >= 5 && rand(6) == 0) nyreanSpearButt();
	else if(foes[0].energy() >= 5 && rand(4) == 0) poisonBlade();
	else if(foes[0].energy() >= 10 && rand(3) == 0) nyreaGroupBackstabby();
	else spearFlurryNyreaShit();
}

//PC Loses to the Praetorian
//Not a bad end! Huntresses gang-bang you and dump you in town. Have to attempt Praetorian fight again. Lose some credits, of course.
public function loseToPraetorianNyreaGangbangu():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("You stumble to your [pc.knees], ");
	if(pc.lust() >= pc.lustMax()) output("too horny to resist the buxom babes trying to bring you down");
	else output("so badly beaten by the horde of guards that you can barely lift your arms up to fight back anymore");
	output(". A couple of the insectile amazons grab your [pc.weapon] and toss it aside; another grabs your ");
	if(!pc.isNude()) output("equipment and tears it");
	else output("gear and rips it");
	output(" aside, leaving you bare naked on the warm subterranean stone.");

	output("\n\n<i>“Another impertinent star-walker,”</i> the guard leader grouses, glowering down at you. <i>“Worse than the last, even.”</i>");

	output("\n\n<i>“We should teach... her? Him? Whatever this one is... a lesson,”</i> a second guard says, hooking her thumbs under the chain string of her bikini bottom. With a flick of her wrists, the nyrea drops her panties, letting the forearm-sized shaft of her ovipositor-slash-cock flop free between her legs.");
	output("\n\nYour eyes go wide as the prick-toting babe steps over to you and cups your chin, forcing you to look up and her, and rubs her ovi-cock against your cheek. The first huntress follows her sister’s example, grabbing the other nyrea’s ass playfully as she approaches you. She drops her undergarments and pushes you down onto ");
	if(pc.hasKnees() && !pc.isTaur()) output("your hands and knees");
	else output("the ground");
	output(", moving around behind you and pressing her flared prick to the ring of your [pc.asshole]. Other huntresses gather up, undressing and starting to stroke themselves while the lead pair get ready to spit roast you.");

	output("\n\n<i>“For the queen!”</i> the huntress in front of you whispers, barely audible, before grabbing the back of your head and forcing her cock down your throat. Your eyes bulge, and your body stiffens as your mouth is battered by her feline spines, and the turgid ball of her animalistic knot presses against your lips. Your throat is straining hard around her dick, bulging brutally and throbbing hard enough to make you moan like a bitch in heat.");

	output("\n\nBehind you, the other guard follows her example, pressing her hips forward against your exposed backside. You squeal, desperately trying to resist her anal assault, but ultimately succumbing to her strength: you feel your [pc.asshole] pop open with one final, brutal thrust, and then the nyrea is sliding into you, raking her nubby spines across your anal walls. Your gut bulges in response, straining to take the massive insertion. Around you, the other nyrea cheer and laugh, urging their sisters on with lurid shouts. All you can do is try and bear it, to endure the mix of pleasure and pain as you’re savagely violated.");
	pc.buttChange(foes[0].cockVolume(0));

	output("\n\nThe other huntresses gathered around you close the circle, jacking themselves off and drooling their vibrantly-colored pre all over you. Hands start to grab and grope at you, slapping your [pc.butt] and pinching your [pc.nipples]. A couple of them grab your [pc.hands], forcing you to stroke their ovipositor-cocks while their sisters pound you from front and back. Your eyes roll back, succumbing to pleasure; there’s nothing you can do but try to endure.");

	output("\n\nFor a moment, you think you’re blessed: the two huntresses abusing your mouth and ass cum quickly, splashing your throat and bowels with hot, sticky juices. The ones that are using your hands join them soon, splashing your cheeks and back with long ropes of their strange lubricant. You let out an exhausted sigh as the pair of huntresses pull out of you, letting you flop to the ground in a limp, well-fucked pile... only for another pair to hop in and take their places, letting others grab your hands");
	if(pc.hasCuntTail())
	{
		output(", your tail-cunt");
		if(pc.tailCount > 1) output("s");
		output(", any part of you they can use to get themselves off");
	}
	output(". Your [pc.asshole] is forced open again, and your mouth is soon home to another ovi-cock that mercilessly stretches your throat open.");

	output("\n\nAgain and again, the huntresses take their turns abusing your body, fucking you raw until you’re all but insensate, covered from head to [pc.foot] in their cum and reeking of sex. Every huntress takes her turn with you, some more than once, all jeering and laughing until they’ve had their fill of your helpless body. You lose track of how many times you cum");
	if(pc.hasCock()) output(", painting the ground beneath you [pc.cumColor] with your spunk");
	output(". Finally, the last of the cock-wielding amazons finishes with you, shoving you down onto your belly and into the puddle of spooge that’s formed underneath you.");

	output("\n\n<i>“That’s what you get for challenging the queen,”</i> the lead nyrea growls, stuffing herself back into her armor. <i>“You’re lucky she told us not to harm you offworlders - too much, anyway. You’re no longer welcome here, so take this as a lesson and begone.”</i>");

	output("\n\nThe other huntresses murmur their agreement, and you feel hands grabbing your [pc.legs] and starting to drag you away.");

	//3-4 loads in mouth and similar amount in butt?
	pc.loadInAss(foes[0]);
	pc.loadInAss(foes[0]);
	pc.loadInAss(foes[0]);
	pc.loadInAss(foes[0]);
	pc.loadInMouth(foes[0]);
	pc.loadInMouth(foes[0]);
	pc.loadInMouth(foes[0]);
	pc.loadInMouth(foes[0]);
	processTime(35);
	pc.orgasm();
	pc.orgasm();
	clearMenu();
	currentLocation = "2I11";
	addButton(0,"Next",loseToPraetorianNyreaPt2);
}

//[Next]
public function loseToPraetorianNyreaPt2():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	var lostCreds:int = 0;
	if(pc.credits > 0) 
	{
		if(10 > pc.credits * .2) lostCreds = 10;
		else lostCreds = pc.credits * 0.2;
		if(pc.credits < lostCreds) lostCreds = pc.credits;
	}
	output("You end up getting dumped back in the nyrea village you passed through, not far from the merchant row. The guards give you a few more harsh words and a little more teasing before they go");
	if(lostCreds > 0) output(" - and they even liberate you of " + num2Text(lostCreds) + " credits, too");
	output(". Several commoners look on with wide eyes as you’re dumped off, and the guards return to the palace.");

	output("\n\nYou groan and stagger back to your [pc.footOrFeet], thankful the nyrea left you your equipment. Gonna have to try again if you want to face your cousin and find the probe...\n\n");
	//[Next] //To map
	genericLoss();
}

//PC Victory vs. Praetorian
//Disables Praetorian fight for 12 hours. If PC clears dungeon, never fight them again. Otherwise they recover eventually.
public function spankDaShitOuttaPraetorians():void
{
	clearOutput();
	showName("NYREAN\nGUARDS");
	output("<i>“Enough, enough,”</i> the lead guard says, stumbling to a knee and leaning heavily on her spear. <i>“We yield... no more, please.”</i>");
	output("\n\nThe other nyrea similarly show their submission, throwing down their spears and kneeling - those who can still manage to stand, anyway. You don’t want to risk staying here too long, or the guards might try and jump you: there’s far too many for you to keep an eye on all of them!\n\n");
	flags["PRAETORIAN_RESPAWN"] = 12;
	variableRoomUpdateCheck();
	//Back to map. Praetorian fight can’t occur again for several hours.
	genericVictory();
}


//Palace Interior Descriptions
public function gateExteriorBonusNyreaVillage():Boolean
{
	output("You stand before a large, stone gate. Beyond it, you can hear the sounds of talking, and smell the alluring aroma of cooked meat.");

	//If not open: [Open Gate]
	return taivrasPalaceSquareBonus();
}
//Room 2E11 Gate Interior
public function taivrasGateInteriorBonus():Boolean
{
	output("The interior of the palace gates is a well-lit cavern with a high, vaulted roof and several pillars bearing fungal lanterns. A small guard post is set up just past the gates, a little room hollowed out of the rock and outfitted with a dozen or so chairs.");
	//if KingNyrea: 
	//9999 - maybe disable these if this is where the praetorian fight actually happens?
	if(9999 == 0) output(" Several of your nyrea warriors are milling around here, ready to stave off an enemy attack.");
	//elseif beat Praetorian:
	else if(9999 == 0) output(" The place has been cleared out, thanks to your forceful entrance.");
	return false;
}

//Room 2E13 Palace Thoroughfare
public function palaceThoroughfareBonus():Boolean
{
	output("A long tunnel runs east to west, T-boning north back towards the gates. A painted mural decorates the southern wall, showing ");
	if(flags["MET_TAIVRA"] != undefined) output("Queen Taivra");
	else output("an especially buxom, powerful-looking huntress");
	output(" wielding a spear and driving back a horde of horrible worm-like creatures in a darkened cavern. Several naked, afraid male nrea cling to her plated legs, cowering behind the amazonian warrior woman.");
	return false;
}

//Room 2C13 Queen’s Fountain
public function queensFountainBonusShit():Boolean
{
	output("This large, circular chamber has passages leading north, south, and east, each a squared-off tunnel with a simple silk curtain acting as a door. The center of the room is dominated by a natural fountain: a caldera of stone eroded in a perfect bowl shape in the floor, and filled with water that trickles down from a crack in the cavern’s ceiling.");

	//if PC is NyreaKing, 12 hours have passed since dungeon victory:
	if(9999 == 0) output("\n\nQueensguard, Taivra’s personal bodyguard, is standing here. Her shield is sitting on the ground beside her, and both hands are on the hilt of her sword. She favors you with a slight nod, saying <i>“My " + pc.mf("king","queen") + ",”</i> by way of greeting. It looks like she’s recovered nicely from the fight.");
	return false;
}

//Room 2C15 Queen’s Chambers
public function queensChambersBonus():Boolean
{
	output("You stand in a lavish bedchamber, staring at a more than king-sized canopied bed with lush pink silken sheets and blankets. A rack of simple swords and spears line the walls, none of which are worth your attention. A few pieces of art - sculptures, mostly - adorn the tops of a dresser and nightstand, as does a large fungus-filled lantern that glows with a soft blue light.");
	//Play <i>“Incubator Goo”</i> encounter on first entry.
	if(flags["CRYSTAL_GOO_DEFEAT"] == undefined)
	{
		incubatorGooEncounter();
		return true;
	}
	//if not NyreaKing:
	if(9999 == 9999)
	{
		output("\n\nThe crystal-coated broodmother is ");
		//Lustbeat
		if(flags["CRYSTAL_GOO_DEFEAT"] == 3) output("moaning and groaning in the corner, still locked in the throes of pleasure even after you had your way with her");
		//by physical:
		else output("cowering in the corner, arms and crystal plates wrapped protectively around her belly full of eggs");
		output(".");
	}
	//if NyreaKing & did Goofite:
	else
	{
		if(flags["CRYSTAL_GOO_DEFEAT"] != undefined) output("\n\nYou can see some gooey slop on the stone floor, near the little hatch Taivra’s pet broodmother goo lives in. You suppose she’s been out lately... probably so your mate could pump her full of a new batch of royal eggs.");
		//if NyreaKing & skipped Goofite:
		else output("\n\nYou can see some gooey slop on the stone floor, near one of the big carpets on the stone floor just under a gloryhole in the wall beside her bed.");
	}
	if(flags["LOOTED_TAIVRAS_BEDROOM"] == undefined) addButton(0,"Search",searchTheQueensChambers,undefined,"Search","Maybe you’ll find something useful in the queen’s chambers?");
	else addDisabledButton(0,"Search","Search","You already searched this room, discovering a silver key and sack of gems.");
	
	return false;
}

//[Search]
//Maybe you’ll find something useful in the queen’s chambers?
public function searchTheQueensChambers():void
{
	clearOutput();
	showName("\nSEARCHING...");
	output("You spend a few minutes tossing the room, looking for anything of value. Your search reveals several interesting finds: some sex toys made for the nyrea’s unique biology, some handcuffs and gags, and what looks like primitive pornography etched in stone tablets. Clearly the queen’s got a kinky side...");
	output("\n\nMore important to your quest, though, you find hidden away in her nightstand a <b>silver key</b> and a <b>satchel full of gemstones</b>. These will probably turn quite a profit...");
	output("\n\n(<b>Gained Key Item: Silver Key</b> - This must open something somewhere in the royal complex.)\n\n");
	flags["LOOTED_TAIVRAS_BEDROOM"] = 1;
  	pc.createKeyItem("Silver Key",0,0,0,0);

  	//Add Silver Gate Key to Key Items
	//Add Gem Satchel to inventory. Worth about ~10k Creds when sold.
	//sumbody get on dis
	quickLoot(new GemSatchel());
}



//Room 2C9 Stairway
public function taivrasStairwellBonus():Boolean
{
	output("A curving path connects the rest of the palace grounds to a large set of stairs, leading up to a pair of heavy stone doors flanked by brilliantly glowing blue lanterns. Through the door, you can hear the sounds of pleasure echoing, moans and cries of sexual ecstasy. Several of them, in fact.");
	//if Princess Defeated:
	if (9999 == 9999) output(" You’re surprised the harem is still going, even after freeing them from the queen’s daughter.");
	return false;
}

//Room 2A9 Harem Chamber
public function haremChamberBonusFunc():Boolean
{
	output("The harem chamber is a wide open stone room covered with pillows, cushions, and other comforts for the feminine males kept within it. An all but obscene amount of bondage gear - leather, cuffs, whips, and chains, plus no small number of dildoes and plugs - sit in racks along the walls. Several dozen <i>“male”</i> nyrea - all with plump bosoms, girly figures, and drooling vaginal slits - make up their queen’s harem.");

	//Post Princess battle:
	if(9999 == 0)
	{
		output("\n\nThe harem is currently taking their lusts and aggression out on the nyrean princess. Moans and cries of pleasure echo through the chamber, and the floor is covered with writhing bodies and squirting cum.");
	}
	//PC is KingNyrea:
	if(9999 == 0)
	{
		output("\n\nYour nyrea harem is lounging around on the cushions and couches. They do nothing to conceal their nudity as you observe them - indeed, some actively flaunt it, running their hands over hefty tits or spreading their pussy-lips invitingly. Others are busy with each other, groping and kissing and grinding their unique sexes against each others’ chitinous bodies.");
	}
	//[Use Harem] [Free Them] (see Princess and Harem stuff below)
	//9999 - check for conflicts between king nyrea & post princessbeat stuff
	return false;
}


//Room 2G15 Gateway
public function gatewayBonusFunc():Boolean
{
	output("You’re standing before a huge, imposing steel gate bearing the symbol of the queen: a shield with a spear pierced through it, and what looks like several tentacles wrapped around them both. The gate is currently ");
	if(9999 == 9999) output("sealed, barring your path. You’ll need to find a key to get the big, meaty padlock off of it.");
	else output("standing open, allowing you to enter the queen’s throne room.");
	output(" To your surprise, the gate isn’t guarded.");
	return false;
}

//Room 2E17 Throneroom
public function taivrasThroneBonusFunc():Boolean
{
	if(flags["BEATEN_TAIVRA"] == undefined)
	{
		queenTaivrasThrone(false);
		return true;
	}
	//PC executed Taivra:
	else if(9999 == 0)
	{
		output("Queensguard, despite her wounds, is kneeling over the body of her queen and weeping quietly. As you demanded, she’s gathered the remnants of her soldiers - those who haven’t deserted into the caves - and ordered them to dismantle the queen’s throne from around your father’s probe, ready to deliver the probe outside for a Steele Tech team.");
	}
	//PC spared Taivra:
	else if(9999 == 0)
	{
		output("Queen Taivra is sitting on the edge of her throne’s dias, tending to the wounds her bodyguard suffered at ");
		if(9999 == 9999) output("your hands");
		else output("at Dane’s hands");
		output(". As you demanded, some of her warriors are dismantling her probe-throne, getting ready to dump it out into the village. The queen glowers at you, not in hatred, but in what you would almost call admiration. Clearly your ability to best her has made an impression on the nyrean queen.");
	}
	//PC is KingNyrea:
	else if(9999 == 0)
	{
		//First 12 hours after fight:
		if(9999 == 0)
		{
			output("Your newly-minted mate is sitting on the edge of her throne’s dias, tending to the wounds her bodyguard suffered at ");
			if(9999 == 9999) output("your hands");
			else output("at Dane’s hands");
			output(". As you demanded, some of her warriors are dismantling her probe-throne, getting ready to dump it out into the village. Taivra looks at you with something between fear and admiration, and she keeps her hands well clear of her weapons.");
		}
		//Thereafter
		else 
		{
			output("Queen Taivra is sitting on her throne, one leg crossed over the other and a great spear held in her hand. Her mass of tentacle cocks are busily breeding several beta huntresses, sprawled out on their backs at the foot of her throne with their hollow ovipositors erect and penetrated, being filled with their queen’s seed. Taivra looks almost bored, even with twelve cocks simultaneously fucking a dozen huntresses at once.");
			output("\n\n<i>“[pc.name],”</i> she says with a faint smile, not interrupting her mating. <i>“You desire something, my " + pc.mf("king","queen") + "?”</i>");
		}
	}
	return false;
}

public function showIncuGoo():void
{
	showName("GOO\nINCUBATOR");
	showBust("GOOCUBATOR");
}

//Incubator Goo Encounter
//PC gets ambushed by a crystal goo stuffed with eggs, locked in Taivra's personal sex dungeon.
public function incubatorGooEncounter():void
{
	clearOutput();
	//showIncuGoo();
	output("As you enter the side chamber, you’re greeted by the smell of sweet perfumes wafting off of a dozen colorful candles surrounding a richly adorned bed with silken sheets and a tall canopy. You must have stumbled into the bedroom of the palace’s queen! There’s gotta be some awesome loot in here somewhere, and maybe a hint as to where the locals have stuffed your probe... and what happened with your cousin.");
	output("\n\nYou spend a few moment scouring the room, following the smooth curves of the stone walls with your hand as you poke through the queen’s belongings. The search quickly leads you to a girthy hole chiseled into the wall, clearly artificial in its perfectly circular, smooth shape. It almost looks like a... like a glory hole, set about at crotch height for a nyrean woman.");
	output("\n\nCocking an eyebrow, you ");
	if(pc.tallness >= 60) output("squat down to look into");
	else output("look straight into");
	output(" the hole. It’s about two inches of solid stone, leading up to a solid green surface beyond it. At least, it looks solid at first glance, but as you stare at it, the green ripples like gelatin, catching the light in just the right way to make it glisten radiantly.");
	output("\n\n<i>“Helloooo...?”</i> an almost girlish voice says from the other side of the hole between jiggles of the strange green substance. <i>“You just gonna, like, keep me waiting aaaall day?”</i>");
	output("\n\nWell, are you?");
	processTime(2);
	//[Use Gloryhole] [Step Back]
	clearMenu();
	if(pc.hasCock())
	{
		addButton(0,"Use G.Hole",useDatGloryhole,undefined,"Use Gloryhole","Well, that’s what it’s there for, right? Stick your dick right into the gloryhole and see what’s in store.");
		addButton(1,"Step Back",stepBackFromGloryHoles,undefined,"Step Back","No way you’re sticking your dick in there. Who knows what’s on the other side?");
	}
	else
	{
		addDisabledButton(0,"Use G.Hole","Use Gloryhole","You don't have the equipment to do that.");
		addButton(1,"Step Back",stepBackFromGloryHoles,undefined,"Step Back","You don’t exactly have the right equipment to slot in there...");
		addDisabledButton(1,"Step Back","Step Back","");
	}
}

//[Step Back]
//if dick: No way you’re sticking your dick in there. Who knows what’s on the other side?
//Else: You don’t exactly have the right equipment to slot in there...
public function stepBackFromGloryHoles():void
{
	clearOutput();
	showIncuGoo();
	output("You take a wary step back, worried about what exactly you’ve just woken up. A moment later, you hear a wet slurping noise from through the alien gloryhole, and the feminine voice inside calls out <i>“Queenie, don’t tease me like that! C’mon already!”</i>");
	output("\n\nYou don’t exactly know how to respond to that, and in the couple of moments you spend flubbing for some response that will keep the creature placated, you hear something clicking behind the stone. You manage to scramble back just in time to avoid falling in as a trap door pops open from underneath a shaggy rug, and a glistening green figure pulls herself up from below.");
	output("\n\n");
	//if seen a Crystalgu b4:
	if(9999 == 0) output("You instantly recognize the familiar form of a ganrael, the planet’s crystal-hemmed goo race, but something’s very different about this specimen. ");
	else 
	{
		output("It’s a green goo-girl, just like Celise, but covered with bits of glistening crystal. Your Codex beeps, identifying it as a gan’rael, a myrellion native species. ");
		//CODEX UNLOCK!
	}
	output("She’s adopted a relatively humanoid form, probably based off of a gooey interpretation of the nyrea she’s living besides: she’s got two arms, a human-like head with big elfin ears, and a curvaceous body with big tits and hips that fold down into a solid base of goo instead of legs. Her crystals, though, are what tip you off to what you’re really dealing with here: a thick dome of emerald crystal has formed around her belly, shielding a massively pregnant gut filled to the brim with what looks like hundreds of fist-sized eggs! Her middle is hugely bloated, swollen with eggs and plated with as much crystal as the goo could possibly churn out, protecting her charges rather than herself.");

	output("\n\n<i>“You’re not the queen!”</i> she yelps, her purple eyes going wide with surprise. The goo’s arms go protectively around her crystal-armored belly, and you’re left to watch her slimy body jiggle, and all the countless eggs inside her shift listlessly in their gemstone shell. <i>“I-I won’t let you hurt my precious eggs!”</i>");

	output("\n\nUh-oh. You wave your hands, saying that ");
	if(pc.isAss()) output("if you’d wanted to hurt her, you’d have done so already");
	else output("you don’t want to hurt her");
	output(", but the goo’s eyes have already glazed over with protective rage - looks like you’ll have to knock her down!");

	processTime(5);
	clearMenu();
	addButton(0,"Next",startCombat,"Goocubator");
}

//[Use Gloryhole]
//Well, that’s what it’s there for, right? Stick your dick right into the gloryhole and see what’s in store.
public function useDatGloryhole():void
{
	clearOutput();
	showIncuGoo();
	flags["CRYSTAL_GOO_GLORYHOLED"] = 1;
	output("You shrug and ");
	if(pc.isCrotchGarbed()) output("drop trou and grab [pc.oneCock]");
	else 
	{
		output("grab ");
		if(pc.cockTotal() > 1) output("one of ");
		output("your unclad cock");
		if(pc.cockTotal() > 1) output("s");
	}
	output(". Whatever’s on the other side seems eager to do her duty behind the gloryhole, and you’re all too happy to enable it. With a few preparatory stokes, you bring your [pc.cock] up to full size and ");
	if(pc.tallness <= 50) output("grab the pillows off of the bed, giving yourself enough height to just barely get your wang into the head-height hole");
	//if normal size:
	else if(pc.tallness <= 76) output("guide your schlong into the waiting hole");
	//if bigPC:
	else
	{
		output("slip down ");
		if(pc.hasKnees()) output("onto your knees");
		else if(pc.isNaga()) output("into a serpentine coil");
		else output("as low as you can go");
		output(" to align your prick with the hole, and slide on in");
	}
	output(".");

	output("\n\nThe stone is cold, but it’s smooth and wet, the remnants of what could be years of sexual excess and lube smeared across the tunnel. You only need to endure the rocky gloryhole for a moment, though, before your [pc.cock] slides into the green substance waiting on the other side. Whatever it is, it’s delightfully warm and stickily wet, just like ");
	if(celiseIsCrew()) output("fucking Celise");
	else output("sliding your tool into a bowl of heated-up yoghurt");
	output(". The voice on the other side makes a delighted squeal, and you’re treated to a faint sucking sensation around your member, like the substance is drawing you in.");

	output("\n\nIs that a goo-girl on the other side? It has to be, you tell yourself");
	//if seen a Crystalgu b4:
	if(9999 == 0) output(" - probably a ganrael in the queen’s service");
	output(". The way the semi-liquid slurps and squeezes, sucks and caresses your cockflesh is amazing, better than any mouth or sex toy could ever be. An irrepressible grin spreads across your face as you sink every inch of your [pc.cock] into the gooey sheath on the other side of the hole, surrounding your manhood in a constant cavalcade of pleasures.");
	pc.cockChange();
	output("\n\n<i>“Wow, this feels totally different!”</i> the voice on the other side giggles, quivering wonderfully around your dick. <i>“Did you, like, get a whole new cock? Just for me, right?”</i>");
	output("\n\nShe still thinks you’re somebody else - the queen, you suppose! You try not to laugh as the goo-girl squirms excitedly around your prick, exploring every inch of her <i>“queen”</i>’s new shaft. All you need to is hang on, grabbing at the smooth stone walls to steady yourself as pleasure hammers through you, making your [pc.legOrLegs] tremble. This nyrean queen is clearly leading the good life if she’s got every day access to treatment like this!");
	output("\n\nYour [pc.hips] start to move, thrusting into the gooey clocksleeve on the other side of the gloryhole. The green girl coos happily, making a series of lusty moans to the rhythm of your pumping thrusts. <i>“Oooh, so gentle today!”</i> she murmurs, barely audible over the wet squelches of her body slurping up your cockflesh. <i>“Mmm, I bet you’ve got soooo many eggs for me today...”</i>");
	output("\n\nEggs? Well, it looks like your cover’s going to get blown about the same time as your nut. And the way she’s handling you, that’s going to be damn soon! You grit your teeth and try and hold back as long as you can against her slimy caresses, but this gloryhole goo is a supremely talented cocksucker who’s using her whole body to pleasure your [pc.cock]. You’d love to get a look at her blissed-out face about now, but have to content yourself with listening to her sultry, wet sounds echoing through the little tunnel.");
	output("\n\nA few minutes of the goo-girl’s tender caresses later, and you’re ready to blow - and she knows it! <i>“Gonna fill me with eggs now?”</i> she coos excitedly, wiggling wetly all over your length. <i>“C’mon, queenie, I’m practically empty!”</i>");

	output("\n\nWell, you can’t fill her up with cock-eggs, but you’ve got something else to fill her up with! You grunt and dig your fingers into the stone wall, announcing your impending orgasm with a feral growl of pleasure. The goo squeals as the first spurt of your [pc.cum] squirts into her, ");
	if(pc.cumQ() < 40) output("though her voice breaks into a cry of surprise as she realizes the cloud of [pc.cumColor] floating in her green belly isn’t exactly a clutch of nyrean eggs!");
	else if(pc.cumQ() <= 550) output("bloating her gooey body with a massive dose of [pc.cum]! She moans happily, jiggling up and down your shaft as you pump her full of cum. A normal girl would be drooling your spunk out around your cock, but a goo... she just drinks it all up!");
	//if hugecum: 
	else output("and again and again until the goo must be absolutely bloated with spooge - and you keep on going! She yelps and squirms around as you pump her with cum, enough to have made a normal girl look pregnant; as a goo, though, you imagine she’s just swelling up with all the extra fluid!");

	output("\n\nWith a heavy sigh, you step back from the gloryhole and drag your [pc.cock] out from the goo-girl’s insides in a wet, musky mess of goop and cum. It’s hard to resist the urge to crawl into the nearby bed and nap off the afterglow, but you’ve got a job to do. You gather your gear and get ready to go, but stop as you hear the goo-girl’s voice from inside the gloryhole, complaining loudly about the <i>“weird gunk”</i> inside her, and the distinct lack of eggs your orgasm filled her with. A moment later, one of the shaggy rugs in the queen’s chamber gets tossed aside as a trap door slams open, and the goo-girl hauls herself out.");

	output("\n\n");
	//if seen a Crystalgu b4:
	if(9999 == 0) output("You instantly recognize the familiar form of a ganrael, the planet’s crystal-hemmed goo race, but something’s very different about this specimen.");
	//else
	else output("It’s a green goo-girl, just like Celise, as you expected. Unlike your dad’s favorite pet, though, this one’s  covered with bits of glistening crystal. Your Codex beeps, identifying it as a gan’rael, a myrellion native species.");
	output(" She’s adopted a relatively humanoid form, probably based off of a gooey interpretation of the nyrea she’s living besides: she’s got two arms, a human-like head with big elfin ears, and a curvaceous body with big tits and hips that fold down into a solid base of goo instead of legs. Her crystals, though, are what tip you off to what you’re really dealing with here: a thick dome of emerald crystal has formed around her belly, shielding a massively pregnant gut filled to the brim with what looks like hundreds of fist-sized eggs! Her middle is hugely bloated, swollen with eggs and plated with as much crystal as the goo could possibly churn out, protecting her charges rather than herself. Beneath the gemstone shield, though, you see a ");
	if(pc.cumQ() < 40) output("small");
	else if(pc.cumQ() <= 550) output("big");
	else output("huge");
	output(" cloud of [pc.cumColor] swirling around inside her, coating the eggs as her goo wiggles around.");

	output("\n\n<i>“You’re not the queen!”</i> she yelps, her purple eyes going wide with surprise. The goo’s arms go protectively around her crystal-armored belly, and you’re left to watch her slimy body jiggle, and all the countless eggs inside her shift listlessly in their gemstone shell. <i>“Nobody’s allowed to use the queen’s goo but Taivra!”</i>");

	output("\n\nUh-oh. You wave your hands, saying that you didn’t mean any harm - she asked you to fuck her! But the goo’s eyes have already glazed over with protective rage - looks like you’ll have to knock her down!");

	processTime(20);
	pc.orgasm();
	clearMenu();
	addButton(0,"Next",startCombat,"Goocubator");
}

//Goo Incubator Fite
//Crystal Goo is a primarily lust-based fight, though if the PC Gloryholed her, she’ll start with 0 Lust (like the PC will!). Like Celise, she’s highly resistant to physical damage (though not immune) but very vulnerable to Lust.
//Rather than a HEALTH bar, she has an ARMOR bar: the battle ends if the PC can break her crystal shield. Crystal goo is, of course, fairly MIRRORED. She’s probably the weakest fight in the dungeon, maybe just Level 7.

//Fight Text
//You’re fighting a Crystal Goo Incubator!

//The crystal-armored goo-girl in front of you is a mass of green slime in the vague form of a nyrean woman, with oversized hips and a huge pair of glistening breasts that bounce around with every movement. Her body is covered with small flecks and plates of natural emerald crystal, but unlike most of her race, the vast majority of her crystal is concentrated around her hugely swollen belly, forming a perfect, smooth dome. Underneath the protective shell of crystal are what must be hundreds of white, fist-sized eggs, floating listlessly in their gooey womb. {A misty cloud of [pc.cumColor] billows around the eggs, clinging to several of the outliers. If they weren’t fertilized already, then you’ve certainly (got a few new kids on the way // fixed that for most of them // inseminated every egg in that goo’s belly with your god-like load of cum)}. The gooey incubator looks at you with wild eyes, her arms clutching her eggy belly protectively. Looks like this artificial momma will do anything to protect her clutch!

//Goo Abilities
public function gooCubatorAI():void
{
	if(!pc.hasStatusEffect("Grappled"))
	{
		if(foes[0].HP() < 150 && !foes[0].hasStatusEffect("Goo Shield")) crystalShieldGoo();
		else if(!pc.hasStatusEffect("Blind") && rand(6) == 0) gooSpitShit();
		else if(rand(7) == 0) gooeyGrappleStuff();
		else if(rand(4) == 0) bellyTeaseGOOO();
		else if(rand(3) == 0) gooeyTentagrope();
		else gooTendrilSlap();
	}
	else keepOnGropinOn();
}

//Goo Tendril Slap
//Moderate bludgeoning attack
public function gooTendrilSlap():void
{
	output("The goo-girl gives a shrill warcry and lunges at you, a thick tendril of goo forming from her shoulder and lashing at you.");
	if(combatMiss(foes[0],pc)) output("\nYou manage to block the attack, deflecting the swing away.");
	else
	{
		output("\nThe egg-laden woman catches you off-guard and smashes her gooey tentacle into your chest! The force of the blow leaves you reeling, and covered in wet slime.");
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
	}
	processCombat();
}

//Goo Slpit
//Blinding attack. Only works if Shields are down.
public function gooSpitShit():void
{
	output("The gooey incubator swings one of her arms at you, as fast as her heavily laden body will let her. Rather than strike at you directly, though, a clump of goop flings off of her body and hurtles towards you!");
	if(pc.shields() > 0) output("\nThe goo splatters on your shields, drooling down to the ground like a bug caught on a windshield.");
	else if(rangedCombatMiss(foes[0],pc)) output("\nThe goo splatters harmlessly on your chest. What was the point of that!?");
	else
	{
		output("\nThe gooey blob beans you right in the face! You yelp in surprise as the warm slime splatters across your face, bathing everything in a weird green light - <b>you’re blinded by the goo</b>!");
		pc.createStatusEffect("Blind",rand(3)+1,0,0,0,false,"Blind","You're blinded and cannot see! Accuracy is reduced, and ranged attacks are far more likely to miss.",true,0);
	}
	processCombat();
}

//Belly Tease
//Lust attack. Way higher effect vs. PCs with cocks + high Virility
public function bellyTeaseGOOO():void
{
	output("Your opponent bounces around you, moving with inhuman twists and turns that would break a creature with bones. But for her, it seems like she’s flowing around her crystal-clad belly, deforming and reforming every few moments in a myriad of ways that emphasize her hugely pregnant stomach. A pair of gooey arms wrap around it, fingers tracing over the perfectly smooth gemstone as her pseudo-hips thrust out beneath it.");
	//If PC saves...
	if(pc.willpower()/2 + rand(20) + 1 >= 18)
	{
		output("\nIs that supposed to turn you on?");
	}
	else if(!pc.hasCock())
	{
		output("\nYou find the alien display disquietingly erotic, an invitation to join with the gooey incubator and share in the joys of egg-swelling motherhood...");
		applyDamage(new TypeCollection( { tease: 13 } ), foes[0], pc, "minimal");
	}
	//if cock + success:
	else {
		output("\nThe alien dance is alluring in the best of ways, inviting you to cover over and slide your cock ");
		if(flags["CRYSTAL_GOO_GLORYHOLED"] == 1) output("back ");
		output("into her gooey nethers and fertilize her massive store of nyrean eggs. Hundreds of them are floating inside her, begging for a cock to seed them. It’s hard to resist the urge to give her what she wants....");
		applyDamage(new TypeCollection( { tease: 16 } ), foes[0], pc, "minimal");
	}
	processCombat();
}

//Gooey Tentacles
//Several light lust attacks. Gropegropegrope.
public function gooeyTentagrope():void
{
	output("The goo-girl reaches out with one of her arms, which breaks apart as it moves, becoming a dozen small, slender tendrils of viridian slime. You stumble back, but the goo’s reach seems unlimited, and she’s quickly rubbing her tentacles all over you, groping at your [pc.crotch], and smearing your [pc.chest] with slimey caresses.");
	for(var x:int = 0; x < 4; x++)
	{
		if(pc.willpower()/2 + rand(20) + 1 >= 21) output("\nSomehow, you manage to grit your teeth and ignore her inhuman advances!");
		else 
		{
			output("\nThe alien attention leaves your cheeks burning, and your whole body flushing with arousal. The things you could do to a gooey beauty like this...");
			applyDamage(new TypeCollection( { tease: 4 } ), foes[0], pc, "minimal");	
		}
	}
	processCombat();
}

//Partial Envelop
//Goo wraps around PC, grappling them. If it lasts for 3 turns, the goo cums and loses a lot of lust.
public function gooeyGrappleStuff():void
{
	output("<i>“Don’t fight me!”</i> the goo purrs, sliding towards you on her thick, legless lower body. Her belly bounces as she moves, hundreds of eggs gently rattling against the perfect crystal dome her arms are shielding. <i>“The queen will be SO MAD if you hurt her eggs... so why not, like, just stop already? I’ll let you play with me if you do...”</i> she offers, a seductive smile spreading on her emerald lips.");
	output("\n\nBefore you can answer, the goo lunges forward, sliding past your defenses and splattering her lower body around your [pc.legs], molding her goop around you! Her arms slip around you, trying to completely pull you into her! ");
	if(pc.reflexes()/2 + rand(20) + 1 >= foes[0].physique()/2 + 13)
	{
		output("\n\nYou push her back, forcing the goo-girl to give you some much-needed distance. She pouts, crossing her arms. <i>“You’re gonna regret this!”</i>");
	}
	else
	{
		output("\n\nYou try to push her back, but can’t find proper purchase! Before long, almost your entire body has been smothered in emerald slime - all that’s left is the crystal ball of the girl’s distended gut pressing against your [pc.belly], and her face just inches from yours. Her slime squirms and presses all around you, rubbing at your groin and ass and chest in all the right ways, with no sign of letting up! <b>You’re grappled!</b>");
		applyDamage(new TypeCollection( { tease: 5 } ), foes[0], pc, "minimal");
		foes[0].lust(3);
		pc.createStatusEffect("Grappled",0,35,0,0,false,"Constrict","You're pinned in a grapple.",true,0);
	}
	processCombat();
}

//Continue Enveloping if PC doesn’t escape:
public function keepOnGropinOn():void
{
	if(pc.statusEffectv4("Grappled") >= 3)
	{
		didntEscapeFromGooInThreeTurns();
		return;
	}
	output("The goo girl is firmly affixed to you, rubbing her crystal belly against you like some sort of alien dry hump while the rest of her gooey body gropes at you, ");
	if(pc.biggestTitSize() >= 1) output("squeezing your [pc.chest] and ");
	output("slipping tendrils of goo around your crotch.");

	output("\n\n<i>“This is soooo much better!”</i> she giggles, her voice fading into an unintelligible moan. She’s getting off on this - and she’s doing everything she can to make sure you do, too.");

	if(pc.willpower()/2 + rand(20) + 1 >= 21) output("\nYou struggle as hard as you can, refusing to give in to your carnal desires!");
	else
	{
		applyDamage(new TypeCollection( { tease: 5 } ), foes[0], pc, "minimal");
		output("\nAnd it’s working! Pleasure rushes through you, making you pant and gasp as the gooey vixen massages your entire body.");
	}
	foes[0].lust(3);
	//Stick rounds in #4
	pc.addStatusValue("Grappled",4,1);
	processCombat();
}

//PC Doesn’t Escape for 3 turns
public function didntEscapeFromGooInThreeTurns():void
{
	output("Your attempts at escape seem completely useless, and your struggles only prove to excite the amorous goo-girl further. The more your limbs squirm in her sticky embrace, the louder her lusty moans become, and the more you see her bloated belly sway ponderously against your gut, rolling her huge clutch of eggs around. The feeling of all those eggs moving inside her must be maddeningly pleasurable, as her slimy exterior spurts moisture all over you [pc.chest].");
	output("\n\n<i>“Gonna... gonna...”</i> she mewls, rubbing faster against you. <i>“Gonna...!”</i>");
	output("\n\nShe can’t quite find the words to give voice to her ecstasy, and ends up settling on a high-pitched scream that reverberates off the stone walls. Her goo releases you, letting you tumble to the ground as she climaxes herself into a gooey, incoherent mess. Your eyes are drawn to the crystal dome around her belly, shielding her hundreds of pearly eggs from the rest of her body’s near-collapse into a formless pile of slime. The gemstone orb rolls around like a punted beachball on a bed of lube.");
	output("\n\nShe only stays that way for a moment, though, before she reforms herself into a familiar form, hefting up her crystal belly and protectively shielding it back in her gut. <i>“Aww, you didn’t cum?”</i> she whines, looking horribly disappointed. <i>“Guess I’ll have to, like, try harder!”</i>");
	foes[0].orgasm();
	applyDamage(new TypeCollection( { tease: 5 } ), foes[0], pc, "minimal");
	pc.removeStatusEffect("Grappled");
	processCombat();
}

//Crystal Shield
//Buffs physical defense for a few turns. Only used when at low HP
public function crystalShieldGoo():void
{
	output("<i>“Oooww, you’re hurting me!?”</i> the goo whines, more in surprise than pain, it seems. <i>“Don’t you dare hurt my eggs!”</i>");
	output("\n\nThe look of bubbly determination that she’s been sporting twists into a grimace of concentration. A few moments later, the various small flecks of crystal floating around her body start to move through her, coalescing around one of her arms. They become a crystelline buckler, held together by a viscous layer of goo. <i>“Never gonna get through this!”</i> she declares with a shake of her hips.");
	foes[0].createStatusEffect("Goo Shield",0,0,0,0,false,"Icon_DefUp","With her crystal shield, the goo will be much tougher to drop through violent means!",true,0);
	foes[0].armor.defense += 20;
	foes[0].armor.hasRandomProperties = true;
	processCombat();
}

//PC Defeated by Guu: Absorbed and Incubated
public function loseToRoyalIncuGoo():void
{
	//Bad end! PC gets turned into an extra incubator so goobutt can have EVEN MORE EGGS. Also fucked forever and ever by wriggling goo.
	//if by lust:
	if(pc.lust() >= pc.lustMax())
	{
		output("The goo’s rubbing and teasing you is simply too much - you have to have a piece of this viridian vixen! You drop your [pc.weapon], letting it clatter to the floor as you stagger towars the gooey beauty.");
	}
	//if by physical:
	else output("Even as hesitant a warrior as she is, the goo is simply too much for you! You slump against one of the walls, your [pc.weapon] clattering to the ground beside you as you surrender to the pain the gooey bombshell’s caused you.");

	output("\n\n<i>“Ahh! Yay, I win!”</i> she cheers, bouncing around excitedly. <i>“That means you belong to me now, right? That’s what Queen Taivra said, like, forever ago when she made me her personal egg bitch. Hehe, I used to be big and tough, too, but look at me now!”</i>");
	output("\n\nShe beams at you, rubbing her hands all around the crystal sphere suspended in her gooey gut. <i>“I’m the best egg bitch in the whole wide world, Taivra said. She’ll be so proud of me for catching you... I bet she’ll give me a hundred more eggs - a thousand!”</i>");
	output("\n\nThe idea of being stuffed with even more eggs seems to make the victorious goo absolutely giddy. She bounces with excitement, making her egg-laden belly tumble weightlessly inside her goo until she suddenly turns her attentions to you, a huge grin plastered on her face. <i>“Do you like eggs? I hope so, cuz Queen Taivra likes to stuff all of her pets with her eggs. She makes soooo many! But now </i>I<i> have a pet... and I can stuff you with eggs, just like Taivra! No wait, that I wouldn’t have as many.... uh, I know!”</i> she grins, bouncing your way and looming over you. <i>“I’ll use you to help keep all of my eggs warm! You can make me nice and thick and perfect for all my eggs to get big and strong in.”</i>");

	output("\n\nYou gulp nervously as the goo-girl leans in close, her cute little nose almost brushing up against you. She just stares at you for a long moment, long enough to make you wonder if she’s really looking at you... until you see the gooey tendrils starting to grow out of her back, reaching towards you. You’re powerless to resist as the tentacles wrap around your limbs, pulling you up towards the goo-girl’s slimy embrace with startling strength. Emerald goo surges around you, spreading out across your body in a slow tidal wave of hot, wet alien sludge. She envelopes more and more of you, grasping at all of your exposed flesh until your face is pressing against hers, and her crystal-clad belly is grinding against your ");
	if(!(pc.armor is EmptySlot)) output("[pc.armor].");
	else output("[pc.skinFurScales].");

	output("\n\n<i>“Just relax and let me swallow you up!”</i> she giggles, pressing green goop to your face. The stuff blinds you for a moment, before your vision coalesces into one of a viridian sheen, like looking at the world through a sloshing pair of green beer goggles. You’re sure every inch of you is inside the giddy goo-girl, and as you weakly struggle, you find yourself incapable of breaking free. You can move your limbs freely, but the goo just moves with you, perfectly melding to your body shape. You start to scream, but opening your mouth to the goo proves a mistake - she floods your mouth with herself, forming a thick, wriggling appendage for you to suck on. You instinctively know what the goo-girl wants, and your tongue flicks across the morphing shaft keeping your jaw wide open.");

	output("\n\nMore goo floods under your equipment, ripping it off of you with startling dexterity. You’re quickly left naked, surrounded by discarded possessions, with goo teasing at the rim of your [pc.asshole]");
	if(pc.hasVagina()) output(" and the lips of your [pc.vaginas]");
	output(". There’s no resisting her, now - no point in trying to hold on to your dignity anymore. All you can do is moan as the goo-girl invades your body from both sides, filling every hole she can find with thrusting probes of green goop. The sensation is instantly overwhelming, making you screech into your mouthfull of your viridian mistress.");

	output("\n\n<i>“Hehe, you feel so good inside!”</i> the goo coos, jiggling inside you. <i>“Mmm, I’m gonna keep you forever and ever!”</i>");

	output("\n\nThe goo shifts around you, binding your arms to your side like a wrestler’s grapple. You squirm helplessly, but your movements are so restricted - and your body so wracked with unwanted pleasures - that you only serve to get the giggling goo-girl off! She moans and gropes at the vague outline of her tits, slowly sliding across the chamber’s floor towards the trap door she spring out of when you first saw her.");

	output("\n\nIn the blink of an eye, you’re squeezed through a tunnel in the floor and into a cramped, dark chamber behind the queen’s walls. Nobody will hear your screams here, muffled in the goo with only the gloryhole to shine a flicker of light into your world. Hundreds of eggs press against you, nestling between your warmth and the solid embrace of stone.");

	output("\n\n<i>“Welcome home,”</i> the goo purrs from all around you. <i>“I bet the queen will be here to fill me full of my daily eggs soon. If you’re lucky... and make me cum a bunch first... I might let some of her precious eggs slip into you, too!”</i>");

	output("\n\nSomething tells you that no matter what you do, you’re going to spend the rest of your life being pumped full of the nyrean queen’s many, many eggs...");
	badEnd();
}

//PC Beats Guu
public function pcBeatsGoo():void
{
	clearOutput();
	if(foes[0].HP() <= 0) 
	{
		flags["CRYSTAL_GOO_DEFEAT"] = 1;
		output("<i>“Don’t hurt my eggs!”</i> the goo shrieks, curling into an almost literal ball around the crystal orb she’s formed around her belly. <i>“I-I won’t let you!”</i>");
		output("\n\nYou sigh and try to explain again that you didn’t come here to hurt her damn eggs");
		if(flags["CRYSTAL_GOO_GLORYHOLED"] == 1) output(" - if you had, you wouldn’t have pumped her full of cum first");
		output("! She still scrambles backwards as you approach her, leaving a trail of emerald slime on the floor that nearly makes you trip over yourself. She’s certainly a sloppy little creature... and one entirely at your mercy, now. Maybe you could assuage the poor thing’s fears in a way she’d really understand...");
	}
	//By Lust
	else
	{
		flags["CRYSTAL_GOO_DEFEAT"] = 2;
		output("<i>“Nooooo!”</i> the goo whines, wiggling and jiggling her exaggerated figure hypnotically. <i>“O-only the queen’s allowed to have me!");
		if(flags["CRYSTAL_GOO_GLORYHOLED"] == 1) output(" You already filled me with all this creamy stuff!");
		output("”</i>");
		output("\n\nFor a lusty goo-girl like her, she’s put up an awful lot of resistance to your advances. She must really love her queen... or at least, love getting pumped full of so many eggs she can barely move. You’ll just have to show her what you can do...");
		output("\n\nThe goo slumps against the wall, desperately running her hands around her belly and pumping her fingers into her own goo. She looks pleadingly at you, whining and moaning and squirming everywhere - poor thing’s so aroused, and where’s her queen to help her. She seems to know there’s nobody else to help her, and so her big purple eyes settle on you.");
	}
	output("\n\n<i>“P-please...”</i> she whines, squirming around helplessly around her crystal-clad belly.");
	output("\n\nWhat do you do?\n\n");
	clearMenu();
	//[Fuck Her] [Get Egged] [Leave]
	if(pc.lust() >= 33)
	{
		if(pc.hasCock()) addButton(0,"Fuck Her",pcFuckDatGooWivCockVictory,undefined,"Fuck Her","The goo-girl’s entire body might as well be a huge pussy, ready to be fucked anywhere you like. Shove your cock{s} right on in and fill her with cum!");
		else addDisabledButton(0,"Fuck Her","Fuck Her","You need a cock to jam one inside of her.");
		if(pc.hasGenitals()) 
		{
			if(pc.findEmptyPregnancySlot(0) == -1) addDisabledButton(1,"Get Egged","Get Egged","You don't have any room for eggs.");
			else addButton(1,"Get Egged",getEggedByCrystalGoo,undefined,"Get Egged","You can only imagine how amazing it would feel to have the bubbly bimbo goo-girl pump you full of her eggs.");
		}
		else addDisabledButton(1,"Get Egged","Get Egged","You need genitals for this act.");
	}
	else
	{
		addDisabledButton(0,"Fuck Her","Fuck Her","You aren't aroused enough to even consider this.");
		addDisabledButton(1,"Get Egged","Get Egged","You aren't aroused enough to even consider this.");
	}
	if(pc.armor is GooArmor || pc.destroyItemByName("Goo Armor",1)) addButton(14,"Leave",armorGooVictoryShits);
	else addButton(14,"Leave",genericVictory);
}

//Fuck Her
//PC must have a cock.
//Tooltip: The goo-girl’s entire body might as well be a huge pussy, ready to be fucked anywhere you like. Shove your cock{s} right on in and fill her with cum!
public function pcFuckDatGooWivCockVictory():void
{
	clearOutput();
	flags["CRYSTAL_GOO_DEFEAT"] = 3;
	output("With the goo-girl lying in a defeated, jiggling heap on the ground, completely at your mercy... your mind starts to wander. How could you take advantage of this wriggling heap of a broodmare? As you think over the many, many options her alien body presents, you start to peel off your [pc.gear]. The goo’s big, purple eyes roll towards you, looking up from her cowering. Her arms are still wrapped protectively around her crystal belly, but you see her gaze settle on your [pc.cockBiggest] with a look of abject hunger in her eyes. Looks like ");
	if(flags["CRYSTAL_GOO_GLORYHOLED"] != 1) output("she wants what you’re packing, even if her queen might take offense");
	else output("she enjoyed round one. Now to see if she’s ready for round two...");

	output("\n\nGiving her a lascivious grin, you sashay over to the cowering goo. As you move, your hand wraps around your ");
	if(pc.cockTotal() == 1) output("[pc.cockBiggest]");
	else output("biggest cock");
	output(", showing off what you’re packing to the sex-addled goo. She’s shameless about her approval, licking her lips and groping at one of her huge boobs. Her whole body quakes excitedly when you stop just inches from her, though her arms stay firmly where they were. Even as lustful as she is, the poor thing’s not willing to risk her hundreds of delicate charges. Admirable, in its alien way.");

	output("\n\nSquatting down in front of her, you run a hand across the slimy surface of the ganrael’s body, brushing your fingertips across her beachball bosom... before you sink them into her porous body. The goo-girl squeals as your fingers push into her tit, arching her back in a universal sign of pleasure. Oh, she’s <i>sensitive</i>! You wiggle your fingers, basking in her moans and cries: she’s just like one big, body-wide clit, ripe for you to play with. With a grin, your other hand comes into play, pushing slowly between the gooey babe’s faintly-outlined thighs, as near as you can tell to where a flesh-and-blood girl’s pussy would be.");

	pc.cockChange();

	output("\n\n<i>“Stop teasing meeee,”</i> the goo manages to whine between throaty moans. One of her arms finally shoots off of her precious cargo-crystal, grabbing your [pc.cockBiggest] and trying to pull you into her. You give her what she wants, rocking your [pc.hips] forward into the blob of her lower body, right beneath the bulb of her crystal belly. ");
	if(pc.cockTotal() > 2) output("All of your cocks slide");
	else if(pc.cockTotal() > 1) output("Both of your cocks slide");
	else output("Your cock slides");
	output(" right into her, easily spreading out her gooey exterior and gliding into a bed of hot, wet warmth. Damn, she’s hot! Hot enough to make you wince, but the way she sucks you into her gooey interior more than makes up for the momentary discomfort. Fucking her is like fucking ");
	if(pc.cockTotal() == 1) output("a");
	else output(num2Text(pc.cockTotal()));
	output(" onahole");
	if(pc.cockTotal() > 1) output("s");
	output(" filled with steaming-hot gel, perfectly melding to your cock");
	if(pc.cockTotal() > 1) output("s");
	output(" and making the wettest squelching noises as you start to thrust.");

	output("\n\n<i>“That’s better,”</i> you hear her moan, just loud enough to hear. <i>“You’re gonna give me lots of eggs, right?”</i>");

	output("\n\nYou chuckle, grabbing her tits and thrusting ");
	if(pc.balls > 1) output("balls ");
	output("deep. You can’t exactly pump her full of eggs this way, but damned if you can’t make sure every last one of hers is nice and fertilized! If she gets this much pleasure just from having all those eggs in her, you can’t imagine how much she’ll get off from giving birth! Just your fingers wriggling around inside her tits seemed like enough to make her a fuck-hungry mess - what would a hundred eggs popping out of her do?");

	output("\n\nYou suppose you won’t get to see that, but for now, you can focus on making sure she cums her brains out the old fashioned way! Your hips do the talking, thrusting hard and fast into her quivering body. She rocks back with every thrust, bouncing around like mad and desperately holding onto her crystal-clad belly. The eggs inside her roll around with the impacts, which only adds to her pleasure. Her screams echo deafeningly off the stark stone walls, surrounding you in a cacophony of sultry noises. It sounds more like you’re in a brothel than a royal palace, all thanks to the over-sexed goo - and your own grunts as her alien body starts to drive you towards climax.");

	output("\n\nNo way you’re letting her get the better of you, though: you’re gonna make her cum first, dammit! You’d think ");
	if(pc.cockTotal() == 1) output("a hard dick");
	else output(num2Text(pc.cockTotal()) + " hard dicks");
	output(" spearing her again and again would be enough, but this busty slut’s been through more than you can imagine. You’ll have to pull out every stop to bring her to the heights of pleasure. Luckily, her being nothing more than a pile of goo and crystal gives you plenty of options...");
	output("\n\nYou move your hands from her tits, keeping all your fingers buried to the knuckle in goo and tracing lines down her body until you reach the crystal barrier protecting her gravid belly. She shrieks when you touch the crystal armor’s inside, whether in pleasure or surprise you can’t tell. Either way, she doesn’t - or can’t - stop you as your hands reach deep inside her, teasing out inch after inch of sensitive goo around the smooth ball of crystal. The area around her gemstone armor seems ten times more tender than the rest of her, and the more you run your fingers across it, the higher the pitch her screams reach.");
	output("\n\nHer pleasure spurs you on, making you fuck your [pc.cocks] deeper and higher inside her, tracing your way through your captive lover’s body until your [pc.cockBiggest] is battering the bottom of her crystal belly. The stone is wonderfully smooth, and even hotter than the rest of her, a burning sphere of ecstasy that drives you and her wild as you fuck it.");
	output("\n\n<i>“Gonna... gonna...”</i> the goo stammers, too busy screaming her pleasure to form more than that single word. You grin ear to ear and thrust harder, pistoning your hips against her glistening belly. Her body goes wild, squirming madly around you as she rockets over the edge and all but deforms around your [pc.cocks]. She collapses against the stone floor, flooding in a messy green pile around you as you too find orgasm in the goo’s warm embrace, flooding her porous body with [pc.cumNoun]. Your spunk floods out in billowing clouds, caking the gemstone bulb of her belly in a sticky mess.");
	output("\n\nSated, your head flops heavily between the goo-girl’s huge breasts. You need a few minutes to catch your breath after that - time the goo seems all too willing to provide, as her slimy exterior wraps around your [pc.legs] and arms, pulling you close. She moans softly, wiggling happily as your load of spunk disseminates like ink through water. It’s almost hypnotic, watching it settle over her clutch of eggs, burying into her hundreds of young. Looks like you’re going to be a daddy...");
	output("\n\nA few minutes later, you find the stamina to pick up and grab your gear, leaving the goo-girl in a pile of barely-humanoid good masturbating herself in a puddle of your spunk. Now that’s a sight to see!\n\n");
	processTime(15);
	gooVictoryPostGooCheck();
}

//Get Egged
//PC gets pumped full of nyrean eggs. Use Carrying Royal Eggs shit (below) if the PC gloryholed the googirl. Else, use Renvra’s unfertilized eggshit. Whoo, recycling.
//Tooltip: You can only imagine how amazing it would feel to have the bubbly bimbo goo-girl pump you full of her eggs.
//Req: Genitals
public function getEggedByCrystalGoo():void
{
	clearOutput();
	flags["CRYSTAL_GOO_DEFEAT"] = 3;
	output("By the way things look, this poor ganrael girl’s been completely addicted to the pleasure of getting pumped full of eggs day after day after day. You can only imagine what she’s experienced, but with her at your mercy, you think you could help yourself to a sample. The thought of pinning the goo down and forcing her to pump some of her eggy bounty into you sends a shiver of anticipation through you.");
	output("\n\nYou start to slowly set aside your gear, running hands over yourself to emphasize your ");
	if(pc.biggestTitSize() >= 1) 
	{
		output("bust");
		if(pc.hasGenitals()) output(" and your ");
	}
	if(pc.hasCock()) output("[pc.cocks]");
	else if(pc.hasVagina()) output("[pc.vaginas]");
	output(" before turning around and giving yourself a slap on the ass in the go’s direction, drawing her attention from her cowering in the corner. Her big, purple eyes grow wide as she drinks in your naked form; seeing that you’ve captured her gaze, you give her a lusty smile and swish your hips enticingly, using your body to replace the goo’s fear with something a little more palatable to your advances. She makes a pathetic little moan, rubbing her arms around the swollen, hard surface of her crystal belly - apparently a very pleasurable motion, if the way she jiggles and groans afterwards is any indication.");
	output("\n\nNow that she’s a little more open to you, you shimmy over to the fallen goo while groping and stroking yourself, putting on a show all the way until you’re right beside her.");
	output("\n\n<i>“W-what’re you...”</i> the goo starts to say, trailing off as you slip down to ");
	if(pc.legCount != 1) output("straddle her amorphous lower body");
	else output("press your lower body into her gooey form");
	output(", leaning in close to her.  <i>“You’re not gonna hurt my eggs, are you?”</i>");

	output("\n\n<i>“No,”</i> you assure her, reaching gingerly down to run your hand across her plated belly. You don’t want to hurt them - you want to give them a wonderful new home. Her eyes go inhumanly wide");
	if(silly) output(" like an anime character’s");
	output(", and you feel her gooey hands mold themselves around yours, guiding you to more pleasurable spots on her belly.");

	var x:int = -1;
	if(pc.hasVagina()) x = rand(pc.totalVaginas());
	output("\n\n<i>“The queen told me to take care of them,”</i> the goo-girl whines between moans, but she doesn’t stop you as you grasp her slimy body, stroking it out until you’ve shaped a vaguely phallic pillar of goop from her groin. You keep jacking off the growing spire of veridian goo, guiding it from just below her crystalline belly towards your [pc.vagOrAss " + x + "]. Your defeated foe moans, bucking her vaguely-defined hips in response to your touch. Her resistance, such as it was, evaporates into lusty cries and obscenes jiggles that make her pendulous breasts and huge belly shake maddeningly. You can’t resist the urge to bury your face in her chest, smothering yourself in bouncy, warm goo. She’s so soft, just firm enough to keep you from sinking completely inside her. Not that you think she’d mind that, if the way your free hand’s fingers penetrating even her side make her squeal and gasp when you move them. Her whole body must be like a pussy, mindbreakingly sensitive to anything that finds its way inside.");

	output("\n\nNo wonder those eggs are so amazing for her! Imagine having a hundred cocks inside you, edging you all day every day, rubbing incessantly against every sensitive spot inside your [pc.vagOrAss " + x + "] - that’s what the goo-girl must feel from her belly full of eggs! It might not feel so intense for you, but realizing what’s got the goo so pleasure-crazed only makes you more eager for her to pump you full of ‘em.");

	output("\n\nYou squeeze the pillar of goo in your hand, stroking it until it presses against your [pc.vagOrAss " + x + "]. Chewing your lip, you start to press your [pc.hips] down onto the cock - or more accurately, ovipositor - you’ve shaped out of the broodmare’s body, whispering sweet nothings between commands to hold herself still: you need her nice and hard to actually side inside you! She whimpers with pleasure, squirming haplessly underneath you, but her rod stays nice and firm, letting you push yourself down on it until with a gasp, you feel warm wetness flood into you.");
	output("\n\nWith a groan of pleasure, you slide down her artificial goo-cock, letting as much of her slimy body pour into your [pc.vagOrAss " + x + "] as you can. And she gives you plenty! Once the dam breaks, she floods like water through your clenching hole, using the first sliver of goo like a beachhead to stretch you out, growing and growing her tendril inside you until it’s as thick as a proper cock, and then some. You grit your teeth and moan, grinding your [pc.hips] into the gooey girl’s lap as she fucks you wide open.");
	if(x >= 0) pc.cuntChange(x,200);
	else pc.buttChange(200);

	output("\n\nNow that she’s got a thick, pulsing probe of goo snaking inside you, the goo-girl’s got a perfect vector to start pumping you full of those magnificent little eggs. Each of them looks a little less than fist-sized, certainly thicker around than your average cock! You can’t wait to feel them pushing through your [pc.vagOrAss " + x + "], stretching you wide again and again");
	if(x < 0) output(" like the biggest set of lubed-up anal beads you’ve ever seen");
	output(". You give the girl’s crystal belly a gentle pat and tell her to get to it: you <i>need</i> those eggs inside you.");

	output("\n\nShe whines at your request, clearly sad to be forced to disgorge her ovi-load... but she knows she’s been beaten. To the victor go the spoils, after all. After a moment of hesitation, she finally seems to lose her resistance, and you see the clutch of eggs inside her start to shift downwards toward her squirming ovi-cock. A shiver of anticipation slips down your spine as you bury your face deeper into her slimy cleavage, trying to relax your quivering muscles around the goo inside you, opening wide to make way for the eggs.");

	output("\n\nIt’s almost hypnotic, watching a stream of eggs dislodge from the near-perfect crystal casing pressing against your [pc.belly]. Several of eggs start the long journey through the goo-girl’s body towards your ");
	if(x >= 0) output("crotch");
	else output("ass");
	output(", and just like you’d thought, feeling all those fist-sized orbs rolling through her porous body makes the goo-girl squeal with pleasure. Every inch of her vacuous insides is as sensitive as a normal girl’s G-spot, and the eggs inside her tumble end over end through a pulsating channel that makes sure that as much goo as possible gets rubbed again and again by passing eggs.");

	output("\n\nEventually, after what seems like an eternity of agonizing anticipation, the first of the eggs finally finds its way into the viridian ovipositor you’ve forced the goo-girl to create. You bite your lip, trying to relax yourself as the egg begins its journey upwards through her tendril and into you. Her wriggling inside you reaches a fever pitch, thrashing her gooey tentacle around in your ");
	if(x < 0) output("ass");
	else output("pussy");
	output(" like she’s trying to stretch you out to make room for her charges.");
	if((x >= 0 && pc.vaginalCapacity(x) >= 500) || (x < 0 && pc.analCapacity() >= 500)) output(" Not that she needs to: you’re pretty sure you could stuff all those eggs inside you, no problem!");
	output(" You brace for impact, feeling the gentle but firm pressure on your ");
	if(x >= 0) output("pussy lips");
	else output("anal ring");
	output(" as the goo-girl fucks the first egg in.");

	output("\n\nGetting egged feels exactly as good as you’d imagined, a cascade of pleasure radiating up from your [pc.vagOrAss " + x + "], turning your muscles to liquid. The egg pushes in, spreading your hole wide open and gliding in through a tube of pure, wet, gooey lube. Your stomach lurches as the egg tumbles in along the tentacle’s slimey expanse. The sensation is overwhelming, eliciting a silent cry of pleasure from you; your limbs contract around the goo’s soft body, going limp as your body surrenders to the egging. A second soon joins the first in stretching out your ");
	if(x >= 0) output("womb");
	else output("bowels");
	output(", pushing through your failing defenses on a sloppy trail of wriggling goo.");

	output("\n\nEgg after egg pushes into you, bloating your belly in a ");
	if(pc.skinType == GLOBAL.SKIN_TYPE_GOO) output("gooey");
	else if(pc.hasScales()) output("scaly");
	else if(pc.hasFur()) output("furry");
	else output("fleshy");
	output(" counterpart to the goo-girl’s own. You both moan and cry out, engulfing each other in ecstasy as the queen’s clutch transfers from the gooey broodmare’s body to yours.You lose count of how many eggs pass through your [pc.vagOrAss " + x + "], but it feels like at least ");
	var eggCount:int = 5 + rand(6);
	output("! You’re left panting and gasping as the last egg squirms inside you, settling in among its sisters.");

	output("\n\n<i>“Y-you’ll take care of them, right?”</i> the goo murmurs, still wriggling her egg-bloated cock inside you. Even if you wanted to answer, your mounting orgasm prevents you, leaving you with only gasps and moans into her gooey chest. She takes that as an implied yes, it seems, as her limbs wrap around you, holding you tight as her slimy ovi-cock packs the eggs in tightly, leaving them slathered in hot goo before slowly pulling out of you.");

	output("\n\nYou take a few moments to recover before slowly rolling off of the goo-girl, running your hands across your gravid belly. Oh, that felt amazing... and now you’ve got a host of the queen’s ");
	if(flags["CRYSTAL_GOO_GLORYHOLED"] == 1) output("fertilized ");
	output("eggs rolling around in your ");
	if(x >= 0) output("womb");
	else output("gut");
	output(". Maybe you’ll have some royal daughters before long...");
	//99999 set up some pregger shit
	processTime(16);
	pc.orgasm();
	//[Next]
	gooVictoryPostGooCheck();
}

public function gooVictoryPostGooCheck():void
{
	clearMenu();
	if(pc.armor is GooArmor || pc.destroyItemByName("Goo Armor",1)) addButton(0,"Next",armorGooVictoryShits);
	else genericVictory();
}

//Post Goo-Battle: Nova Upgrade!
//PC has Armor Goo equipped or in inventory.
//Play after PC is done with guu post-fite. Armor Goo gets a permanant +2 Defense bonus, and counts as Mirrored.
public function armorGooVictoryShits():void
{
	clearOutput();
	//show armorbutt?
	showName("GOO\nARMOR");
	showBust("GRAYGOO");
	output("<i>“Oh, hey,”</i> [goo.name] says, poking her head out. <i>“that crystal stuff she made was really cool, huh?”</i>");
	output("\n\nYou pause, taken aback by your normally-passive suit of goo’s sudden outburst. Still, you nod: the crystal on that ganrael broodmare was certainly useful to her.");
	output("\n\n<i>“Could I, um... get a sample, maybe?”</i> [goo.name] asks sweetly, reaching her head around on a stalk of gray goop to give you a puppy-dog look. <i>“I bet I could replicate it! Make myself an even better bodysuit for you!”</i>");
	output("\n\nWell, if she can give you an edge in combat, you can hardly pass that up. You turn back to the moaning pile of defeated goo-broodmare and crouch down beside her, letting [goo.name] go to work. The bubbly gray goo hops ");
	if(pc.armor is GooArmor) output("off of you");
	else output("out of your pack");
	output(" and burbles over to the egg-laden slut, reaching a silvery hand down to run a few fingers along her crystal-armored belly. <i>“Oooh, it’s pretty!”</i> [goo.name] giggles, <i>“And hard, too! Hmm, bio-crystal like this... just really hardened body cells. Interesting! Hmm, analysis shows a complexe biological process going on all through her body, turning old cells crystal, pushing them together to form shards... I can totally do that!”</i>");
	output("\n\nSometimes it’s easy to forget [goo.name] was <i>supposed</i> to be a medical program, before whatever went wrong with the grey goo turned her into a flighty bimbo. Makes you wonder what happened to the ganrael girl to make her into such a mindlessly loyal egg-slut. This nyrean queen must really be something...");
	output("\n\nAs you’re musing to yourself, you see [goo.name] hop off of the defeated ganrael and scoot back over to you. As she moves, bit of her shoulders and legs begin to bubble and morph, changing into gray facsimiles of crystal armor plates. They seem sturdy, too - enough so that your bubbly bodysuit invites you to punch them as hard as you can. You give them a few good smacks, and [goo.name] just giggles and quivers from the impacts. The gooey crystal shifts back in her body when you hit them, but pop back a moment later. You’re not sure just how effective they’d be at stopping a bullet, but they’d certainly give a fist-fighter something to think about.");
	output("\n\n<i>“Like my new look?”</i> [goo.name] grins, twirling around to show off a growing number of spikey grey crystal plates forming on her chest and back, forming pauldrons and a solid breastplate. You’re sure that, when it comes time to have a little fun, the plates could easily be absorbed back into her. But here in a place rife with danger, well, she almost looks like a sexified version of a proper knight now!");
	output("\n\nShe giggles at the praise and bounds back to you. <i>“Ready to go, [pc.name]!”</i>\n\n");

	if(pc.armor is GooArmor)
	{
		pc.armor.hasRandomProperties = true;
		pc.armor.defense += 2;
		pc.armor.resistances.addFlag(DamageFlag.MIRRORED);
	}
	//what if pc has it somewhere in inventory...
	//Find it in inventory... and upgrade. Fuck it, if the PC has multiple, upgrade 'em all. Fekkin' cheaters.
	for(var x:int = 0; x < inventory.length; x++)
	{
		if(inventory[x].shortName == "Goo Armor")
		{
			inventory[x].hasRandomProperties = true;
			inventory[x].defense += 2;
			inventory[x].resistances.addFlag(DamageFlag.MIRRORED);
		}
	}
	processTime(6);
	clearMenu();
	genericVictory();
}

/*
output("\n\nCarrying Royal Eggs");

output("\n\nNyrean Egg Carrying");
output("\n\n//Nyrean pregnancy lasts 7+/-2 days. The PC’s belly becomes fairly gravid, and their movement speed and evasion is reduced (or whatever standard preg debuffs there are, I dunno).");

output("\n\nOther stuff we need to define a pregnancy:");

output("\n\nMinimum Quantity: 5");
output("\n\nMaximum Quantity: 10");
*/

//Queen Taivra's Throneroom
//PC gets sucked into cutscene as soon as they enter the chamber the first time. 
public function queenTaivrasThrone(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	output("You reach the bottom of the winding stairs and push through a silken curtain, stepping into a broad square chamber at the heart of the nyrean palace. You’re instantly greeted by the sounds of sex, the wet beating of flesh on flesh echoing off the stone walls in a cacophony of sensuality. As your eyes adjust to the glare of bright blue lanterns hanging from pillars along the walls, your gaze settles on a room lavishly decorated with animal hide rugs and silky tapestries hanging from behind the Greek-style pillars, showing images of nyrea warriors battling cthonic abominations from an old-Earth artist’s nightmares.");
	output("\n\nYour eyes wander up to the far end of the room, to a dias upon which sits a huge black throne, surrounded by writhing bodies. A nyrea woman sits lazily on the throne, one leg crossed over the other, a spear resting at her side. She wears the same chainmail bikini as the other huntresses you’ve seen, though she wears a long red cape hanging down from her leather-padded shoulders, and her fur-lined bottom gives way behind her to a squirming mass of of green tentacles. Each tentacle moves on its own accord, wiggling around the nyrean queen’s hips and down to the prone bodies of a dozen huntresses, all naked with their pseudo-penises erect and penetrated: her betas are being vigorously cock-fucked, their tumescent shafts bulging and throbbing as the queen’s tentacles violate them, spreading her seed into their alien wombs.");
	output("\n\n<i>“I believe I commanded that I was not to be disturbed,”</i> the regal huntress says, her voice a low murmur over the cries of her writhing submissives. Her claw-nailed fingers tighten around the haft of her spear, and you feel her black eyes sizing you up, drinking in every inch of your body.");
	if(plat190) output("\n\n<i>“We’re sorry, my queen. The off-worlder was very... persuasive,”</i> one of the guards whimpers, retreating towards the curtain. You give your escort a look, just in time to see them scampering off back the way they came.");
	output("\n\nThe queen tsks her tongue and turns her attention from you to another figure on the dias, standing behind the throne. Another nyrea, but unlike her sisters, is clad in glistening steel plates from head to toe and carrying a blade and shield. Very unhuntress-like. <i>“My dear Queensguard,”</i> the queen says, leaning back on her throne, <i>“Kindly show this-”</i>");
	output("\n\n<i>“[pc.name]!”</i> a familiar voice shrieks from the shadows near the throne, cutting the queen off mid-sentence. At the foot of the dias, though, are a pair of metal cages meant more for an animal than a person. Your cousin and [rival.hisHer] bodyguard, Dane, are held captive inside them. <i>“Get us out of here, cousin [pc.name]! This stupid wanna-be queen grabbed us - she’ll get you next. Hurry!”</i>");
	output("\n\n<i>“<b>SILENCE!</b>”</i> the armored nyrea, Queensguard, bellows, slamming her kite shield against [rival.name]’s cage. Your cousin shrinks back with a yelp of surprise. Dane growls, his four arms grabbing the bars and straining against them. <i>“Queen Taivra will suffer no further insult from you, worm.”</i>");
	output("\n\n<i>“Do you know who I am!?”</i> [rival.name] yells back, glowering at the knightly nyrea. <i>“Do you know who my </i>father<i> is? Let us go and give me that proe your skank ass is sitting on and </i>maybe<i> he won’t burn your stupid planet to ashes!”</i>");
	output("\n\nBeyond them, the queen chuckles and raps her claw-like nails on the arms of her throne. Now that you look at it, [rival.name] is right... the back of this Queen Taivra’s throne is a matte black, flickering with electronic lights. They must have recovered the probe when it landed!");
	output("\n\n<i>“Enough,”</i> Taivra sighs, fixing her gaze on you once more. <i>“I see you are related to my new pets... [pc.name]. Cousins? I suppose that answers the who and the why of this unexpected interruption.”</i>");
	output("\n\nShe waves the hand not wielding her towering spear across the dozen huntresses sprawled at her feet, all moaning and squirming as the queen’s bushel of tentacle cocks fuck their strange sexes. <i>“Your cousin has already attempted to usurp my throne, star-walker. [rival.HeShe] very likely would have assassinated me in the process. And now you have ");
	if(plat190) output("clearly bribed");
	else output("fought your way through");
	output(" my guards. I can see now your kind really is nothing but trouble. How you’ve duped the myrmedion into accepting you, I can’t imagine.”</i>");
	output("\n\n<i>“So,”</i> she says, leaning forward in her seat and smiling at you with purple-painted lips. <i>“I do hope you have something to say for yourself. Before my darling bodyguard puts you in a cage with your cousin, that is.”</i>");
	processTime(5);
	//[Fight] [Rivals] [Peace] [Probe]
	taivraTalk(plat190);
}

public function taivraTalk(plat190:Boolean):void
{
	clearMenu();
	addButton(0,"Fight",startFightingQueenButt,plat190,"Fight","No need to drag this out. Time to kick the queen’s ass.");
	if(flags["TAIVRA_RIVAL_TALK"] == 1) addDisabledButton(1,"Rivals","Rivals","You've already mentioned this.");
	else addButton(1,"Rivals",explainRivalnessToTaivra,plat190,"Rivals","Try and explain that you and your cousin are rivals - you’re anything but in league with each other!");
	addButton(2,"Peace",talkOfPeace,plat190,"Peace","Tell the nyrean queen you come in peace. Now that you’re talking to some one in charge, maybe you can work out a deal.");
	if(pc.isMischievous()) addButton(3,"Probe",probeTouch,plat190,"Probe","You’re here for the probe. Nothing more, nothing less. You’ll do whatever it takes to make the queen happy in order to get it.");
	else addDisabledButton(3,"Probe","Probe","This option is for mischievous characters only.");
	if(flags["TAIVRA_DEAL_UNLOCKED"] == 1) addButton(4,"Deal",dealWithTaivra,plat190,"Deal","You’ve convinced Queen Taivra to listen to your deal. Better make a damn good offer, or else you’ll probably be in for a fight to get that probe.");
	else addDisabledButton(4,"Deal","Deal","You've got to convince her to make a deal before you can figure out what kind of deal to cut.");
}

//Fight
//No need to drag this out. Time to kick the queen’s ass.
//+small PC Hardness
public function startFightingQueenButt(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	showBust("TAIVRA","QUEENSGUARD");
	pc.addHard(4);
	output("You draw your [pc.weapon] and flash the queen a dangerous smile. You’ve got nothing to say to her.");
	output("\n\n<i>“At least this one is honest about [pc.hisHer] intentions,”</i> Taivra chuckles. <i>“Unfortunately, I’m a bit too preoccupied to play at the moment. Queensguard, my dearest, why don’t you show this star-walker what happens to regicides.”</i>");
	output("\n\nThe heavily armored bodyguard gives the queen a brisk nod and steps between you and her mistress, raising her steel shield. <i>“With pleasure, my queen. Offworlder, defend yourself!”</i>");
	processTime(1);
	//[Fight!]
	clearMenu();
	addButton(0,"Next",startCombat,"Queensguard");
}

//Rivals
//+small PC Mischievous
//Try and explain that you and your cousin are rivals - you’re anything but in league with each other!
public function explainRivalnessToTaivra(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	pc.addMischievous(4);
	output("<i>“Wait, wait,”</i> you say, putting your hands up in a disarming gesture. <i>“Look, you’ve got it all wrong. Me and this " + chars["RIVAL"].mf("bastard","bitch") + " are enemies! We’re on the same side here, Queen Taivra.”</i>");
	output("\n\nThe queen’s eyes cock upwards at that, and she reclines in her chair with a hearty chuckle. <i>“Is that so? And why should I beleive you, [pc.name]? Your cousin came to me under a promise of peace, only to try and make off with my throne like a common thief. [rival.HeShe] came very close to killing several of my guards before we could subdue [rival.himHer] and [rival.hisHer] bodyguard. If you are truly enemies, simply leave. I will keep your cousin out of your hair... forever.”</i>");
	output("\n\n<i>“Way to throw us under the bus, you jerk!”</i> your cousin whines from [rival.hisHer] cage.");
	output("\n\nDane actually laughs, turning to the queen and saying <i>“[pc.HeShe] wants the probe too, you know. ");
	//if didn’t beat Dane:
	if(flags["WHUPPED_DANES_ASS_ON_MHENGA"] == undefined) output("This one’s not much of a rival, though, queenie. Good for a fuck, though. Why don’t you let [pc.himHer] and my boss here trade places, huh?”</i>");
	else output(" Better watch your step, queenie. This one’s a real handful. Better let us take the probe and go, or you’re gonna get the ass kicking of a lifetime.”</i>");

	output("\n\n<i>“Unlikely,”</i> the queen scoffs, turning her attention back to you. <i>“Anything else?”</i>");
	flags["TAIVRA_RIVAL_TALK"] = 1;
	//Other options remain.
	processTime(3);
	taivraTalk(plat190);
}



//Peace
//Tell the nyrean queen you come in peace. Now that you’re talking to some one in charge, maybe you can work out a deal
//+PC Kindness
public function talkOfPeace(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	pc.addNice(4);
	output("<i>“I come in peace, Queen Taivra,”</i> you urge her. <i>“All I need is to touch your throne. It’s a device my father dropped on this planet, you just... got it by accident. If I touch it, I’ll get the data I need, and we can all walk away happy.”</i>");
	output("\n\n");
	//if PC has a high Kindness rating:
	if(pc.isNice()) 
	{
		output("<i>“Hmm,”</i> the queen murmurs, sizing you up for a good long moment. <i>“I beleive you, [pc.name]. Strange as that may seem, you have an honest demeanor about you. Quite contrary to your cousin... it suits you.");
		output("\n\n<i>“So... can we make a deal?”</i> you ask, taking a hesitant step forward. Queensguard makes no movement to stop you.");
		output("\n\nThe queen smiles. <i>“Perhaps. Among my kind, there is a saying: ‘triumph brings the spoils of conquest.’ You are an unwelcome guest, but an honest one... I will give you the chance to earn your father’s treasure, with honor. Something your cousin lacks entirely.”</i>");
		output("\n\n<i>“That’s not quite what I had in mind,”</i> you say, taking a step back as Queensguard turns her attentions to you. <i>“I’ve got plenty of honor, but I don’t want a fight here. Like I said, I come in peace.”</i>");
		output("\n\nThe queen blinks, surprised. <i>“You refuse honorable combat? A strange race, yours... different from any I’ve encountered here. So rare to see someone who prefers an open hand than a clenched fist");
		if(plat190) output(", especially one who would subvert my guards rather than fight [pc.hisHer] way inside");
		output(". Very well, I will hear what you propose. Though I will not give you your device for free, you understand. After all, you’ve ");
		if(!plat190) output("forced");
		else output("manipulated");
		output(" your way inside my home. That alone demands some recompense...”</i>");
		processTime(3);
		//Add [Deal] option to dialogue
		flags["TAIVRA_DEAL_UNLOCKED"] = 1;
		taivraTalk(plat190);
		return;
	}
	//if PC instead has a low Kindness rating:
	else
	{
		output("<i>“I don’t believe you, off-worlder,”</i> the queen sighs, leaning back and crossing her legs again. <i>“Queensguard, take [pc.himHer]. I tire of seeing star-walkers run free.”</i>");
		output("\n\n<i>“By your command, my queen,”</i> the heavily armored warrior says, stomping forward and placing herself between you and the queen. You suppose this was inevitable, after all...");
		processTime(1);
		//[Fight!]
		clearMenu();
		addButton(0,"Fight",startCombat,"Queensguard");
		return;
	}
}

//Probe
//You’re here for the probe. Nothing more, nothing less. You’ll do whatever it takes to make the queen happy in order to get it.
//PC must be moderately Mischievous to get this option.
//+PC Mischievous
public function probeTouch(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	pc.addMischievous(2);
	output("<i>“Look,”</i> you say, giving the queen that famous Steele smile. <i>“I just want to touch the probe. That’ll give me everything I need, and you and I can go our separate ways. My cousin here? Fuckin’ asshole, through and through. Not really surpised good ol’ [rival.name] tried to rip you off, but we come from totally different sides of the road. [rival.HisHer] dad spend a century ripping mine off at every opportunity; a real scumbag. The real Steeles have been dealing with their bullshit for ages, and I’m sorry you and your, uh, friends here all got caught up in the family squabble.”</i>");
	output("\n\nYou take a couple steps forward, putting on your best company " + pc.mf("man","girl") + " air. If Dad taught you anything, it’s how to get what you want - and what’s the big difference between a boardroom and a creepy underground bugfolk palace? Aside from all the weapons, anyway.");
	output("\n\n<i>“So, what can I do to make it up to you?”</i> you ask with a smile, not shying away from letting your eyes wander over the queen’s largely bare body - and the mass of tentacle cocks pounding her harem’s cock-holes. You can only imagine the behemoth she’s probably packing under that chainmail bikini bottom, too... Knowing how this part of the galaxy seems to work, you can only imagine what the queen might want from you, after all.");
	output("\n\nTaivra chuckles, resting her spear across her knees and steepling her fingers. <i>“My, my, this one has quite the silver tongue. Don’t you think, dearest?”</i>");
	output("\n\n<i>“Aye, my queen,”</i> Queensguard snaps robotically, shifting her gaze between you and your caged-up cousin.");
	output("\n\n<i>“I have a few harem girls that think you star-walkers could very well be the greatest thing this planet has ever seen - you’re some sort of saviors who will give us all peace and prosperity and rivers of gold, I’m sure. I took little stock in that silliness, especially after your cousin decided to try and take my throne. But perhaps, as you say, this " + chars["RIVAL"].mf("boy","girl") + " is just a bad murrock fruit, hmm? Very well, [pc.name], I will hear you out. Though I hope you make your offer a good one - even if you are sincere, you have broken into my home. Caused no end of damage on your way in, I’m sure");
	if(plat190) output(" - or at the very least, seem to have corrupted the loyalty of my guardswomen");
	output(".");

	output("\n\nDamn, you’re good.");
	processTime(4);
	dealWithTaivra(plat190);
}



//Deal
//You’ve convinced Queen Taivra to listen to your deal. Better make a damn good offer, or else you’ll probably be in for a fight to get that probe.
//Open up list of sub-options. PC gets 2 tries before we get a <i>“Bad Deal”</i> intro to the fight, below.
public function dealWithTaivra(plat190:Boolean = false):void
{
	//[Sex] [Credits] [Alliance] [Princess] [Weapons] [Back]
	clearMenu();
	if(flags["TAIVRA_DEAL_ATTEMPTS"] == 2) 
	{
		addButton(0,"Next",badDealWithTaivra);
		return;
	}
	if(pc.credits >= 20000) addButton(1,"Credits",offerTaivraCredits,plat190,"Credits","Offer to pay her for the probe. Give her what it’s worth to the company, and you’ll break out even. Everybody likes money, right?");
	else addDisabledButton(1,"Credits","Credits","You don't have a decent amount of credits to offer.");

	if(flags["OFFERED_TAIVRA_AN_ALLIANCE"] == undefined) addButton(2,"Alliance",offerTaivraAnAlliance,plat190,"Alliance","Offer Queen Taivra an alliance. There’s not much you can do to cement it beyond your word at this point, but being the partner of an interstellar business mogul is a hell of an advantage when your world is on the brink, and you’re just a stone age tribe. Steele Tech could offer her help, protection...");
	else addButton(2,"Partnership",partnershipWithTaivra,plat190,"Partnership","Your father was the biggest interstellar playboy in the galaxy. He left a trail of lovers in his wake. What are you, if not your father’s child? You offered the nyrea partnership, so make it official: take Queen Taivra as your wife, with all the responsibility and vulnerability that brings.");

	if(flags["MET_PRINCESS"] == 9999) addButton(3,"Princess",princessChoice,plat190,"Princess","Offer to take the rambunctious princess under your care. Marry her, if you have to. Surely Taivra wouldn’t object to her daughter being at the side of a galactic super-star like you’ll soon be.");
	else addDisabledButton(3,"Locked","Locked","You haven't met who you need to meet to unlock this option.");
	addButton(4,"Weapon",giveTaivraGunsForPeace,plat190,"Weapons","Offer the nyrean queen futuristic weapons from Steele Tech. Imagine going from the literal stone age to rocking modern ray guns. Goodbye, balance of power... Though you’ll be trading your reward for recovering the probe in exchange for the guns.");
}
public function dealTick():void
{
	if(flags["TAIVRA_DEAL_ATTEMPTS"] == undefined) flags["TAIVRA_DEAL_ATTEMPTS"] = 0;
	flags["TAIVRA_DEAL_ATTEMPTS"]++;
}

//Weapons
//Offer the nyrean queen futuristic weapons from Steele Tech. Imagine going from the literal stone age to rocking modern ray guns. Goodbye, balance of power... Though you’ll be trading your reward for recovering the probe in exchange for the guns.
public function giveTaivraGunsForPeace(plat190:Boolean = false):void
{
	clearOutput();
	output("<i>“You’re a queen among a race that seems to me like it’s all about fighting. Fighting to mate, for dominance, for territory. Am I right?”</i>");
	output("\n\nThe queen gives you a slight, almost imperceptible nod. <i>“I figured. But you carry spears and swords. The myrmedions above you have guns, they’ve got chemical weapons... even nukes, it looks like. That’s a hell of a difference in power. What if I arranged to have your people take delivery of a shipment of star-walker weapons: my father’s company has a whole line of non-military rifles and energy blades, perfectly legal for us to distribute to Rush-world races.”</i>");
	output("\n\nAdmittedly, you’ll be sacrificing your company payout from the probe for this, but hey. Better to leave heavily-armed friends behind than bitter enemies.");
	output("\n\n<i>“So how about it? I’ll need to take the probe, but after that, I think I can arrange a whole crate of laser pistols to be delivered to you. Sound good?”</i>");
	output("\n\nThe queen reclines, running a dark tongue across her purple lips. In his cage, Dane growls something about a <i>“prime director”</i> or some such, and how arming space barbarians with lasers will get you all killed.");
	output("\n\nAfter a long moment of deliberation, the queen chuckles and clicks the butt of her spear against the stone dais under her. <i>“You offer a compelling deal, but no. The moment this new government, the Scarlet Federation, hears about a group of nyrea with advanced weapons, we’ll have a battalion of soldiers knocking at our doors. They’ve pressganged thousands of nyrea from their home continent into service, as I understand. I can’t imagine they would make an exception for me, if they’ve already tamed more powerful nyrea warlords than me. I’d rather not draw attention to myself, at least not now.”</i>");
	output("\n\nDamn, you were sure she’d go for that one...");
	processTime(2);
	dealTick();
	dealWithTaivra(plat190);
}

//Princess
//PC must have beaten the Nyrea Princess
//+PC Hardness
//Offer to take the rambunctious princess under your care. Marry her, if you have to. Surely Taivra wouldn’t object to her daughter being at the side of a galactic super-star like you’ll soon be.
public function princessChoice(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	output("<i>“How about I marry your daughter? She and I have already been introduced, and-”</i>");
	output("\n\n<i>“No,”</i> Taivra snaps, narrowing her eyes. <i>“Furthermore, I will have you flogged if you laid a hand on my daughter. [princess.name] may be the eldest of my brood, but as you may have noticed, [pc.name], I have a great many children. Several I will sire on you, in fact.”</i>");
	output("\n\nYou blink.");
	processTime(1);
	//Add <i>“Bad Deal”</i> here
	clearMenu();
	addButton(0,"Next",badDealWithTaivra);
}


//Credits
//PC must have 20,000 Credits
//Offer to pay her for the probe. Give her what it’s worth to the company, and you’ll break out even. Everybody likes money, right?
public function offerTaivraCredits(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	output("<i>“I can pay you for the probe,”</i> you offer, drawing your Codex. <i>“It’s worth a small fortune to me, I assure you.”</i>");
	output("\n\nQueen Taivra laughs at that - laughs right in your face. <i>“[pc.name], your money is less than worthless down here. I can’t buy arms and armor from my smith with anything less than gems and gold; I can’t trade with other tribes, other alphas. Your credits can’t be smelted down or made into beautiful things. No, I have no use for your money. Go talk to Seifyn outside - she’s the only one you’ll find in the deep caves interested in your imaginary credits.”</i>");
	processTime(1);
	dealTick();
	dealWithTaivra(plat190);
}

//Alliance
//Offer Queen Taivra an alliance. There’s not much you can do to cement it beyond your word at this point, but being the partner of an interstellar business mogul is a hell of an advantage when your world is on the brink, and you’re just a stone age tribe. Steele Tech could offer her help, protection...
public function offerTaivraAnAlliance(plat190:Boolean = false):void
{
	clearOutput();
	showTaivra();
	output("<i>“How about you and I partner up, my queen?”</i> you suggest, with a flourished " + pc.mf("bow","curtsy") + ". <i>“A formal alliance between my company, Steele Tech, and your tribe. I’m sure we can both help each other, now and in the future. Surely you can see the advantage of having an interstellar partner looking out for you - look what it’s done for the gold myr.”</i>");
	output("\n\n<i>“Your ");
	if(pc.isMischievous()) output("silver tongue");
	else output("eagerness to please");
	output(" continues to impress me, [pc.name],”</i> Taivra laughs. <i>“Still, I have interrogated your cousin somewhat since [rival.hisHer] capture. You do not own this... Steele Tech. You don’t command its resources, as you claim. Not without this probe of mine, and many more like it.”</i>");
	output("\n\nYou try to keep your cool. <i>“That’s right,”</i> you grin, <i>“exactly right. I need your help now, but once I have all of the probes...”</i>");
	output("\n\n<i>“Ha! What would compel you to return to me, once you’ve left? What proof do I have that you will honor your side of the bargain? As you no doubt know, I would have little recourse once you’d left... even outside of the deep caves here on the planet, my reach is greatly diminished. On another world, in the shadow of some distant star... would you even think of our bargain?");
	if(pc.isNice()) output(" You seem a " + pc.mf("man","woman") + " of your word, yet I find it hard to believe a mere clan of cave dwellers such as us would matter compared to the wonders and dangers of your world.");
	output("”</i>");

	output("\n\nShe makes a good point, but the way she’s looking at you... the way she hasn’t called her bodyguard to start dismembering you... Queen Taivra knows this could be a good deal. She wants something from you, and you’re so close... but what more could you offer her?");

	//Replace option with [Partnership]. Doesn’t count towards <i>“Bad Deal”</i>
	flags["OFFERED_TAIVRA_AN_ALLIANCE"] = 1;
	processTime(4);
	dealWithTaivra(plat190);
}

//[Partnership]
//+EXP equal to Taivra’s value
//Your father was the biggest interstellar playboy in the galaxy. He left a trail of lovers in his wake. What are you, if not your father’s child? You offered the nyrea partnership, so make it official: take Queen Taivra as your wife, with all the responsibility and vulnerability that brings.
public function partnershipWithTaivra():void
{
	clearOutput();
	showTaivra();
	output("<i>“I offered to partner up with you,”</i> you suggest, taking a confident stride forward with your most charming smile on full display. <i>“But a partnership goes both ways. Responsibility, vulnerability, power over the other. You interrogated my cousin, like you said. Surely that means you know just how wealthy and powerful I’ll be when my quest is done.”</i>");
	output("\n\nThe queen smiles. <i>“I do, yes. Though the thought of a stellar empire does boggle the mind...”</i>");
	output("\n\n<i>“Hey, wait, what’re you doing!?”</i> [rival.name] shrieks from [rival.hisHer] cage. <i>“You can’t do this, [pc.name], are you insane? And it’s going to be my company anyway!”</i>");
	output("\n\n<i>“Shut up, [rival.name],”</i> you say off-handed, barely looking your cousin’s way. A few more steps take you right to the edge of the queen’s dias, and you kneel down before the amazonian woman. She makes a slight gesture, and the prostrate bodies of her betas quickly clear out, scampering off out of the throne room. Her many tentacle cocks, still dripping with juice and seed, recoil under the arms of her throne, and Taivra leans forward with eager anticipation. You both know how this has to end, now, and the queen clearly appreciates every second of foreplay before you reveal your plan.");
	output("\n\n<i>“Queen Taivra. Though this is the first time we’ve met, you’ve stuck me with awe of you beauty, your cunning, your regal power. I know that, together, a mega-corporation and a legion of nyrea could do great things - for us both. Your people have alphas and betas and harems, but among mine, we also have " + pc.mf("","husbands and ") + "wives who share power equally. I-”</i>");
	output("\n\n<i>“You </i><b>are</b><i> insane!”</i> [rival.name] yells, until Queensguard slams her shield against your cousin’s cage. <i>“What’re you...”</i>");
	output("\n\n<i>“-don’t have a ring on me,”</i> you continue, smiling up at the queen, <i>“but the Codex here can make it official. Legal and binding. So, will you-”</i>");
	output("\n\n<i>“Oh, shut up already,”</i> Taivra laughs, grabbing you by ");
	if(pc.tallness <= 72) output("the collar");
	else output("the shoulder");
	output(" and pulling you almost into her lap. <i>“You have a remarkable dedication to peace, [pc.name]. Willing to give up so much power just to touch a stone... or have you just fallen in love at first sight, hmm?”</i>");

	output("\n\nYou’re so close you could almost reach out and touch the probe. Instead, though, you cup the queen’s cheek and smile, drawing the two of you a little closer.");

	output("\n\n<i>“You are very impressive, [pc.name],”</i> the nyrean queen smiles, letting you get as close as you like, until your [pc.lips] are almost touching her slender purple mouth. You feel her hand roaming across your body, exploring the form of her new lover for a moment before settling firmly on your crotch. <i>“In many ways... so long as you will not begrudge me of my dalliances - and I of course will do the same - I believe we have an arrangement. One that, I hope, will be quite profitable... and pleasurable... for us both.”</i>");

	output("\n\nYou lean in and kiss her, binding your fate with a woman you’ve only just met. You could have fought her, as you have many others before her. You might have even won. But somehow, you feel that you’ve found the lesser of every evil here today. And as Taivra said, you’ll be sure to make this relationship as pleasurable as you can - you think to yourself, as one of your hands snakes up her firm chest, dipping under the fur-lined mail of her top to squeeze a breast. Taivra moans softly, and your Codex chirps something about a new marriage license being ready at the nearest Confederate legal office. Wherever that is. For now, you’re content to enjoy the fruits of your new union.");

	processTime(8);
	pc.lust(14);
	var XPBuffer:Number = 1000;
	if(XPBuffer + pc.XP() > pc.XPMax()) XPBuffer = pc.XPMax() - pc.XP();
	pc.XP(XPBuffer);
	if(XPBuffer > 0) output("\n\n" + XPBuffer + " XP gained.");
	else {
		output("\n<b>Maximum XP attained! You need to level up to continue to progress.</b>");
		if(pc.level == 1) output("\n<b>Find a bed to sleep on in order to level up (like on your ship).</b>");
	}
	//[Next]
	clearMenu();
	addButton(0,"Next",youMarriedAnEvilChick);
}

public function youMarriedAnEvilChick():void
{
	clearOutput();
	showTaivra();
	showName("DANE &\nQUEENSGUARD");
	showBust("DANE_NUDE","QUEENSGUARD");
	output("<i>“RUN FOR IT!”</i> a voice booms behind you, just as you and Taivra are about to seal the metaphorical deal. You scramble to your ");
	if(pc.legCount > 1) output("[pc.feet]");
	else output("full height");
	output(" and look back, just in time to see Dane lumbering to his full height, you cousin scrambling off behind him. The pair of huntresses standing behind the cages leap towards him, but are quickly swept aside by his bulging arms - thrown against the walls with heavy thuds.");

	output("\n\nThe alabaster ausar is utterly naked, stripped of his gear and bruised from his capture, but he’s grinning like a mad dog all the same. The veins on his arms bulge as he flexes his corded muscles, flipping the pieces of primitive weaponry down to his lower arms to hold like daggers. <i>“You should’ve killed me when you had the chance. This time you won’t get a chance to jump me in the dark.”</i>");
	output("\n\n<i>“Slaves should learn their place,”</i> Queensguard answers, lowering her shield into place and readying her sword. <i>“If they cannot fathom that, then they will be fed to the deeps, piece by piece.”</i> She advances steadily, one plated boot in front of the other warily moving to intercept Dane.");
	output("\n\n<i>“That’s all you’ve got? Not even a gun?”</i> Dane grins, cracking a pair of his knuckles.");
	output("\n\nConfusion briefly crosses Queensguard’s face. <i>“You are naked with naught but a broken weapon. I have no need of a dishonorable star-blaster.”</i>");
	output("\n\n<i>“If you had a gun, you might have had a chance.”</i>");
	output("\n\nYou wouldn’t have thought a guy as big as Dane could lunge so far and so fast if you hadn’t tangled with him once already, and the armored nyrea clearly doesn’t share that experience. She only has time for her eyes to widen in surprise before Dane crashes into her in a flash of albino fur and pounding fists, driving her back half a pace. The broken haft of the spear shatters on impact with her armor-plated side, visibly denting the plate. Knuckles deflect off Queensguard’s helm, leaving lines of blood behind where the sharp metal ripped into Dane’s knuckles.");
	output("\n\nFor all his power and speed, it’s clear that your cousin’s bodyguard is more a brawler than a trained fighter. He doesn’t try to avoid harrowing slashes from Queensguard’s sword, relying on the awkward positioning to rob the strength from her blows and his thick fur to keep her from cutting too deeply. Dane’s left forearms are soon matted red with blood from a half-dozen surface cuts, but none so deep as to stop him from grabbing hold of his foe’s shield in two hands wrenching it powerfully to the side.");
	output("\n\nQueensguard is no brawler. She’s a fighter, used to tackling her Queen’s enemies in one on one confrontations. She lets her arm slide out of the shield’s strap and spins with the momentum, twisting around for a vicious, back-handed slice. A diagonal rent opens up across Dane’s chest, deep enough to reveal two or three blood-drenched bones but not quite deep enough to bring down the mighty ausar. His rage filled blood leaves steaming, crimson puddles on the ground between them.");
	output("\n\nDane staggers a half-step back from the pain, but he doesn’t drop the shield. He leans further back, sweeping the shield up and into the underside of Queenguard’s polished blade. The clang of metal on metal reverberates through the cavernous chamber as the two bodyguards struggle. The nyrea barely keeps her grip on her weapon, but Dane never needed to disarm her, just take away her biggest defense - the shield - and open her up to a strike.");
	output("\n\nThe metal spearpoint flashes as Dane’s fist carries it forward into the dented section of the nyrea’s armor. The impact reminds you of the sound of the industrial steel punches in one of your father’s factories. Dane’s hand comes away empty, the only evidence of his strike a rent in his foe’s armor and a protruding bit of wood. Thick purple blood oozes down the plate covering Queensguard’s legs, staining them with visible defeat.");
	output("\n\n<i>“Told you that you should’ve brought a gun,”</i> Dane snarls, kicking the nyrea square in the chest. She drops like a sack of bricks and curls into a ball, wincing from what must be terrible abdominal pain. <i>“Musta ruptured something other than your sperm sacks, huh? I guess not all the male nyrea get off on penetration.”</i>");
	output("\n\nDane doesn’t look much better off, but he’s still standing, somehow. He slips the shield onto his lower left arm and nods respectfully to you. <i>“Thanks for the assist. A word of advice - don’t get into the bodyguarding game. Half the job is bleeding for the boss.”</i>");
	output("\n\n<i>“Enough of this!”</i> the shocked Queen cries, leaping to her feet and grabbing her spear. <i>“I will lay you low myself!”</i>");
	output("\n\nDane looks ready to rumble, to face down your new mate - and you too, if need be. But a shrill cry from the stairwell draws his attention, and with a grunt Dane is forced to retreat, rushing to save his cowardly ward.");
	output("\n\n<i>“After him!”</i> Taivra shouts at the handful of huntresses left in the room, who rush towards the stairs. The queen leaps up a moment later, but not to pursue your cousin or [rival.hisHer] brutal bodyguard: instead, she rushes to the side of the injured Queensguard, pressing her hands to her injured subject’s abdomen. <i>“Damn them - damn them all,”</i> Taivra grunts, ripping her cape off and tying it around the wounded knight’s injury. <i>“Be still, dearest... the healers will be here soon.”</i>");
	output("\n\nYou hope so. The last thing you need is your partnership getting fucked up by your cousin - one more thorn in your side thanks to [rival.name]. While the going’s good, you hop over to the throne and touch your hand to the side of the probe, activating it. A holographic Steele Tech logo flashes across its flatscreen interface, followed by a data readout that your Codex parses into a download of coordinates - the next probe! You have what you need for your quest now, though you’ve signed away a little of yourself to get it. Maybe you should stick around and talk to your... your wife.");
	output("\n\nOr get gone while the getting’s good.");
	processTime(12);
	//9999
}

//Bad Deal
//When PC inevitably fucks up.
public function badDealWithTaivra():void
{
	clearOutput();
	showTaivra();
	showName("QUEENSGUARD\n& TAIVRA");
	showBust("QUEENSGUARD","TAIVRA");
	output("<i>“I think I’ve heard enough,”</i> Taivra yawns, leaning back in her seat and drumming her fingers on the haft of her spear. <i>“Queensguard, I tired of our intruder. [pc.name] clearly has nothing to offer me...”</i>");
	output("\n\n<i>“Aye, my queen,”</i> the dutiful nyrean knight answers, stepping between you and her queen. <i>“You had your chance, star-walker. A pity you squandered it.”</i>");
	output("\n\nYou guess this only could have ended one way. You draw your [pc.weapon] and level it at Queensguard. Time to show the queen what you’re made of.”</i>");
	output("\n\n<i>“Tear that bitch up!”</i> your cousin shouts, rattling [rival.hisHer] cage.");
	processTime(2);
	clearMenu();
	addButton(0,"Next",startCombat,"Queensguard");
}

//Queensguard Fight
//AI & Stats & Stuff:
//Level 8. Queensguard is epic tank fucker. Super high armor, damage resistance vs. penetrating, has a chance to parry any melee attack made against her. Vulnerable to crushing and ranged damage. Probably has more Health than Taivra, even. Relatively low dodge, though. Basically, she just takes a kickin’ and keeps on tickin’. PC can free Dane to automatically down her, though!
/*
output("\n\nMaybe instead of a <i>“Shield”</i> meter she has an <i>“Armor”</i> meter or something!");

output("\n\nPC can move 3 times to get to Dane, then has to attack the lock. Damgeval as %chance of breaking him out each turn. Queensguard can try and push you back (unless you’re a taur - too big to push!).");

output("\n\nCombat Text:");
output("\n\nYou’re fighting Queensguard, the knightly nyrean warrior who stands between you and Queen Taivra - and the probe that makes up her throne. The warrior before you is clad from head to toe in heavy metal plates, like a medieval soldier’s, supplementing her natural chitin with forged steel. She carries a hefty kite-style shield, bearing the same crest as the tyrant she serves’, plus a glistening longsword that twirls about her with expert skill. Clearly the queen has chosen her personal guard well!");

output("\n\nYou can see Dane and [rival.name] in their cages, just behind the valiant knight. They’re both yelling and screaming, much to the disdain of their huntresses standing guard by the cages. <b>{You’re too far away to try and break them out - and Queensguard is blocking any chance of shooting them out // You’re about half way to Dane and [rival.name]’s cages now! // You’re close enough to bash the lock to Dane’s cage if you wanted. Maybe the big bastard could help you out!}</b>");
*/

public function queensguardLongUpdate():void
{
	foes[0].long = "You’re fighting Queensguard, the knightly nyrean warrior who stands between you and Queen Taivra - and the probe that makes up her throne. The warrior before you is clad from head to toe in heavy metal plates, like a medieval soldier’s, supplementing her natural chitin with forged steel. She carries a hefty kite-style shield, bearing the same crest as the tyrant she serves’, plus a glistening longsword that twirls about her with expert skill. Clearly the queen has chosen her personal guard well!";
	foes[0].long += "\n\nYou can see Dane and [rival.name] in their cages, just behind the valiant knight. They’re both yelling and screaming, much to the disdain of their huntresses standing guard by the cages. <b>";
	if(pc.statusEffectv1("Cage Distance") == 2) foes[0].long += "You’re too far away to try and break them out - and Queensguard is blocking any chance of shooting them out.";
	else if(pc.statusEffectv1("Cage Distance") == 1) foes[0].long += "You’re about half way to Dane and [rival.name]’s cages now!";
	else foes[0].long += "You’re close enough to bash the lock to Dane’s cage if you wanted. Maybe the big bastard could help you out!";
	foes[0].long += "</b>";
}

/*New status:
"Cage Distance" - v1 = distance from cage. 2 = other side, 1 = halfway, 0 = there.
"You're a good ways away from Dane and your cousin's cage. It'll take a lot of work to reposition yourself to break them out."
"You're about halfway to Dane's cage. One good move will put you alongside it."
"You're right next to the cage! You can break out Dane (and your cousin) if you want a hand."
*/

public function queensguardAI():void
{
	//Use Fungal Extract
	//When below 60% health. Effect as per item. Up to 3/encounter.
	//if(!foes[0].hasStatusEffect("Fungaled");
	if(foes[0].HP()/foes[0].HPMax() < .6 && foes[0].statusEffectv1("Fungaled") < 3) queensGuardFungalButts();
	//Focus
	//First time QG gets to Lust 75+. Reduce lust by 30.
	else if(foes[0].lust() >= 75 && !foes[0].hasStatusEffect("Focused")) queensGuardLust();

	//Thunder Kick
	//Rare attack that staggers the PC, like a Wetraxxel.
	else if(rand(7) == 0) queensGuardThunderKick();

	else if(rand(4) == 0) queensguardShieldBash();
	//Power Attack
	//Huge damage sword strike. Chance to stun.
	else if(!pc.hasStatusEffect("Stunned") && rand(5) == 0) powerAttackQueensguard();
	
	//Slice and Dice
	//Three moderate-damage attacks. Sword, shield, sword.
	else sliceAndDiceQueenieGuardieRetardie();
}

public function queensguardWeaponToggle():void
{
	if(foes[0].meleeWeapon.longName == "shield")
	{
		foes[0].meleeWeapon.attackVerb = "slash";
		foes[0].meleeWeapon.attackNoun = "slash";
		foes[0].meleeWeapon.longName = "polished longsword";
		foes[0].meleeWeapon.baseDamage.kinetic.damageValue = 10;
	}
	else
	{
		foes[0].meleeWeapon.attackVerb = "smack";
		foes[0].meleeWeapon.attackNoun = "smack";
		foes[0].meleeWeapon.longName = "shield";
		foes[0].meleeWeapon.baseDamage.kinetic.damageValue = 0;
	}
}

//Queensguard Abilities:
//Shield Bash
//Light crushing damage. Chance to knock back a square, or knock prone if at back of arena. Physique check to resist effect.
public function queensguardShieldBash():void
{
	output("With a battle roar that reverberates off the stone walls, Queensguard charges forward shield-first, trying to slam the steel bulwark into you!");
	if(combatMiss(foes[0],pc))
	{
		output("\nYou nimbly side-step the attack, letting the nyrean knight’s momentum carry her right past you!");
	}
	else
	{
		output("\nYou catch the sides of her shield, grunting with effort and pain as steel slams against your ");
		if(!(pc.armor is EmptySlot)) output("[pc.armor]");
		else output("bare [pc.skinFurScales]");
		output(".");

		output("The sheer weight of the impact");
		if(pc.physique() + rand(20) + 1 >= foes[0].physique() + 10) output("nearly staggers you");
		else
		{
			if(pc.statusEffectv1("Cage Distance") >= 2) 
			{
				output(", forcing you back");
				pc.addStatusValue("Cage Distance",1,1);
				queensguardLongUpdate();
			}
			else
			{
				output(", knocking the wind out of you enough that the knight is easily able to strike you again, sending you flat on your back. <b>You’re knocked prone");
				if(!pc.hasStatusEffect("Trip")) pc.createStatusEffect("Trip", 0, 0, 0, 0, false, "DefenseDown", "You've been tripped, reducing your effective physique and reflexes by 4. You'll have to spend an action standing up.", true, 0);
			}
		}
		output("!");
		//Swap in shield and back out to sword
		queensguardWeaponToggle();
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
		queensguardWeaponToggle();
	}
	processCombat();
}

//Slice and Dice
//Three moderate-damage attacks. Sword, shield, sword.
public function sliceAndDiceQueenieGuardieRetardie():void
{
	output("Queensguard charges you, swinging her blade in a wide arc. You ");
	if(combatMiss(foes[0],pc)) output("parry it");
	else
	{
		output("stagger back as it strikes you");
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
	}
	output(", only to ");
	if(!combatMiss(foes[0],pc)) 
	{
		output("be slammed with her shield a moment later");
		queensguardWeaponToggle();
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
		queensguardWeaponToggle();
	}
	else output("have to dodge a shield swipe a second later");
	output(". A third strike, with her sword again this time, follows up, lunging for your chest. You ");
	if(combatMiss(foes[0],pc)) output("barely manage to dodge it");
	else
	{
		output("yelp as the blade slams into you, leaving you reeling");
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
	}
	output("!");
	processCombat();
}

//Power Attack
//Huge damage sword strike. Chance to stun.
public function powerAttackQueensguard():void
{
	output("The nyrean knight bellows out a warcry and leaps at you, sword held overhead for a brutal strike! ");
	if(combatMiss(foes[0],pc))
	{
		output("You manage to dodge, avoiding what could very well have been a lethal blow!");
	}
	else
	{
		output("You try and block, but to no avail! Queensguard’s sword slams into you with bone-crushing force, throwing you back and leaving you reeling.");
		var damage:TypeCollection = foes[0].damage();
		damage.add(foes[0].physique() / 2);
		damage.multiply(2);
		damageRand(damage, 15);
		applyDamage(damage, foes[0], pc, "melee");
		if(foes[0].physique()/2 + rand(20) + 1 >= pc.physique()/2 + 10 && !pc.hasStatusEffect("Stunned"))
		{
			output("\n<b>You’re stunned by the blow!</b>");
			pc.createStatusEffect("Stunned",2,0,0,0,false,"Stun","Cannot act for a turn.",true,0);
		}
	}
	processCombat();
}

//Use Fungal Extract
//When below 60% health. Effect as per item. Up to 3/encounter.
//if(!foes[0].hasStatusEffect("Fungaled");
public function queensGuardFungalButts():void
{
	output("Queensguard grabs a vial from her belt and pulls up her helm’s visor, just enough to knock back the soupy liquid within - and give you a hint of a scarred, but firmly feminine face underneath. (+50 HP)");
	foes[0].HP(50);
	if(!foes[0].hasStatusEffect("Fungaled")) foes[0].createStatusEffect("Fungaled",0,0,0,0);
	else foes[0].addStatusValue("Fungaled",1,1);
	processCombat();
}

//Thunder Kick
//Rare attack that staggers the PC, like a Wetraxxel.
public function queensGuardThunderKick():void
{
	output("Queensguard feints, drawing your defenses to her sword, only to kick you square in the gut. You stumble back, but she’s not done yet: the knight pirouettes and slams her shield into you, <b>leaving you staggered</b>.");
	if (pc.hasStatusEffect("Staggered"))
	{
		pc.setStatusValue("Staggered", 1, 5);
	}
	else
	{
		pc.createStatusEffect("Staggered", 5, 0, 0, 0, false, "Icon_OffDown", "You're staggered, and your Aim and Reflexes have been reduced!", true, 0);
	}
	applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
	processCombat();
}

//Focus
//First time QG gets to Lust 75+. Reduce lust by 30.
public function queensGuardLust():void
{
	output("<i>“Calm yourself, dearest,”</i> Taivra murmurs from her throne, still fucking away at her harem with her bushel of tentacle cocks. <i>“Focus on the fight.”</i>");
	output("\n\nQueensguard tries to nod, but you can see her breathing hard... see her knees quaking ever so slightly. She clearly wants what you’re selling!");
	output("\n\n<i>“Beat this star-walker, my guardian, and I promise I will breed you. It’s been so many years, hasn’t it? Do you even remember what it’s like to feel your belly swelling with our young? Think of me, my dearest - don’t let your lusts wander from me now.”</i>");
	output("\n\nThe Queensguard takes a deep breath to steady herself, turning her amethyst-colored eyes to you with renewed vigor.");
	foes[0].lust(-30);
	output(" (-30 Lust)");
	foes[0].createStatusEffect("Focused",0,0,0,0);
	processCombat();
}

//Special Combat Actions
//PC can move East/West, with west taking you towards Dane and Rival.
public function moveToCage():void
{
	clearOutput();
	if(pc.statusEffectv1("Cage Distance") == 2) output("You try to work your way closer to the cage holding Dane and [rival.name] but only manage to close about half the distance.");
	else if(pc.statusEffectv1("Cage Distance") == 1) output("Working across the room, you close the rest of the way with Dane's cage. <b>Maybe you can break him out?</b>");
	output("\n");
	pc.addStatusValue("Cage Distance",1,-1);
	queensguardLongUpdate();
	processCombat();
}

//At the 3rd square, can [Breakout]
//Breakout
//Try and break Dane out - that big, burly ausar might just level the playing field!
public function breakOutDane():void
{
	clearOutput();
	output("You’ve got a clear shot at Dane’s cage now, and the ausar knows it. <i>“Get me out of here!”</i> he growls, eyeing Queensguard dangerously. <i>“C’mon already!”</i>");
	output("\n\nYou take aim at the lock and strike!");
	//{Unfortunately for you, the lock isn’t completely destroyed by your attack - you’ll need to try again! //else, [Next] to Dane Breakout Fen wrote}");
	showName("DANE &\nQUEENSGUARD");
	showBust("DANE_NUDE","QUEENSGUARD");
	output("\n\nAs soon as you destroy the cage’s primitive lock, Dane is surging into action. The big ausar combat rolls into the door, smashing it fully open with his muscular bulk. His hands wrap around the haft of his warden’s spear, and with a simple tug, the weapon is liberated from the gape-mouthed nyrea. As big as Dane is, the spear looks like a toothpick in his hammer-thick hands. He growls, deep in his throat and snaps it in two, simultaneously backhanding the surprised cave-dweller into the wall with one of his free hands.");
	output("\n\nThe alabaster ausar is utterly naked, stripped of his gear and bruised from his capture, but he’s grinning like a mad dog all the same. The veins on his arms bulge as he flexes his corded muscles, flipping the pieces of primitive weaponry down to his lower arms to hold like daggers. <i>“You should’ve killed me when you had the chance. This time you won’t get a chance to jump me in the dark.”</i>");
	output("\n\n<i>“Slaves should learn their place,”</i> Queensguard answers, lowering her shield into place and readying her sword. <i>“If they cannot fathom that, then they will be fed to the deeps, piece by piece.”</i> She advances steadily, one plated boot in front of the other warily moving to intercept Dane.");
	output("\n\n<i>“That’s all you’ve got? Not even a gun?”</i> Dane grins, cracking a pair of his knuckles.");
	output("\n\nConfusion briefly crosses Queensguard’s face. <i>“You are naked with naught but a broken weapon. I have no need of a dishonorable star-blaster.”</i>");
	output("\n\n<i>“If you had a gun, you might have had a chance.”</i>");
	output("\n\nYou wouldn’t have thought a guy as big as Dane could lunge so far and so fast if you hadn’t tangled with him once already, and the armored nyrea clearly doesn’t share that experience. She only has time for her eyes to widen in surprise before Dane crashes into her in a flash of albino fur and pounding fists, driving her back half a pace. The broken haft of the spear shatters on impact with her armor-plated side, visibly denting the plate. Knuckles deflect off Queensguard’s helm, leaving lines of blood behind where the sharp metal ripped into Dane’s knuckles.");
	output("\n\nFor all his power and speed, it’s clear that your cousin’s bodyguard is more a brawler than a trained fighter. He doesn’t try to avoid harrowing slashes from Queensguard’s sword, relying on the awkward positioning to rob the strength from her blows and his thick fur to keep her from cutting too deeply. Dane’s left forearms are soon matted red with blood from a half-dozen surface cuts, but none so deep as to stop him from grabbing hold of his foe’s shield in two hands wrenching it powerfully to the side.");
	output("\n\nQueensguard is no brawler. She’s a fighter, used to tackling her Queen’s enemies in one on one confrontations. She lets her arm slide out of the shield’s strap and spins with the momentum, twisting around for a vicious, back-handed slice. A diagonal rent opens up across Dane’s chest, deep enough to reveal two or three blood-drenched bones but not quite deep enough to bring down the mighty ausar. His rage filled blood leaves steaming, crimson puddles on the ground between them.");
	output("\n\nDane staggers a half-step back from the pain, but he doesn’t drop the shield. He leans further back, sweeping the shield up and into the underside of Queenguard’s polished blade. The clang of metal on metal reverberates through the cavernous chamber as the two bodyguards struggle. The nyrea barely keeps her grip on her weapon, but Dane never needed to disarm her, just take away her biggest defense - the shield - and open her up to a strike.");
	output("\n\nThe metal spearpoint flashes as Dane’s fist carries it forward into the dented section of the nyrea’s armor. The impact reminds you of the sound of the industrial steel punches in one of your father’s factories. Dane’s hand comes away empty, the only evidence of his strike a rent in his foe’s armor and a protruding bit of wood. Thick purple blood oozes down the plate covering Queensguard’s legs, staining them with visible defeat.");
	output("\n\n<i>“Told you that you should’ve brought a gun,”</i> Dane snarls, kicking the nyrea square in the chest. She drops like a sack of bricks and curls into a ball, wincing from what must be terrible abdominal pain. <i>“Musta ruptured something other than your sperm sacks, huh? I guess not all the male nyrea get off on penetration.”</i>");
	output("\n\nDane doesn’t look much better off, but he’s still standing, somehow. He slips the shield onto his lower left arm and nods respectfully to you. <i>“Thanks for the assist. A word of advice - don’t get into the bodyguarding game. Half the job is bleeding for the boss.”</i>");
	output("\n\n<i>“Enough of this!”</i> the shocked Queen cries. <i>“I will lay you low myself!”</i>");
	if(pc.isBimbo()) output("\n\nYou giggle at Dane. <i>“Got time for one more, hunk?”</i>");
	else if(pc.isNice()) output("\n\nYou smile at Dane. <i>“Ever taken down a queen before?”</i>");
	else if(pc.isMischievous()) output("\n\nYou favor Dane with a roguish grin. <i>“Don’t bleed out yet. There’s still a queen to take care of, remember?”</i>");
	else output("\n\nYou glance Dane’s way. <i>“You owe me. Think you can keep from passing out long enough to depose some royalty?”</i>");
	output("\n\nDane rolls his shoulders and silently nods, his cold glare locking on the creature responsible for his imprisonment. <i>“Yeah, I’m game.”</i>");
	pc.energy(40);
	pc.shields(pc.shieldsMax());
	//Pass 1 minute, +40 energy to queen and PC. Refill shields for both parties.
	flags["FREED_DANE_FROM_TAIVRA"] = 1;
	spankedQueensguardsAss();
}

//Queensguard wins: loseToQueensTaivra

//Queensguard Defeated
//PC solo’d dat bitch.
public function spankedQueensguardsAss():void
{
	if(flags["FREED_DANE_FROM_TAIVRA"] == undefined) clearOutput();
	if(foes[0].HP() <= 0) 
	{
		output("With a groan of pain, Queensguard collapses to a knee, barely keeping herself upright with all her weight on her blade. She glowers up at you through the slit in her visor, panting hard and coughing up blood into the steel helm.");
		output("\n\n<i>“What... what </i>are<i> you!?”</i> she stammers, trying and failing to stand again.");
	}
	else
	{
		output("Queensguard falls to her knees, the resistance bleeding out of her in pitiful moans as she clutches at her restrictive plate armor, trying to tear the metal from her flushed flesh.");
		output("\n\n<i>“I... I can’t... I can’t...”</i> she cries out, looking between you and her queen.");
	}
	//Combine: + w/ Post Dane Breakout
	output("\n\n<i>“Enough!”</i> Queen Taivra bellows, rising to her feet for the first time since you entered her throne room. Her towering longspear sweeps forward, levelling dead at your chest. The writhing mass of bodies surrounding Taivra’s throne all moan and cry out as the tentacle-cocks buried inside them shift with their queen.");
	output("\n\nThe nyrea queen’s tentacles flare out behind her as she steps down from the dias. She gives her spear a menacing flourish, closing the distance with a fearsome confidence. <i>“Queensguard, stand down. It appears ");
	if(flags["FREED_DANE_FROM_TAIVRA"] == undefined) output("this off-worlder is too much for you.");
	else output("these star-walkers truly have no honor.");
	output(" Very well, it’s been much too long since I’ve bloodied my spear.”</i>");

	if(flags["FREED_DANE_FROM_TAIVRA"] == 1) output("\n\n<i>“You won't get the chance!”</i> the over-sized ausar grunts.”</i>");
	processTime(2);
	clearMenu();
	addButton(0,"Next",startCombat,"Taivra");
}

//Queen Taivra Fight
//AI & Stats & Stuff
//Queen Taivra fights with a mix of lust and physical abilities: maybe ⅔ lust, ⅓ physical. She has high health, a very high dodge chance, but relatively light armor. Also unlike queensguard, has very high shields. All of Taivra’s physical attacks have a chance to inflict Bleeding if they deal Health damage.

//Combat Text
//You’re facing down Queen Taivra, an alpha nyrea powerful enough to subjugate an entire city of her amazonian sisters. She stands nearly six feet tall, with pale yellow flesh left largely bare by her revealing armor - if you could call it that. She wears a bikini-style vest and bottom of padded chainmail, showing off her ample cleavage and her firm muscles and belly. Leather bracers and pauldrons adorn compliment her armor, and a blood red cape flows from her shoulders. A black Reaper shield belt hangs loosely from her hips, a trophy taken from an off-worlder, no doubt, and now adorned with fetishes and potion vials.

//The queen’s long black hair is tied into a tight ponytail behind her elfin ears, and her pitch-black eyes regard you with {if w/ Dane: cold contempt. //else: playful mirth, like a cat stalking her prey}. Her purple lips twist in a smile, and she twirls her towering longspear about herself in a series of flourishes and feints that would have impressed a core-world martial artist.

//{if Dane: Dane, your cousin [rival.name]’s four-armed ausar bodyguard, is standing at your side. Though wounded by Queensguard, he’s still managing to stand - if only barely. He might not be at full strength, but it’s reassuring to have somebody watching your back.}

//Queen Taivra Abilities
//Spear Sweep
//Heavy slashing damage, hits both Dane and the PC
public function taivraSpearSweep():void
{
	output("Taivra swings her spear in a wide arc, savagely slashing at you");
	if(flags["FREED_DANE_FROM_TAIVRA"] == 1) output(" and your companion");
	output("! You ");
	if(flags["FREED_DANE_FROM_TAIVRA"] == 1) output(" and Dane are");
	else output("is");
	if(combatMiss(foes[0],pc))
	{
		output(" able to dodge the strike.");
	}
	else
	{
		foes[0].meleeWeapon.damage += 20;
		output(" struck by the sweeping spear!");
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
		foes[0].meleeWeapon.damage -= 20;
	}
	output(" The nyrean queen sneers, twirling the haft around herself is a buzzing ring that cuts the air.");
	processCombat();
}

//Strike and Slash
//Taivra hits with the butt of her spear for light Crushing + Stun chance, then a moderate spear attack.
public function strikeAndSlash():void
{
	output("Taivra spins around, twirling her spear backwards before striking out at you. The butt of her spear ");
	if(combatMiss(foes[0],pc)) output("comes crashing down at your head.\nYou barely sidestep it!");
	else 
	{
		foes[0].meleeWeapon.damage -= 10;
		output("comes crashing down on your head, hard.");
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
		foes[0].meleeWeapon.damage += 10;
		if(foes[0].physique()/2 + rand(20) + 1 > pc.physique()/2 + 10 && !pc.hasStatusEffect("Stunned"))
		{
			output(" <b>You are stunned!</b>");
			pc.createStatusEffect("Stunned",2,0,0,0,false,"Stun","You cannot act until you recover!",true,0);
		}
	}
	output(" A moment later and she’s dancing around you, slashing at you with the sharp end.");
	if(combatMiss(foes[0],pc)) output("\nYou barely dodge aside!");
	else
	{
		applyDamage(foes[0].meleeDamage(), foes[0], pc, "melee");
	}
	processCombat();
}

//Cocktease
//Moderate lust attack
public function taivraCockTease():void
{
	output("The queen saunters forward, long, bare legs carrying her towards you with a lascivious smile on her face. One of her thumbs hooks into the leather strap holding up her chain bottom, and the garment slides down to reveal the throbbing length of her equine-like cock, drooling with moisture from its X-shaped slit.");
	output("\n\n<i>“Come now,”</i> she purrs, stroking the shaft. <i>“Surrender now, and I’ll keep you as a favored pet. You’ve earned that much... perhaps I’ll even let you carry a clutch of my spawn.”</i>");
	output("\n\n");

	if(pc.willpower()/2 + rand(20) + 1 >= 26) output("You shrug off the nyrea’s advances.");
	else 
	{
		output("You have to admit, the idea is uncomfortably tempting...");
		applyDamage(new TypeCollection( { tease: 18 } ), foes[0], pc, "minimal");
	}
	if(flags["FREED_DANE_FROM_TAIVRA"] == 1)
	{
		if(rand(2) == 0) output("\nDane seems oddly taken with the queen...");
		else output("\nDane sneers at the queen’s offer, clearly not ready to be her next bottom bitch.");
	}
	processCombat();
}

//Tentacle Cocks
//Several light tease attacks
public function tentacleCocks():void
{
	output("Swinging her hips like a whore on strut, Taivra runs her free hand along the lengths of several of her parasitic tentacle cocks. Her betas moan and squirm as the tails probing their sexes move and thrust. <i>“You know you want it,”</i> the queen teases, slapping her ass in a way that makes her taut cheeks and squirming tails quake.");
	output("\n\n");
	for(var x:int = 0; x < 4; x++)
	{
		if(pc.willpower()/2 + rand(20) + 1 >= 26) output("\nYou shrug off the nyrea’s advances.");
		else
		{
			output("\nGetting railed by a dozen tentacle cocks... now that’s something new!");
			applyDamage(new TypeCollection( { tease: 5 } ), foes[0], pc, "minimal");
		}
	}
	processCombat();
}

//Lust Fungus
//Moderate lust-drug attack, deals lust over time for a couple rounds.
public function lustFungus():void
{
	output("Taivra grabs a vial of some pink fungal compound off her belt and hurls it at you.");
	if(rangedCombatMiss(foes[0],pc)) output("\nYou dodge it and the vial shatters harmlessly against the stone wall.");
	else
	{
		output("\nThe vial shatters against your chest, bursting into a cloud of pink mist. You cough as the mist billows out, making your eyes water and flesh tingle. <b>You are surrounded by a cloud of lust-drug!</b>");
		applyDamage(new TypeCollection( { drug: 6 } ), foes[0], pc, "minimal");
		//4 rounds of lust damage!
		if(!pc.hasStatusEffect("Aphro Gas")) pc.createStatusEffect("Aphro Gas",5,4,0,0,false,"Icon_DrugVial","A cloud of aphrodisiac hangs in the air, turning you on as you breathe!",true,0);
		else 
		{
			output(" <b>The chemical in your air is getting stronger!</b>");
			pc.addStatusValue("Aphro Gas",1,3);
			pc.setStatusValue("Aphro Gas",2,4);
		}
	}
	processCombat();
}

//Pocket Sand
//Blinds PC if he fails a Reflex save.
public function pocketSandAttack():void
{
	output("Taivra grabs a sack from her belt and hurls it at you, letting the thing tumble open in a cascade of fine grains of powdered rock. You’re smashed right in the face with a hail of sand! <b>You’re blinded!</b>");
	pc.createStatusEffect("Blind",2+rand(3),0,0,0,false,"Blind","Accuracy is reduced, and ranged attacks are far more likely to miss.",true,0);
	processCombat();
}

//Special Combat Actions:
//Slavegasm
//Play at the end of each of Taivra’s turns when she has any Lust. Reduces her lust by 10.
public function taivraConstantLustReduction():void
{
	output("Taivra’s back arches and moans. You cock an eyebrow curiously, until you realize that one of her tentacle cocks is throbbing, squirting seed into one of her beta sluts. The queen gives a sated sigh, looking calmer and more collected even as her bottom bitch’s psuedo-cock erupts in a shower of juice and cum.\n");
	foes[0].lust -= 10;
}

//Flurry Attack
//Taivra makes a Flurry attack after any turn!
public function taivraBonusAttackShit():void
{
	output("The queen follows through with a quick jab at you, thrusting at your chest.\n");
	attack(foes[0],pc,true,1);
	output("\n");
}

//COUSIN DOUCHEBAGGERY
//Play during Queen Taivra combat if Dane’s free. Cousin gets free and buggers off.
public function cousinDouchebaggery():void
{
	output("As you’re engaged with Taivra, you notice movement in the shadows behind her throne. Between warding off spear-thrusts and keeping yourself out of Dane’s berzerker swings, it takes you a moment to realize what’s going on: your scumbag cousin’s gotten free, and [rival.heShe]’s trying to get to the probe! [rival.HeShe] must have picked the lock after Dane wrecked the guards.");
	output("\n\nShit! You try and push forward to stop [rival.himHer], but the damn bug-queen almost spears you through the chest for your troubles. She forces you back with a flurry of strikes, refusing to let you anywhere near her throne... even as [rival.name] plants [rival.hisHer] hand on the scanner and activates it. DAMMIT!");
	output("\n\nYou cousin flashes you a shit-eating grin as the probe’s coordinates download onto [rival.hisHer] Codex. " + chars["RIVAL"].mf("Jack gives you a sarcastic salute","Jill blows you an over-acted kiss") + " before leaping off the back of the throne and scampering off. Looks like you’re getting left in the dust again...\n");
	flags["RIVAL_GOT_MYR_COORDS_FIRST"] = 1;
	//[Next] //back to fitan
}

//PC Defeats Taivra
public function whupTaivrasAss():void
{
	clearOutput();
	output("The queen stumbles back, jabbing the tip of her spear into the ground and leaning hard against it. <i>“You... you fight like a beast,”</i> the queen groans, barely standing. Her harem gasps in shock, clutching at the queen’s legs as Taivra struggles not to stumble.");
	output("\n\n<i>“I yield, offworlder. I yield,”</i> she sighs, letting her spear clatter to the ground at your [pc.footOrFeet]. Without the long shaft to support her, Taivra slumps to the ground, sitting down at the edge of her throne’s dias. All of a sudden, the once-proud warrior queen looks a lot less self-assured. Almost humble in her defeat.");

	//if Dane Freed:
	if(flags["FREED_DANE_FROM_TAIVRA"] == 1)
	{
		output("\n\nYou hear a shout behind you. Grabbing your [pc.weapon], you spin around just in time to see Dane pulling [rival.name] through the curtain towards the palace’s gates. Shit! Some of the guards try and grab them, but the towering ausar throws them aside like grainsacks, and all you see is your erstwhile battle partner’s bare ass and tail bursting through the curtains.");
		output("\n\nYou sigh. Can’t leave the nyrea to go after them... not unless you want a repeat fight when you get back. You’ll have to settle up now, while you still can.");
		output("\n\nYou turn back to Taivra, and find that she’s dragged her injured bodyguard over to her: she’s pulled Queensguard’s helmet off and rested the knight’s head in her lap, stroking her black hair with one hand and binding her wounds with the other.");
	}
	//If Dane Not Freed:
	else
	{
		output("\n\nAs you’re thinking of all the things you could do with the beaten queen, you hear a roar and the rending of steel behind you. You pull your [pc.weapon] and spin around, just in time to see Queensguard lurching to her feet with sword drawn... and Dane looming over her, putting himself between you and the nyrea and your cousin as [rival.heShe] makes a break for the door.");
		output("\n\nThe alabaster ausar is utterly naked, stripped of his gear and bruised from his capture, but he’s grinning like a mad dog all the same. The veins on his arms bulge as he flexes his corded muscles, holding torn bits of his cage like daggers. <i>“You should’ve killed me when you had the chance. This time you won’t get a chance to jump me in the dark.”</i>");
		output("\n\n<i>“Slaves should learn their place,”</i> Queensguard answers, lowering her shield into place and readying her sword. <i>“If they cannot fathom that, then they will be fed to the deeps, piece by piece.”</i> She advances steadily, one plated boot in front of the other warily moving to intercept Dane. Looks like she’s already recovered from your battle.");
		output("\n\n<i>“That’s all you’ve got? Not even a gun?”</i> Dane grins, cracking a pair of his knuckles.");
		output("\n\nConfusion briefly crosses Queensguard’s face. <i>“You are naked with naught but a shard of steel. I have no need of a dishonorable star-blaster.”</i>");
		output("\n\n<i>“If you had a gun, you might have had a chance.”</i>");
		output("\n\nYou wouldn’t have thought a guy as big as Dane could lunge so far and so fast if you hadn’t tangled with him once already, and the armored nyrea clearly doesn’t share that experience. She only has time for her eyes to widen in surprise before Dane crashes into her in a flash of albino fur and pounding fists, driving her back half a pace. The broken chunk of metal bends on impact with her armor-plated side, visibly denting the plate. Knuckles deflect off Queensguard’s helm, leaving lines of blood behind where the sharp metal ripped into Dane’s knuckles.");
		output("\n\nFor all his power and speed, it’s clear that your cousin’s bodyguard is more a brawler than a trained fighter. He doesn’t try to avoid harrowing slashes from Queensguard’s sword, relying on the awkward positioning to rob the strength from her blows and his thick fur to keep her from cutting too deeply. Dane’s left forearms are soon matted red with blood from a half-dozen surface cuts, but none so deep as to stop him from grabbing hold of his foe’s shield in two hands wrenching it powerfully to the side.");
		output("\n\nQueensguard is no brawler. She’s a fighter, used to tackling her Queen’s enemies in one on one confrontations. She lets her arm slide out of the shield’s strap and spins with the momentum, twisting around for a vicious, back-handed slice. A diagonal rent opens up across Dane’s chest, deep enough to reveal two or three blood-drenched bones but not quite deep enough to bring down the mighty ausar. His rage filled blood leaves steaming, crimson puddles on the ground between them.");
		output("\n\nDane staggers a half-step back from the pain, but he doesn’t drop the shield. He leans further back, sweeping the shield up and into the underside of Queenguard’s polished blade. The clang of metal on metal reverberates through the cavernous chamber as the two bodyguards struggle. The nyrea barely keeps her grip on her weapon, but Dane never needed to disarm her, just take away her biggest defense - the shield - and open her up to a strike.");
		output("\n\nThe metal chunk flashes as Dane’s fist carries it forward into the dented section of the nyrea’s armor. The impact reminds you of the sound of the industrial steel punches in one of your father’s factories. Dane’s hand comes away empty, the only evidence of his strike a rent in his foe’s armor and a protruding bit of wood. Thick purple blood oozes down the plate covering Queensguard’s legs, staining them with visible defeat.");
		output("\n\n<i>“Told you that you should’ve brought a gun,”</i> Dane snarls, kicking the nyrea square in the chest. She drops like a sack of bricks and curls into a ball, wincing from what must be terrible abdominal pain. <i>“Musta ruptured something other than your sperm sacks, huh? I guess not all the male nyrea get off on penetration.”</i>");
		output("\n\nDane doesn’t look much better off, but he’s still standing, somehow. He slips the shield onto his lower left arm and starts backpedaling as the queen screams and her remaining betas leap towards the ausar with vengeance on their minds. Dane grunts and falls back, covering your cousin’s escape until they’re both through the curtain and out of sight.");
		output("\n\nYou can’t even go after them - not unless you want a repeat fight when you get back. You’ll have to settle up now, and wait to deal with [rival.name] until another time...");
		output("\n\nCursing, you put your weapon away and turn back to Taivra. she’s pulled Queensguard’s helmet off and rested the knight’s head in her lap, stroking her black hair with one hand and binding her wounds with the other.");
	}
	//Combine:
	output("\n\n<i>“Be still, dear,”</i> the queen whispers to her bodyguard, stroking the warrior’s hair. <i>“It’s not as bad as you think.”</i>");
	output("\n\nGlancing up at you, Taivra sighs wearily. <i>“I clearly underestimated you, [pc.name]. And the ruthlessness of your cousin’s guardian. A mistake I will not make again. But for now, I am at your mercy. Let my people go unharmed, and I will do whatever you wish.”</i>");
	output("\n\nFirst thing’s first: you step past the defeated nyrea and plant your hand on the probe, letting it read your DNA and confirm you as its rightful owner. Your Codex receives a data transfer a moment later, loaded out with the next set of coordinates you need to continue your quest! <b>Now that you have what you need, what do you do with the nyrea...?</b>");

	//[Fuck Taivra] [Kill Taivra] [Subjugate] [Leave]
	//Any option gets you a Taivra’s Spear. Killing Tairvra gets you a Reaper Mk. I Shield Generator. Regardless, Steele will have the probe taken into town for Steele Tech to retrieve it - get 20,00 Credits. Item descripts follow.
}

//Leave
//You don’t need anything else from the nyrea. Take your leave.
public function leaveTaivraLikeABaws():void
{
	clearOutput();
	showTaivra();
	output("<i>“I don’t want anything from you,”</i> you say simply, turning to leave.");
	if(!pc.isAss()) output(" <i>“It didn’t have to end this way.”</i>");

	output("\n\n<i>“Surprising,”</i> the queen says, her tone unreadable. <i>“Thank you, [pc.name]. You are more... magnanimous than I would have expected. More than I would have been, in your shoes. I offer you my spear, if you’d have it. A token of my thanks. It has served me well through two decades of battle. May it find your cousin’s heart someday.”</i>");
	output("\n\nA generous gift indeed. You pick up Taivra’s spear from the dias and give it an experimental twirl before tucking it under your arm. A fine weapon, indeed.");
	output("\n\n<i>“Have your people take the probe into the village. My company will retrieve it there,”</i> you instruct.");
	output("\n\nYou give the queen a curt nod and stride out of the room, making your way back out of the nyrean palace and back to the deep caves.");
	output("\n\nTime to see what the next planet has in store!\n\n");
	processTime(5);
	genericVictory();
}

//Kill Taivra
//The nyrea have been a constant threat on this planet, and would have done far worse. Kill the queen to keep her and her people from bothering you - and any other offworlder - ever again.
//Alpha Nyrea encounter rate drops to almost nothing. Betas suffer a slight encounter reduction up top, and a severe one in the deep caves. Taivra doesn’t own ALL the nyrea, after all, but her people won’t bother the PC again.
//PC gets spear, shield belt, and a satchel gemstones (see Queen’s Chamber). Also HUGE +Hardness Personality.
public function killTaivraYouMonster():void
{
	clearOutput();
	showTaivra();
	pc.addHard(15);
	output("You grab the queen’s spear and give it an experimental twirl before striding forwards. Queensguard tries to get up, tries to intercept you, but Taivra holds her down. <i>“Let it pass, dear,”</i> the queen whispers, turning to face you with a smile.");
	output("\n\n<i>“I could not have picked a worthier foe,”</i> she says, barely a whisper. <i>“Do as you will.”</i>");
	output("\n\nA moment later, and the deed is done. You rip your spear from Taivra’s chest and help yourself to the queen’s other belongings: her shield belt and the gemstones on her belt. Queensguard sobs quietly, cradling the body of her fallen ruler as you take what you want and depart. <i>“Have the probe brought to town, or I’ll come back and take it myself,”</i> you command. After all, Steele Tech is willing to pay a premium to recover them, apparently. None of the remaining nyrea dare to disturb you as you stride out of the dungeon, back onto the trail of your scumbag cousin.\n\n");
	flags["KILLED_TAIVRA"] = 1;
	processTime(5);
	//9999 add shield belt and satchel to loot, then watch the game engine implode.
	genericVictory();
}

//Fuck Taivra
//Take your frustrations out on the nyrean queen. It’s the least you deserve for conquering her and her people.
public function fuckTaivra():void
{
	clearOutput();
	showTaivra();
	output("You grab the defeated queen’s spear and levels its jagged tip at her chest. She’d have made you her sex slave had you lost, so it’s only fair you at least get to sample her at least he once. You curtly tell her that you’ll leave her people in peace if she surrenders her body to you - a prospect she should be intimately familiar with.");
	output("\n\n<i>“I suppose you’ve earned it,”</i> the queen admits, beckoning one of her submissives over to tend to Queensguard. She stands after that, geting pushing the tip of your spear out of the way. <i>“I’ll come willingly. To my chambers, then?”</i>");
	output("\n\nOh, no. You want every last one of Taivra’s followers to see what happens when you get between a Steel and [pc.hisHer] prize. You grab the queen’s wrist and twist her around, shoving her down onto the dias at the foot of her throne. She grunts, biting back a yelp of surprise as she’s forced down, and your hands grab the hem of her mail panties. One good yank and she’s bared to the air, her full cheeks swaying and a forearm-length shaft of pink ovipositor dangling between her legs. You grin, seeing a dark ring of asshole winking at you between her cheeks, though no feminine sex in sight");
	//if read codex:
	if(9999 == 0) output(", as you would expect for her race");
	output(". She gives you a darkly reproachful look over her shoulder, but does not resist as you decide just how to take your pent-up lusts out on the amazonian insect...");
	processTime(4);
	//9999 choose fuckmethod!
}

//Fuck Her Ass
//Taivra’s already bent over, ass in the air. Grab your cock and thrust into her tight-looking ass!
public function fuckTaivrasAss():void
{
	clearOutput();
	showTaivra();
	output("That ass looks absolutely irresistible, and is completely at your mercy. You lick your lips and sidle up behind the fallen queen, running your [pc.hand] along the smooth curve of her rump. The remnants of her collected harem look on with silent awe as the once-intractable queen submits to you. A few drag away her wounded bodyguard, tending to her wounds; others moan with arousal, their hands moving towards their own armored groins.");
	output("\n\n<i>“Get it over with, then,”</i> Taivra growls, her voice icy. Apparently she doesn’t appreciate the public embarrassment");
	if(pc.isAss() || pc.exhibitionism() >= 66) output(" though it gets you off like nothing else! Reaming the queen in full view of her elite guard... the idea sends a shiver of pleasure up your spine");
	else output("; then again, the idea of banging the queen in public, even for a good reason, makes your cheeks flush");
	output(". Your free hand, meanwhile, hefts up [pc.oneCock] as you slip down behind Taivra, angling your member towards her behind.");

	var x:int = pc.cockThatFits(foes[0].vaginalCapacity());
	if(x < 0) x = pc.smallestCockIndex();

	output("\n\nYou pause just before pushing in, realizing that this high and mighty warrioress is probably not quite used to getting pounded from behind: she’ll be tight, of that you’re sure, but the idea of going at her ass without lube is less than exciting. Lucky you, Taivra has plenty of means of providing what you need.");

	output("\n\nWith a devilish grin, you draw your hand up from the queen’s firm behind to the twelve thick, green bases growing from her back just above her ass. She gasps, gritting her teeth as your hand slips up the stalk of one of her tails, thumb rubbing against the cock-like crown. You start to stroke it, caressing the tumescent green shaft until it beads with creamy white pre. Twisting the viney cock-tail around, you point it at the clenched ring of the queen’s behind, stroking faster until she’s panting and rocking her hips, trying to hold back from your vigorous advances.");

	output("\n\n<i>“The sooner you cum, the faster we’re done,”</i> you whisper to her, quiet enough for the rest of her harem not to hear. You punctuate the command with a rough slap on her ass, making the muscular flesh bounce. Taivra growls like a wild animal, snarling with her head held high - defiant even as you feel her tail-cock bulge and throb in your hand. She gasps, and the parasitic tail-prick spurts a thick stream of cum across the channel of her crack, smearing her behind with her own hot seed. You breathe in deep, smelling the musky aura of sweat and sex radiating off of the disgraced, cum-drenched queen.");

	output("\n\nNow that her booty has been thoroughly blasted with spunk, you grab a second of her bushel of tentacles and start to massage it. Post orgasm, the queen seems even more sensitive than before, digging her nails against the stone and moaning openly, unable to hide her pleasure and embarrassment. You can’t help but laugh as her stoicism is eroded into helpless cries of pleasure. You take the head of this second cock-tail and rub it through the mess of spooge drooling off of Taivra’s ass, lubing up the first inches of the shaft in as much of the sticky, hot tail-semen as possible before pressing the slick crown against her dark hole.");

	output("\n\nThe queen gasps as you force her tail into her tail-hole, eyes going wide as she’s made to violate herself. The cum-slathering makes the penetration relatively easy, and with a little elbow grease you’re able to feed more and more of the tentacle-like appendage into her asshole until she’s nearly hilted herself. You pull back after that, dragging foot after foot of squirming tendril back out until just the cockhead remains inside.");

	output("\n\nAny hint of resistance in the warrior woman is long gone now, and all twelve of her tentacle dicks are throbbing and drooling around her; even her ovi-cock is at full mast and leaking a brightly-colored mix of juices onto the stone beneath her. If you didn’t know better, you’d say Taivra was enjoying her punishment... how embarrassing! You doubt the proud amazon will ever live this down....");

	output("\n\nA few more pumps into her butt and the queen screeches, thrusting her hips back and cumming - this time from both ends! Her huge ovipositor erupts in a colorful geyser of sticky fem-juices, and her bundle of tail-cocks all shoot their individual loads of white seed, blasting her hips, ass, and the floor with cum. More importantly, though, the tentacle rammed up her butt pops its nut inside, basting the insides of her ass with the best lube there is.");

	output("\n\nTaivra pants and gasps, her chest heaving against her padded bra. <i>“You...”</i> she starts to say, trailing off into a high-pitched moan as you drag her spent tendril from her rump, letting it pop free with a wet squelch; her ass drools a steady trickle of whiteness after you remove the parasitic plug, splattering onto her thighs and chitin plates.");

	output("\n\n<i>“That’s better,”</i> you grin, letting her tentacles go free and grabbing your own [pc.cock " + x + "] and press its [pc.cockHead " + x + "] into the sloppy mess you’ve left on Taivra’s ass. She grunts and pointedly looks away, refusing to humor you. Now that’s just rude. You slap her ass, digging your fingers in until she sucks in a sharp breath - and a particularly messy wad of her tail-cum spurts out of her thoroughly abused hole.");

	output("\n\nStill groping the queen’s rump, you shift your [pc.hips] forward, pressing your cockhead into her sloppy asshole. After two loads of cum have basted it, there’s not much her hole can do to resist you: the tight ring of flesh gives way easily, letting you glide into the tight, hot passage of Taivra’s queenly ass. She squeezes hard around you, arching her back and trying hard to suppress a cry of pleasure as you slide inch after inch of cockflesh into her.");
	if(pc.cockTotal() > 1)
	{
		output("Your other cock");
		if(pc.cockTotal() == 2) output(" pushes");
		else output("s push");
		output(" up against her taut cheeks, drooling ");
		if(pc.cockTotal() == 2) output("its");
		else output("their");
		output(" excitement all over the queen’s sullied flesh, begging for a hole to fuck. Too bad Taivra doesn’t have a normal cunt...");
	}
	output(" You can feel the nyrean queen trying as hard as she can to push against you, instinctively fighting to repel your anal assault.");
	pc.cockChange();

	output("\n\nShe fails, of course, too wet and loosened up to put up more than a token resistance. You just ease forward, pushing your hips against her taut behind until your ");
	if(pc.cockVolume(x) >= 1000) output("inhumanly large member is so deep inside the queen that her stomach bulges between her chitin plates, her body straining to take the mammoth member you’re forcing in");
	else if(pc.cockVolume(x) >= 500) output("huge cock is buried inside her, stretching her body to the limits. Taivra’s lips twist in a silent scream of pleasure, fingers trying to claw trenches into the stone dias you’ve bent her over on.");
	else 
	{
		output("cock is fully buried in her vice-like passage, letting you press your pelvis");
		if(pc.balls > 0) output(" and [pc.balls]");
		output(" against her up-raised ass.");
	}
	output(" The queen manages to eek out a groan, barely keeping herself on all fours - her arms look about ready to give, and you can feel her legs quivering against your ");
	if(pc.legCount > 1) output("own");
	else output("lower body");
	output(". You’re not anywhere near done with her, though, and so grab her neck and push her down onto her belly, letting you get completely overtop her and and start to really pound the bitch.");

	output("\n\nYour hands grab her shoulders, using your [pc.legs] to pin Taivra down. Your hips do the rest, rising and falling in short, hard strokes, pounding the clenching cheeks of the queen’s behind with all the force you can muster. The queen moans and grunts, squirming like an eel under you, but can’t get any traction to escape: she’s utterly at your mercy, and you’re sure to take advantage in full! Your thrusting hips crash against her behind, echoing wet slaps off the stony walls, and forcing out drooling spurts of tail-cum around your pistoning prick. Stars above, she’s tight... a perfect, hot, wet vice that squeezes you so tightly... you grit your teeth, trying to hold on - to get the most from your royal cock-sleeve.");

	output("\n\nYour vigor pays off as the queen finally shrieks, and her whole body tenses. The writhing mass of tentacles flopping around you swell with a second wave of orgasmic energy, and you feel her wanna-be horsecock erupt all over your [pc.legs], spraying you and the floor around you with her alien juices. Her tail-cocks cum a moment later, a dozen firehoses of white cream spraying all over you, over Taivra... the stuff gets absolutely everywhere! You chuckle, slapping the queen’s ass and driving your [pc.cock " + x + "] in to the hilt before you give in to your pleasures.");

	output("\n\nWith a feral grunt, you feel your own resistance crumbling in the face of rising orgasm. Your ");
	if(pc.balls > 0)
	{
		output("[pc.balls] ");
		if(pc.balls == 1) output("clenches");
		else output("clench");
		output(", and a moment later your ");
	}
	output("[pc.cock " + x + "] erupts inside Taivra’s ass, flooding the nyrea’s well-fucked bowels with [pc.cumNoun].");
	if(pc.cockTotal() > 1)
	{
		output(" Your other cock");
		if(pc.cockTotal() == 2) output(" blasts");
		else output("s blast");
		output(" Taivra’s backside with even more of your spunk, utterly bathing the defeated queen in your seed.");
	}
	output(" Around you, other nyrea moan and jeer - some actually cheer as their queen is ");
	if(pc.cockTotal() > 1) output("covered and ");
	output("filled with cum. You can see Taivra’s cheeks burn with shame and outrage, but she silently takes it all, just gritting her teeth and clenching her fists until you’ve pulled out and wiped your cock clean on her thighs.");

	output("\n\n<i>“Have someone take the probe out to the village. My people will pick it up,”</i> you command, turning away and grabbing your discarded gear. <i>“Or I’ll be back.”</i>");

	output("\n\nTaivra makes no sign that she heard you, but something tells you that she’ll do what you want. You grab her spear, a sign of your conquest, and start heading for the curtain. You make your way out of the nyrean palace, ready for the next phase of your journey.");

	output("\n\nWonder what’ll be guarding the next probe...\n\n");
	processTime(30);
	pc.orgasm();
	flags["FUCKED_TAIVRA"] = 1;
	genericVictory();
}

//Take Tentacles
//Take Taivra’s tentacles in every hole. Get the most out of all those wriggling parasites attached to her hind end.
public function takeTentaclesForTaivra():void
{
	clearOutput();
	showTaivra();
	var x:int = -1;
	if(pc.hasVagina()) x = rand(pc.totalVaginas());
	output("You slink forward, dropping your [pc.gear] by the wayside and smiling down at the defeated huntress. Her body is simply amazing, firm and toned in all the right places, but curvy and fuckable in all the others. Her breasts are full, heaving underneath her padded bra, and her panties bulge with the throbbing haft of her tremendous ovipositor cock. But that’s only the icing on her cake: your eyes are drawn to the wriggling mass of green vines attached to the base of her spine, bundled around the top of her rump before billowing out behind her like her tattered cape.");
	output("\n\nNice and easy, you wrap your hand around a few of her tentacles and run them through your fingers, making the woman moan throatily. Her hips wiggle invitingly, an unconscious gesture of approval as your fingers find their way to her cock-like tips. <i>“I can’t decide if you’re gentle... or a vicious beast,”</i> the queen murmurs, rolling onto her belly and letting you play with her tentacles. Surprisingly demure for the once-haughty queen. Her betas cheer and start to grope at themselves, getting ready to enjoy the show of a lifetime. Suddenly, you’re not sure if you’re about to publicly humiliate the queen, or just excite her court into a rutting frenzy.");
	output("\n\nEither way, though, you’re going to have a good time.");
	output("\n\nThe green tendrils squirm in your grasp, beading with watery white pre as you stroke them. You’re not sure if these things change much when they’re erect, but you want to make sure they’re as stiff as they’re going to be when you get down to it. You’re not satisfied until you’ve gotten your hands on all twelve of her tentacle cocks, stroking and caressing, even letting your mouth find a few of their crowns to kiss and suck them.");
	if(pc.isBimbo()) output(" You tell yourself you want to lube ‘em up, but really you find yourself deep throating the throbbing lengths, barely able to tear yourself away from them when another demands your attention.");
	output(" Your hands eventually find their way between the queen’s legs, following the curves of her ass down to the tumescing shaft of her ovipositor cock.");

	output("\n\nTaivra gasps as you grab her dick, sucking in her breath as you massage her shaft from the knotty base to her spiny tip. Your hand comes back covered in brightly-colored, hot slime - the nyrean equivalent of jem-lube, no doubt. You grin to yourself and reach down between your [pc.legs], smearing the sticky substance all over your [pc.vagOrAss " + x + "], using Taivra’s own juices to lube yourself up. Grinning happily, you grab a few of Taivra’s squirming tails into a bushel and drag them back towards your slicked-up hole, finally ready to have some fun!");

	output("\n\nLooking over her shoulder at you, the queen flashes you a surprisingly lustful purple-lipped smile. <i>“I wonder how many you can take?”</i>");

	output("\n\nThat sounds like a challenge - one you just might take. You beat her in battle, so what about beating her in the bedroom. Or the throne room, as the case may be. You squeeze her tentacles’ bodies, just enough to remind her who’s in charge even if you’re the one getting penetrated. A moment later and you feel three slender cockheads pressing against your [pc.vagOrAss " + x + "], each one wriggling and pushing independently from the others like they’ve all got minds of their own - and all trying to bury themselves in your welcoming hole.");

	output("\n\nYou struggle to keep them under control, slowly guiding the three slender shafts until their crowns are stretching the ");
	
	if(x < 0) output("rim");
	else output("lips");
	output(" of your [pc.vagOrAss " + x + "]. Biting your lips to hold back a moan of pleasure, you slowly guide the tendrils into your lubed-up hole. They keep on squirming all the way, grinding against your ");
	if(x >= 0) output("vaginal");
	else output("anal");
	output(" walls, searching out sensitive places to rub themselves on like bloodhounds - in the blink of an eye your restraint evaporates, and you’re left panting and moaning like a cheap ausar whore. The three serpentine cock-tendrils spread out, stretching you out as far as they can");
	if((x >= 0 && pc.looseness(x) >= 4) || (x < 0 && pc.ass.looseness() >= 4)) output("... which is a hell of a lot");
	output(".");
	if((x >= 0 && pc.looseness(x) >= 4) || (x < 0 && pc.ass.looseness() >= 4)) output(" More tentacles move in after that, slipping into the gaping hole to join their brothers.");
	output(" The sensation is overwhelming, making you scream as the tentacles explore every inch of your hole, refusing to give you a moment’s respite until they’re buried deep enough inside to make your gut bulge.");

	if(x >= 0) pc.cuntChange(x,1000);
	else pc.buttChange(1000);

	output("\n\nAn open mouth is practically an invitation to a woman with a bushel of tentacle cocks. Before you can close your lips, you’ve suddenly got two tendrils rushing towards your throat. You gag and sputter, drooling spittle around the two thrusting shafts that are trying to open up your clenching throat.");
	if(x >= 0) output(" Still more tentacles squirm around your [pc.butt], using their surprising strength to spread your cheeks and start to press in. Even if you wanted to stop them - and you don’t - you’re not sure you could anymore. So much for you being in command... Tentacles go everywhere after that, ramming every cock into every hole on offer, trading out when one’s near to cumming or another’s been left out of the action too long.");
	if(x >= 0) pc.buttChange(1000);

	output("\n\n");
	if(pc.hasCock()) 
	{
		output("One of her tendrils even finds its way to your [pc.cocks], wrapping around ");
		if(pc.cockTotal() == 1) output("your member");
		else output("them");
		output(" as deftly as a lover’s hand, squeezing and stroking until your prick");
		if(pc.cockTotal() == 1) output(" crowns with pre-cum. ");
		else output("s crown with pre-cum. ");
	}
	output("Tavria just smiles at you, rocking her hips and thrusting her tentacles as hard as she can into your spasming holes. For all her power, the queen is a creature of pleasure, exerting forces on you like nothing you’ve felt before. Under such a sensuous assault, you can’t help but cum - and cum hard. Your body convulses around the queen’s tentacles, squeezing and cumming and screaming your pleasure to the heavens.");

	output("\n\nLimp like a ragdoll, you flop listlessly back. Tentacles squirm in and around you, blasting you with streaks of pearly tail-spunk at the same time they baste your insides. All you can do is moan and buck your [pc.hips] against the thrusting parasites, eager for all the cum you can siphon off the queen.");

	output("\n\nWhen your climax has passed, and the queen’s cocks have stopped pumping you full of spunk, you slowly manage to pull yourself up. Tentacles pop wetly out of you, indignantly squirting spunk onto your asscheeks and face as you grab your gear. Breathlessly, you tell Taivra to deliver the probe to the village outside - your people will come get it later.");

	output("\n\n<i>“Of course, [pc.name],”</i> she murmurs, rolling onto her back. You shoot her a look, and indignantly grab her spear - if there’s one thing to cement your victory, it’s capturing your opponent’s weapon. You take a few cum-sodden steps towards the door before she finally calls after you that she’ll honor your request. You smile, and out you go. Nothing else dares to oppose you as you make your way out of the palace, back past the guard post at the gate and out into the deep caves.");

	output("\n\nTime to find out what your dad has in store for you next!\n\n");
	flags["FUCKED_BY_TAIVRA"] = 1;
	//[Next]
	genericVictory();
}

//Subjugate
//PC must have either read the nyrea codex or talked to Seifyn about Queen Taivra. Must have solo’d Queensguard and Taivra.
//You know how the nyrea operate - especially Queen Taivra, it seems. Were your positions reversed, she’d have added you to her harem; maybe you should add the queen to yours? To the victor go the spoils, and you just single-handedly beat down her and her bodyguard.
//Else: You don’t know enough about the nyrea to try and seize control here // After what happened with Dane, something tells you that Taivra would probably stab you in the back if you stick around.

public function subjugateQueenTaivra():void
{
	output("You kick Taivra’s fallen spear up into your hand, giving the long haft a few experimental twirls. The blade cuts the air around you, so light and quick that it feels like a whirlwind of steel around you. A fine weapon, one clearly built for a queen" + pc.mf("... or a king","") + ".");
	output("\n\nThe fallen queen looks up at you, her eyes as unfathomably dark as a pair of black holes. Striding forward, you swing the longspear around until its tip rests squarely under Taivra’s chin, dangerously close to her unprotected throat. Grinning triumphantly at the queen, you say <i>“I’ve heard a lot about you nyrea. The way you dominate those who you beat in battle.”</i>");
	output("\n\nTaivra nods slowly. <i>“That is how I built this city, yes. Subjecting lesser huntresses, males... any nyrea I found weaker than myself, that I could force to work in my name.”</i>");
	output("\n\nThen this shouldn’t come as much of a surprise to her, should it? From what you’ve seen, Taivra must have brought hundreds of her fellow nyrea under her sway over the years. About time somebody did the same to her: an idea she picks up on quickly as you remove the spear tip from her throat.");
	output("\n\nSighing, Taivra admits <i>“I did put myself at your mercy, didn’t I, [pc.name]? You have shown honor and courage thus far - more so than your worm of a cousin by far. Admirable traits I did not expect to see in a star-walker. Traits I could learn to live with. Literally, if need be.”</i> Her purple-painted lips twitch into something resembling a smile. <i>“Very well, [pc.name]. If I have your word my subjects will be treated fairly, left unharmed... I will submit.”</i>");
	output("\n\nYou give the queen a nod of agreement, and setting the butt of your newfound spear on the ground, reach out to shake on it. A gesture she’s clearly unfamiliar with, as Taivra hesitates a moment before clasping your hand in both of hers and kissing your knuckles. <i>“So be it. From this day forward, you have my word: I am yours, [pc.name]: my harem, my spear, and my body. Everything I have, I give to you.”</i>");
	output("\n\nYou accept her surrender eagerly, squeezing the queen’s hand. You wonder briefly if the nyrea have any concept of marriage as Terrans do, or if all they understand is their harems - domination through violence. ");
	if(pc.isNice()) output("Perhaps you’ll be the first to show them....");
	else output("Either way, it seems Taivra’s harem is yours now!");
	output(" You smile down at your new mate, eager to get the chance to take advantage of her willingness. You doubt you’ll ever find a more experienced partner, after all. The things she probably knows... mmm.");

	output("\n\nYou shake yourself out of your momentary reverie, long enough to tell Taivra to have the probe taken out of her village: you can make a hefty profit off of it thanks to Dad’s company, after all. She agrees, just as one of her submissives arrives with bandages for Queensguard.");

	output("\n\n<i>“We’ll talk later, [pc.name],”</i> she says quietly. <i>“I can only imagine how eager you are to... claim your prizes.”</i>");
	output("\n\nMore than one prize, too. After all, you’ve got the coordinates you need for the next leg of your quest!\n\n");
	flags["KING_NYREA"] = 1;
	genericVictory();
}

//Bad Ends
//PC is defeated by Queensguard or Taivra (w/ Dane)
public function loseToQueensTaivra():void
{
	clearOutput();
	//Defeat by Queensguard Intro
	if(foes[0] is Queensguard)
	{
		output("You stagger back under the armored nyrea’s rain of blows, desperately dodging sword swipes and shield strikes until your [pc.foot] catches on an uneven stone and suddenly you’re falling back, screaming until your head cracks on the rocky floor. Your world spins, vision erupting in stars; your [pc.weapon] is kicked painfully from your hands by ruthless steel. When your vision clears, you see the lethal point of Queensguard’s blade leveled at your throat, a hair’s breadth from slicing you open.");
		output("\n\n<i>“Yield,”</i> she growls from beneath her helm. <i>“Yield or die.”</i>");
		output("\n\nYou raise your hands, admitting your defeat. Queensguard gives you a slight, almost imperceptible nod, and several of the queen’s other soldiers rush out from the shadows to grab your [pc.gear], stripping you of all your equipment. A moment later and you’re left completely naked, shivering in the subterranean cold. A pair of soldiers heft you up and drag you forward as Queensguard steps dutifully aside, leaving you to face the queen.\n\n");
	}
	//Defeat by Taivra, has freed Dane Intro
	else
	{
		if(flags["FREED_DANE_FROM_TAIVRA"] == 1)
		{
			output("Even with Dane by your side, you find it impossible to stand up to the nyrean queen. The snowy-haired ausar valiantly deflects flurries of spear-thrusts, trying to grab at the queen’s haft but never able to get a grip on it until his hands are torn and bloodied. Taivra’s assault drives him back, sending the warrior dog tumbling back into you - the two of you go tumbling to the ground with a tangle of limbs and tail");
			if(pc.tailCount > 1) output("s");
			output(" and angry shouts.");
			output("\n\nBy the time you realize Dane’s cracked his skull and blacked out, it’s too late to push the unconscious (you hope!) ausar before Taivra’s on you, slamming down on you like a bag of furious bricks. A leather-clad knee drops hard on your neck, pinning you down and choking you while her spear is hiked into a short grasp and leveled squarely at your eye.");
			output("\n\n<i>“I believe you’re done, [pc.name],”</i> she growls, her jagged spear-tip hovering menacingly. <i>“Drop your weapons and yield.”</i>");
			output("\n\nWith a heavy sigh, you release your [pc.weapon]. A few of the beta nyrea still in the room leap forward and secure your equipment. They roll Dane off you and pull you up, ripping off your [pc.gear] until you’re naked and shivering on your [pc.knees] before the queen.\n\n");
		}
		else
		{
			pcBeatByTaivraOneOnOneManoEManoLady();
			return;
		}
		//Combine:
	}
	output("<i>“A shame you did not live up to my expectations, [pc.name],”</i> Taivra sighs, reclining on her throne. <i>“I hoped for more... ah, well. I suppose you star-walkers are all alike in the end: weak.”</i>");
	output("\n\nThe queen sighs, running her fingers along the haft of her spear. <i>“What am I to do with you? Have you join my harem? I once only accepted the strong as my mates, warriors like Queensguard in her prime. Though that was many years ago. Now... I suppose I have so many betas, a few star-walkers won’t be so out of place.”</i> She turns to her guards and commands them, <i>“Take the four-armed one to the healers. Have him tended to. And the cousin, the little blonde slut. Give [rival.himHer] to me. I think it’s time these two Steeles learned their new place.”</i>");
	output("\n\nThe guards nod briskly, and a few moments later Dane is hauled off, and [rival.name] is dragged over to take the huge ausar’s place, forced onto [rival.hisHer] knees beside you.");
	output("\n\n<i>“Way to go, you dumb shit,”</i> [rival.name] snaps under [rival.hisHer] breath. <i>“Now we’re stuck here!”</i>");
	output("\n\nMaybe if [rival.name] hadn’t tried to merc the queen in the first place, none of this would have EVER happened. Your cousin sneers, but [rival.hisHer] reply is cut off by the queen’s commanding voice:");
	output("\n\n<i>“Come here, you two. No, don’t stand. You haven’t earned that right. Crawl.”</i>");
	output("\n\nYou and [rival.name] exchange a glance, both of you apparently half-considering some act of rebellion before a pair of guards smack your [pc.butt] with the butts of their spears, shoving you forward. With a wince of pain, you and [rival.name] both start crawling like beaten dogs towards the stone dias. The queen’s betas scoot out of the way, the pile of writhing mid-coistus bodies getting as far as they can on the short leash of Taivra’s tail-cocks still thrusting into their drooling ovipositors.");
	output("\n\nAs you approach, Taivra slowly rises to her feet and lets the heavy chain panties fall from her wide hips, clattering to the ground at your fingertips and revealing the throbbing shaft of her ovi-cock: as thick around as your arm, its flared head ringed with spiny pleasure-nubs around an X-shaped slit beading with moisture. Her harem moans around her, tails thrusting faster and harder as the queen’s excitement mounts.");
	output("\n\n<i>“You two might have been rivals once, but I’ll not tolerate fighting in my harem. If you want to live, put your childish feud aside and work together. If you make me cum, maybe I won’t put you in cages for the rest of your lives.”</i>");
	output("\n\nThe queen’s words are more of a threat than enticement, a clear command that you and your cousin have to work together if you’re going to make it through what promises to be a long imprisonment.");
	output("\n\n<i>“Gross,”</i> [rival.name] uncremoniously delcares, curling [rival.hisHer] nose. <i>“I’m not-”</i>");
	output("\n\n[rival.HisHer] gripes are cut off by a swift slap from Taivra, a crack of chitin on flesh that echoes painfully through the throne room. Several nyrea cheer or jeer, shouting curses as your cousin’s blonde hair billows around [rival.hisHer] head, and [rival.hisHer] hand goes to [rival.hisHer] cheek, touching it with wide, horrified eyes.");
	output("\n\n<i>“Maybe you liked it better in your cage, worm?”</i> Taivra growls. <i>“Or would you prefer death?”</i>");
	output("\n\n[rival.name] looks bat at the queen with tear-stained eyes, bitterly biting [rival.hisHer] lip. You’d laugh, if circumstances were just a little different. Now, though, the queen’s gaze turns to you, and you are drawn forward your [pc.lips] nearly brush Taivra’s ovipositor-cock. You reach back, grabbing [rival.name]’s shirt collar and yank [rival.himHer] forward. [rival.HeShe] stumbles, making you drag [rival.himHe] up to sit beside you, on the other side of Taivra’s mighty egg-layer.");

	output("\n\nYour cousin looks at you with absolute hatred... or is it defeat? Either way, [rival.hisHer] tongue snakes out of [rival.hisHer] lips and slowly reaches out to touch the flank of Taivra’s pink shaft. That’s better - no way you’re doing this alone. Taivra gives you an ever-so-slight nod, and drinks in a deep, chesty breath as [rival.name]’s tongue caresses her cock. You follow suit, breathing a sigh before submitting to your new mistress. There’s no coming back from this, a small part of your mind tells you: the rest of your life will be spent here on your [pc.knees], worshipping Queen Taivra’s powerful body. That’s what happens to people like you and [rival.name] on this word: the losers, the ones not strong enough to stand up to someone like Taivra.");
	output("\n\nYou deserve this.");

	output("\n\nForcing yourself to accept your fate, you lean in to join your cousin in oral worship of the queen’s tremendous ovipositor. Your [pc.tongue] flicks across the pale pink cockflesh, taking your first taste of your new mistress. It’s... odd, not like you’d have imagined; the first thing to come to your mind is lemons, sweet but bitter enough to make you scrunch your nose.");

	output("\n\nThe queen chuckles at your reaction, running her long-nailed fingers ");
	if(pc.hasHair()) output("through");
	else output("over");
	output(" your [pc.hair]. Her grasp tightens on the back of your head, guiding you up and down the length of her shaft as she sits back down on her towering throne, reclining on your father’s glossy black probe as you and [rival.name] run your tongues all over her prick. Between long-lapping licks, your gaze settles over the crest of Taivra’s rounded shaft, locking eyes with your cousin. You can see the hatred burning in [rival.hisHer] eyes, glowering at you and the regal bug-woman looming over you. Beta nyrea squirm all around you, bodies writhing while the queen fucks them to the beat of your and [rival.name]’s tongues.");
	output("\n\nThe orgiastic picture must look like quite the hedonistic scene to the guards standing around - or more accurately, slumped against the walls feverishly touching themselves. You’re amazed the queen’s throne room hasn’t turned into a wall-to-wall carnal pit!");
	output("\n\nPerhaps they’re just waiting for their queen to have her pleasure first, like wild animals letting their alpha take the first share of the kill. You shudder to think that you and [rival.name] are going to passed around as the whole palace’s bitches, but there’s not much you could do to stop it now. All there is to do is keep licking and hope the queen shows you mercy... and maybe doesn’t for your cousin. You’d still get some small satisfaction seeing [rival.himHer] get railed by a rape-gang of nyrean warriors.");
	output("\n\nHey, [rival.heShe] tried to strafe you with a gunship once. Fair’s fair.");
	output("\n\nYou shake the thought and start licking harder, running your fingers around the nubby flare at the tip of Taivra’s cock. She moans, and a trickle of purple juice drools out of its X-shaped tip, smearing your fingers - and lubing up your ministrations. Your hand moves faster after that, smearing her excitement over her prick; the taste changes dramatically after that, much sweeter than before! Your motions pick up speed, spurred on by the pleasant taste and the struggles of your cousin. [rivan.name] looks like [rival.heShe]’s trying to catch up to you, kissing and nibbling on the thick cockmeat between you. Everything’s got to be a contest between you, doesn’t it?");
	output("\n\nWell, you’re not going to be outdone here! Leaving the flanks of Taivra’s cock to your oh-so-determined cousin, you scoot around to sit right in front of the queen, planting yourself between your legs. You get an approving smile from her purple-painted lips, and one of her plated legs lifts up and onto your shoulder, gently guiding you in towards the broad cockhead you’re lusting after. You open wide, stretching your jaw around the vaguely-equine crown and start to slide your throat up her length.");
	output("\n\n<i>“Showoff!”</i> your cousin hisses under [rival.hisHer] breath, but Taivra just nods and arches her back - with fourteen people servicing her all at once, it’s amazing she’s not cumming already - this woman has to have remarkable sexual fortitude. You’ll just have to bring her to the edge yourself...");
	output("\n\nYou grab her cock in both hands and do your best to deepthroat your new mistress, taking as much as you can until her spiny crown batters the back of your throat. That catches her by surprise - Taivra grunts and thrusts her hips at you, grabbing at your cousin’s head and pushing [rival.himHer] deeper into her crotch, forcing [rival.himHer] to run [rival.hisHer] tongue all along the length of her cock until [rival.name]’s face is pressed between her legs, forcing to work at the very base of her shaft.");
	output("\n\nBetween the two of you - and a dozen sluts getting their ovipositors fucked by her tails - you see her will start to erode away into a chorus of soft moans and grunts. She’s squirming before long, her fingers digging painfully into your skull - and [rival.name]’s as well, if the way [rival.heShe]’s scowling and wincing with every hip-thrust is any indication. Lucky for [rival.himHer], you’re doing everything you can to bring Taivra to orgasm: using your mouth, tongue, and hands with all the skill you’ve accumulated over your adventures: every trick and technique you’ve picked up applied in rapid succession.");
	output("\n\nYour ministrations seem to pay off, as Taivra’s breath quickens, and her thrusts into the mewling harem around her approach a fever pitch. You push your [pc.tongue] forward, slipping it between the folds of her X-shaped slit, invading the hollow, heated tube of her ovipositor to tease her sodden insides. She moans, squeezing her muscular thighs around your [pc.face] like some sort of anchor to keep herself from racing over the edge.");
	output("\n\nShe doesn’t last much longer. With a roar of anguished pleasure, the queen throws her head back and lets loose her pent-ups lusts, blasting your throat with a geyser of alien fluids. Behind her, a dozen harem sluts arch their backs and scrape their fingers on the stone as their ovi-cocks are flooded with a deluge of cock-tail cum. The air around you becomes heavy with the smells of sex, Taivra alone putting off enough masculine musk from her ovipositor-flooding cum to make you think a dozen men were climaxing around you. And her fem-cum, too! She tastes so sweet, and her juices are so sticky that you feel like your mouth is being painted over by purple alien excitement.");
	output("\n\nHot cum drools from the corners of your mouth, pooling on the floor between your [pc.legs] as Taivra’s wilting cock pops out of your mouth. She grabs your cousin’s bonde head, pulling [rival.himHer] over and forcing [rival.himHer] to lick her crown clean. You grin at the disgust on [rival.hisHer] face, nose scrunched up and lips twisted as [rival.heShe]’s forced to lap up all the juices and spit coated Taivra’s cock.");
	output("\n\n<i>“I suppose that will do,”</i> Taivra says contentedly, reclining on her throne. Around her, her harem betas slump to the ground, extricating her tentacles from their bodies. <i>“Though not much in battle, you star-walkers seem to have some skill with your bodies, at least. If you think you can do that again... and again... perhaps I’ll keep you after all.”</i>");
	output("\n\nShe snaps her fingers, and you feel a pair of nyrean hands on your shoulders, pulling you towards the throne room’s doors.");
	output("\n\nAnd so ends the story of [pc.name] Steele, one true heir to Victor’s fortune. You’ll spend the rest of your life wondering what you could have been, had things been different. At least you have [rival.name] to commiserate with...");
	badEnd();
}

//PC is Defeat by Taivra in a Solo Fite
public function pcBeatByTaivraOneOnOneManoEManoLady():void
{
	clearOutput();
	showTaivra();
	output("The queen fights like a woman possessed ,driving you back with her spear until you’re tumbling off the dias, falling back with a scream. Your cousin shouts at you, but [rival.hisHer] words are lost as your head cracks on the stone, and a moment later, Taivra comes crashing down on you with her knee, pinning you down as her spear presses firmly against your throat.");
	output("\n\n<i>“You fight well, [pc.name],”</i> she purrs, her knee pushing painfully into your gut. <i>“And honorably, too. You’ve impressed me, star-walker. More than I thought one of your kind could have.”</i>");
	output("\n\nShe smiles, and her knees shift, moving to straddle you more than just pin you down. <i>“There’s a place by my side in the harem I’ve never been able to fill. Yield to me, [pc.name]. Swear fealty, and I will guarantee you a kingly life at my side.”</i>");
	output("\n\nGiven the choice of death or nobility, the choice isn’t much of one at all. You let go of your weapon and show your empty hands to the queen. Her smile widens, and she rises to her feet. <i>“A wise choice, [pc.name].”</i> She offers you a hand up, and a moment later you’re being hauled up and into the queen’s arms. Her hands wrap around your [pc.hips], and you’re suddenly aware of the heat of her body pressing against you, the sweat-sheened flesh and polished chitin as alluring as they is intimidating.");
	output("\n\n<i>“A wise choice indeed,”</i> Queen Taivra purrs, gesturing at her soldiers behind you. The nyrean guards grab Queensguard and drag her off to be tended to, and others gather around your cousin in [rival.hisHer] cage.");
	output("\n\n<i>“Let go of me!”</i> [rival.name] shrieks as [rival.heShe] is dragged out of the cage, kicking and screaming.");
	output("\n\nThe queen turns to you, one of her fingers ");
	//if loss by HP:
	if(pc.HP() <= 0) output("wiping the blood from a small cut her dancing spear has left on your shoulder");
	else output("teasing across one of your [pc.lips], gently turning your attention towards your struggling cousin.");
	output(" <i>“My first gift to you. Consider [rival.himHer] a reward for your valor. I was still deciding what to do with [rival.himHer] before your arrival. Perhaps you’d care to decide [rival.hisHer] fate? As I understand it, there’s a great deal of enmity between you two.");

	//[Execute] [Egg Slut] [Bed Warmer]
	clearMenu();
	addButton(0,"Execute",cousinGetsExecuted,undefined,"Execute","Have your cousin killed. If you can’t be CEO of Steele Tech, [rival.heShe] sure as hell can’t either!");
	addButton(1,"Egg Slut",cousinTurnsEggSlut,undefined,"Egg Slut","If your cousin tried to kill Taivra, the least [rival.heShe] can do is spend the rest of [rival.hisHer] existence making life. Have [rival.name] become an egg incubator for the harem.");
	addButton(2,"Bed Warmer",bedWarmerCuz,undefined,"Bed Warmer","You have to admit, even after all of this... you and your cousin have a certain connection. Have [rival.name] become your personal sex slave.");
}

//Execute
//Have your cousin killed. If you can’t be CEO of Steele Tech, [rival.heShe] sure as hell can’t either!
public function cousinGetsExecuted():void
{
	clearOutput();
	showRival();
	output("<i>“Kill [rival.himHer],”</i> you say, sneering at your helpless cousin.");
	output("\n\nTaivra chuckles and nods at a couple of her soldiers, who latch their arms on [rival.name]’s shoulder and start to pull [rival.himHer] away. <i>“Good choice, my new mate... better to have your rivals killed than risk their coming back to harm you later. I’ll have gallows erected in the village, and we’ll dispose of this worm.”</i>");
	output("\n\n[rival.name] screams a host of profanities, but is helpless to resist as [rival.heShe]’s dragged away her [rival.hisHer] doom. Taivra’s hand tightens around your waist as your rival is dragged off, until it’s almost painful. <i>“Now then, I believe it’s time you paid your fealty to me...”</i>");
	clearMenu();
	addButton(0,"Next",badEndWithTaivraShit);
}

//Egg Slut
//If your cousin tried to kill Taivra, the least [rival.heShe] can do is spend the rest of [rival.hisHer] existence making life. Have [rival.name] become an egg incubator for the harem.
public function cousinTurnsEggSlut():void
{
	clearOutput();
	showRival();
	output("<i>“You nyrea like planting your eggs in people, don’t you?”</i> you say with a mischevious grin, looking your cousin’s lithe form up and down. <i>“I think [rival.name] here would look a lot better with a belly full of eggs... for the rest of [rival.hisHer] life.”</i>");
	output("\n\nTaivra chuckles, <i>“");
	if(pc.hasCock()) output("Many sired by you, I’m sure.");
	else output("Perhaps you’d rather your cousin bear your burden of eggs? A fitting fate, I suppose.");
	output(" Very well, I will order [rival.himHer] bathed and set aside with the rest of my favored incubators. A better life that that worm deserves, but one that is at least productive. You are both wise and magnanimous, my mate.”</i>");
	output("\n\n[rival.name] screams a host of profanities, but is helpless to resist as [rival.heShe]’s dragged away her [rival.hisHer] doom. Taivra’s hand tightens around your waist as your rival is dragged off, until it’s almost painful. <i>“Now then, I believe it’s time you paid your fealty to me...”</i>");
	flags["COUSIN_EGGSLUT"] = 1;
	clearMenu();
	addButton(0,"Next",badEndWithTaivraShit);
}

//Bed Warmer
//You have to admit, even after all of this... you and your cousin have a certain connection. Have [rival.name] become your personal sex slave.
public function bedWarmerCuz():void
{
	clearOutput();
	showRival();
	output("<i>“I want [rival.himHer],”</i> you say simply, drinking in your cousin’s lithe form. You’ve spent too long chasing that piece of tail across the galaxy, and now [rival.heShe]’s in your grasp. No way you’re letting an opportunity like this pass... sorry, Dad.");
	if(pc.hasCock() && chars["RIVAL"].hasVagina()) output(" Well, Dad’s gene pool was pretty messed up before, so there’s not much more damage you can do.");

	output("\n\n<i>“Ah, a warrior after my own heart,”</i> Taivra chuckles, her predatory smile only widening. <i>“A defeated foe is only as good as they can service you in bed, don’t you agree? A fate you’ll learn yourself, but for now, I will allow you this choice.”</i> She turns her attention to [rival.name] and motions to a couple of her soldiers. The nyrea grab [rival.name], ripping at [rival.hisHer] clothes and dragging [rival.himHer] towards the curtain at the foot of the throne room.");

	output("\n\n<i>“I’ll have your cousin bathed and prepared for you,”</i> Taivra promises. <i>“I hope your first mating will be as pleasant as ours shall.”</i>");
	output("\n\nYou feel one of the queen’s hands brush over your [pc.butt] at that, giving you just enough of a push towards the door to get you moving. It looks like your new queen is going to take advantage of your surrender sooner rather than later.");
	flags["COUSIN_BEDWARMER"] = 1;
	clearMenu();
	addButton(0,"Next",badEndWithTaivraShit);
}

//Combine, no new pg.
public function badEndWithTaivraShit():void
{
	clearOutput();
	showRival();
	output("Your queen leads you in your cousin’s wake, out of the throne room and back through the palace. Nyrean warriors follow you, spears and armor clanking loudly. Taivra’s arm wraps around you, guiding you up the winding stairs and into a large room off of the main thoroughfare. The queen’s chambers - and yours, now, you think. The nyrean queen’s hands run across your bare flesh, caressing your ");
	if(pc.hasCock()) output("[pc.cocks]");
	if(pc.hasCock() && pc.hasVagina()) output(" and ");
	if(pc.hasVagina()) output("[pc.vaginas]");
	output(", giving you just enough of a squeeze to send a rush of an excitement through you.");

	output("\n\nHer plated hands guide you towards the bed and roughly pushes you onto your back, sending you tumbling onto the feather-soft silks. She’s on you in a moment, pinning you down with her knees - and her lips, as well. Amethyst lips press firmly to yours, and your lover moans throatily as you submit to her sensual domination. You should enjoy your reward, you decide: the queen has offered to give you a place of honor, but a place you will be for the rest of your life. You’ll never see your gear again");
	if(!(pc.meleeWeapon is EmptySlot) && !(pc.rangedWeapon is EmptySlot)) output(", or your weapons");
	output(". No way to contact home, no way to fight your way out that wouldn’t have you a doomed as Dane and your cousin were.");

	output("\n\nThis is the end of your quest. Might as well make the most of it.");

	output("\n\nYou struggle with Taivra’s chain bikini until the heavy garments fall aside, dumping the pendulous mounds of her ivory breasts into your hands. A gentle squeeze earns you a murmurs of pleasure from the queen, and makes her writhing mass of green tentacle-cocks go wild with anticipation. <i>“Ah, you’re braver than most betas... as I hoped,”</i> the queen purrs between kisses, clearly enjoying the way your fingers clutch at her chest. <i>“Most just lie back and scream when I fuck them... when I breed them. After what you’ve been through, though, something tells me you know how to give as good as you get.”</i>");

	output("\n\nYou give her a squeeze of affirmation, and slip a hand down to pull the chain panties from her flared, egg-bearing hips. A hot slab of nyrean meat flops down onto your lap in its wake, its pleasure-nubs rubbing against your [pc.leg]. ");
	if(pc.hasCock()) output("However, despire her breeding stick’s looming threat against your groin, Taivra’s hips shift ever so slightly to rub her taut ass against the half-erect shaft of [pc.oneCock]. She flashes you a playful smile, and her hand reaches back to grab your prick. <i>“I’ll go easy on you, this first time,”</i> she teases, pumping your shaft. <i>“But don’t get used to it... beta.”</i>");
	else output("Taivra’s hips slowly shift back, dragging her burning-hot egg-layer down between your [pc.legs]. <i>“Don’t worry, I’m not carrying any eggs now. I want to get used to you, make sure you’re nice and broken in before I trust you with my young.”</i> As if to punctuate the point, you feel her nub-ringed pressing against your [pc.vagOrAss].");

	output("\n\nYour whole body tenses as the insectile queen hovers on the brink of penetration, making you wait in agonizing anticipation before fully making you hers.");

	output("\n\nA moment later, and you become a true member of her massive harem in an explosion of pleasure.");
	processTime(2000);
	pc.lust(pc.lustMax());
	clearMenu();
	addButton(0,"Next",soloTaivraBadEndPart2);
}

public function soloTaivraBadEndPart2():void
{
	clearOutput();
	showTaivra();
	output("The queen claims you as her second - the second most powerful and influential member of her harem, after herself. The next days are spent in ruts of lust and fiery passion. You’re sure the food the nyrea give you is spiked with some kind of aphrodisiac, as your desire flares to unbearable heights - you can’t keep your hands off of Taivra whenever she deigns to be near you, and you quickly become accustomed to your place on your knees, servicing the queen’s cock with your mouth, or bending over on the dias of the throne to let her stuff your [pc.vagOrAss] with her alien cum... and, later, her eggs.");
	output("\n\nWhen the queen is otherwise occupied, your attentions turn towards her myriad betas: dozens of lusty sluts, some with dicks and others with dripping pussies filled with semen, all eager for your touch.");
	//if BedWarmer Rival: 
	if(flags["COUSIN_BEDWARMER"] == 1) 
	{
		output(" Your cousin, too, finds [rival.himHer]self at your mercy, a permanent fixture in your chambers by way of a solid steel chain and collar. Your first time together is... emotional, to say the least. There’s screaming, clawing, and eventually crying, but you have your way. Eventually [rival.name] learns to love [rival.hisHer] place - even thanks your for saving [rival.hisHer] life. It turns out that with a little effort and training, you couldn’t ask for a better ");
		if(pc.hasCock()) output("cock-warmer");
		else if(rival.hasCock() && pc.hasVagina()) output("cock to fill your pussy");
		else output("mate");
		output(", as incestuous as your union is. More than once after a vigorous fuck session, when [rival.name] thinks you’re fast asleep, [rival.hisHer] head resting on your chest, you’re sure you hear [rival.himHer] say <i>“I love you.”</i>");
	}
	output("\n\nYou suppose a life spent in lust, fucking who you please between sexual service to a powerful and domineering queen, isn’t so bad after all. You never find out what your father had in store for you, but frankly... you’re not sure it matters. You have another cousin who might hear her fortune some day, at your and [rival.name]’s expense. Obviously, you weren’t cut out for the job. But now you’ve found a better one, a career more suited to your talents and to the lust that grows hotter in you day after day.");
	output("\n\nSomething feels missing in you for the rest of your life. A destiny unfulfilled. But it’s an easy hole to ignore, surrounded by beautiful aliens");
	if(flags["COUSIN_BEDWARMER"] == 1) output(" and a cousin who so eagerly warms your bed at night");
	output(". You can’t say you’re too sad at night, especially when your loving queen takes you into her bed - nothing ever will make you feel more alive again as when Taivra claims you with her royal scepter, filling your body with the most amazing sensation, and new generations of life for your queen’s growing nation.");

	output("\n\nIt’s not so bad, in the end.");
	badEnd();
}
