'Oxaloacetate
'Interfeci
'Version 1.6 ALPHA

GLOBAL gold, level, exp, action$

[ARRAYS]
    DIM enemyName$(10)
    enemyName$(0) = "Witch of the Black Forest"
    enemyName$(1) = "Golden Stallion of the Dead"
    enemyName$(2) = "Death Gnome of the Darkness"
    enemyName$(3) = "Sangan of the Underworld"
    enemyName$(4) = "This Monster Lacks a Name"
    enemyName$(5) = "Radioactive Molten Branches"
    enemyName$(6) = "al3fsi4slak2ao9dlske2weals"

    DIM slot(3)
    slot(0) = 1
    slot(1) = 1
    slot(2) = 1

[STD_VARIABLES]
    LET class$ = "Class"
    LET gold = 500
    LET bankGold = 0
    LET level = 1
    LET exp = 0
    LET action$ = "Action" 'The action button enables players to play
    LET maxHealth = 20 'Add newLevel*10 to it after level up
    LET health = maxHealth
    LET speed = 10
    LET enemyMaxHealth = 10  ' Add newLevel*15 to it after level up
    LET enemyHealth = enemyMaxHealth
    LET enemySpeed = 9 'Add newLevel*3 to it after level up
    LET damageQ = 1 'Multiplier for damage dependant on the weapon
    LET defenseQ = 1 'Divisor for the damage taken
    LET arabestMaxHealth = 30
    LET arabestHealth = arabestMaxHealth
    LET mEncounter = 0 'Monsters Encountered
    LET mKill = 0 'Monsters Killed
    LET dragonHealth = 1000000
    LET heroicDeeds = 0 'Times beaten the game

[MAIN]
    CLS
    PRINT "CURSE OF THE BLACK DRAGON"
    PRINT "-------------------------"
    PRINT

    PRINT "Would you like to continue your saved game?"
    PRINT "(Y)es"
    PRINT "(N)o"
    INPUT action$
    IF action$ = "Y" THEN
        GOTO [LOAD_GAME]
    END IF
    PRINT "Starting new game..."

0   PRINT "Hello, good sir. After years of being an apprentice, your master has decided to knight you, for a price."
    PRINT "You must venture to slay the black dragon that has been terrorizing the streets."

    INPUT "Now, what may the townspeople call you? "; alias$
    PRINT
    PRINT "Welcome to the town, "; alias$; ". Feel free to train in the forest until you can defeat our strongest warrior, Arabest."
    PRINT "We will not permit you to enter the cave of the dragon until you can first do this."
    PRINT "We wish you the best of luck, "; alias$; "."
    PRINT
1   PRINT "But wait. What is your class?"
    PRINT "(S)wordsman - Increased attack and defense"
    PRINT "(L)ongbowman - Increased attack and speed"
    PRINT "(C)avalryman - Increased defense and speed"
    INPUT action$
    SELECT CASE action$
        CASE "S"
            PRINT "Swordsmen are brutal warriors. They are the backbone of any army."
            damageQ = damageQ + 2
            defenseQ = defenseQ + 2
            class$ = "Swordsman"
            PRINT "Congratulations, "; alias$; ", you are an official "; class$; "!"
            GOTO [TOWN_SQUARE]
        CASE "L"
            PRINT "Longbowmen are stealthy. They are the primary defense and ambush units."
            damageQ = damageQ + 2
            speed = speed + 4
            class$ = "Longbowman"
            PRINT "Congratulations, "; alias$; ", you are an official "; class$; "!"
            GOTO [TOWN_SQUARE]
        CASE "C"
            PRINT "Cavalrymen are glamorous. Their armor shines off of the enemy shield."
            defenseQ = defenseQ + 2
            speed = speed + 4
            class$ = "Cavalryman"
            PRINT "Congratulations, "; alias$; ", you are an official "; class$; "!"
            GOTO [TOWN_SQUARE]
    END SELECT
    GOTO 1

[HANDLE_ERROR1]
    CLOSE #1
    GOTO [STD_VARIABLES]

[HANDLE_ERROR2]
    CLOSE #2
    GOTO[TOWN_CENTER]

[LOAD_GAME]
    ON ERROR GOTO [HANDLE_ERROR1]
    OPEN "saveFile.txt" FOR INPUT AS #1
    INPUT #1, alias$
    INPUT #1, class$
    INPUT #1, level
    INPUT #1, exp
    INPUT #1, gold
    INPUT #1, bankGold
    INPUT #1, health
    INPUT #1, maxHealth
    INPUT #1, speed
    INPUT #1, enemyHealth
    INPUT #1, enemyMaxHealth
    INPUT #1, enemySpeed
    INPUT #1, damageQ
    INPUT #1, defenseQ
    INPUT #1, arabestHealth
    INPUT #1, arabestMaxHealth
    INPUT #1, mEncounter
    INPUT #1, mKill
    INPUT #1, heroicDeeds
    level = level XOR 12
    exp = exp XOR 12
    gold = gold XOR 12
    bankGold = bankGold XOR 12
    health = health XOR 12
    maxHealth = maxHealth XOR 12
    speed = speed XOR 12
    enemyHealth = enemyHealth XOR 12
    enemyMaxHealth = enemyMaxHealth XOR 12
    enemySpeed = enemySpeed XOR 12
    damageQ = damageQ XOR 12
    defenseQ = defenseQ XOR 12
    arabestHealth = arabestHealth XOR 12
    arabestMaxHealth = arabestMaxHealth XOR 12
    mEncounter = mEncounter XOR 12
    mKill = mKill XOR 12
    heriocDeeds = heroicDeeds XOR 12
    PRINT "Game successfully loaded!"
    CLOSE #1
    GOTO [TOWN_SQUARE]

[SAVE_GAME]
    ON ERROR GOTO [HANDLE_ERROR2]
    OPEN "saveFile.txt" FOR OUTPUT AS #2
    PRINT #2, alias$
    PRINT #2, class$
    PRINT #2, level XOR 12
    PRINT #2, exp XOR 12
    PRINT #2, gold XOR 12
    PRINT #2, bankGold XOR 12
    PRINT #2, health XOR 12
    PRINT #2, maxHealth XOR 12
    PRINT #2, speed XOR 12
    PRINT #2, enemyHealth XOR 12
    PRINT #2, enemyMaxHealth XOR 12
    PRINT #2, enemySpeed XOR 12
    PRINT #2, damageQ XOR 12
    PRINT #2, defenseQ XOR 12
    PRINT #2, arabestHealth XOR 12
    PRINT #2, arabestMaxHealth XOR 12
    PRINT #2, mEncounter XOR 12
    PRINT #2, mKill XOR 12
    PRINT #2, heroicDeeds XOR 12
    PRINT "Game successfully saved!"
    CLOSE #2

[TOWN_SQUARE]
    PRINT
    PRINT "You're surprised that you managed to get here without tripping over your sword."
    PRINT "As always, the mobs in the center are boisterous and not worth your while. You want to join in, but..."
10  PRINT "What else would you like to do?"
    PRINT "(F)orest"
    PRINT "(T)ournament"
    PRINT "(P)rofile"
    PRINT "(H)ealer"
    PRINT "(B)ank"
    PRINT "(W)eapons"
    PRINT "(A)rmor"
    PRINT "(M)issions"
    PRINT "(C)asino"
    PRINT "(S)ave"
    PRINT "(Q)uit"
    INPUT action$

    SELECT CASE action$
        CASE "F"
            CLS
            PRINT "There is never a better time to train."
            GOSUB [FOREST]
        CASE "T"
            CLS
            PRINT "Commoners stare at you as you make your way into the tournament room."
            GOSUB [TOURNAMENT]
        CASE "P"
            CLS
            PRINT "PROFILE"
            GOSUB [PROFILE]
        CASE "H"
            CLS
            PRINT "The line is long, but eventually you get the chance to meet the healer."
            GOSUB [HEALER]
        CASE "B"
            CLS
            PRINT "A penny saved is a penny earned. Too bad that person is not alive yet."
            GOSUB [BANK]
        CASE "W"
            CLS
            PRINT "You can already feel the coldheartedness of the shopkeeper."
            GOSUB [WEAPON_SHOP]
        CASE "A"
            CLS
            PRINT "You cut the line only to go to the armor shop."
            GOSUB [ARMOUR_SHOP]
        CASE "M"
            CLS
            PRINT "It is time to pay a visit to the military base of your town."
            GOSUB [MISSION]
        CASE "C"
            CLS
            PRINT "Time to go burn some paper! I mean, double your money."
            GOSUB [CASINO]
        CASE "S"
            PRINT "Attempting to save game..."
            GOSUB [SAVE_GAME]
        CASE "Q"
            CLS
            PRINT "Farewell..."
            END
    END SELECT

    GOTO 10

[FOREST]
    CLS
    PRINT "You cautiously enter the dark-damp deadwood. You trip on your sword, and you become lost."
15  PRINT "In what manner do you wish to continue?"
    PRINT "(L)ook for something to kill"
    PRINT "(R)eturn to the town center"
    INPUT action$

    SELECT CASE action$
        CASE "L"
            CLS
            PRINT "You set out to look for something to slaugher."
            GOSUB [BATTLE]
        CASE "R"
            CLS
            PRINT "You sprint out of the forest and head back towards town. Smart move."
            RETURN
    END SELECT

    GOTO 15

[TOURNAMENT]
    fee = int((500*level^2) / (heroicDeeds + 1))
    expreq = int((200*level^2) / (heroicDeeds + 1))

    CLS
    PRINT "The air is stained with the stench of blood. You can literally feel the agony of losers as a cold shiver goes through your spine."
    PRINT "It costs you "; fee; " to have a go, and the minimum experience needed to fight the master is "; expreq; "."
20  PRINT "Today is the day you succeed."
    PRINT "(F)ight the master"
    PRINT "(L)eave the warzone"
    INPUT action$

    SELECT CASE action$
        CASE "F"
            IF gold >= fee AND exp >= expreq THEN
                CLS
                gold = gold - fee
                PRINT "You proudly enter the coliseum."
                PRINT "As the crowd cheers, the gates open."
                GOSUB [FIGHT]
                RETURN
            ELSE
                PRINT "The receptionist declines your request to fight your master."
            END IF
        CASE "L"
            CLS
            PRINT "Come back here when you get the nerve to do so."
            RETURN
    END SELECT

    GOTO 20

[HEALER]
    hcost = int((level * 5) / (heroicDeeds + 1))
    CLS
    PRINT "The benevolent man asks you how much health you want him to heal for you."
    PRINT "You have "; health; " health. You can replenish at max "; maxHealth - health; " health."
25  INPUT "How much health, good sire? Each health point costs "; hcost; " gold: "; action
    IF action <= maxHealth - health AND action >= 0 AND gold >= action * hcost THEN
        health = health + action
        gold = gold - action * hcost
        PRINT "Done! You are healed!"
        RETURN
    ELSE
        PRINT "Sorry, but that amount even I cannot do."
    END IF

    GOTO 25

[BANK]
    CLS
    PRINT "A sign outside says that there will be a 10% deduction to all deposits."
    PRINT "Acknowledging this, you head into the dusty building, and ask the teller for assistance."
30  PRINT "What do you desire?"
    PRINT "(D)eposit"
    PRINT "(W)ithdraw"
    PRINT "(R)eturn to the town center"
    INPUT action$

    SELECT CASE action$
        CASE "D"
            PRINT "At most you may deposit "; gold; "."
            INPUT "How much do you want to deposit? "; action
            IF action >= 0 AND action <= gold THEN
                bankGold = bankGold + (action * 0.9)
                gold = gold - action
                PRINT "Done!"
            ELSE
                PRINT "I cannot do this amount without breaking the rules."
            END IF
        CASE "W"
            PRINT "You may withdraw at most "; bankGold; "."
            INPUT "How much to withdraw? "; action
            IF action >=0 AND action <= bankGold THEN
                gold = gold + action
                bankGold = bankGold - action
                PRINT "Done!"
            ELSE
                PRINT "I cannot do this without breaking the rules."
            END IF
        CASE "R"
            PRINT "I expect great things from you!"
            RETURN
        END SELECT

        GOTO 30

[WEAPON_SHOP]
35  cost = int((level ^ 3 * damageQ * 100) / (heroicDeeds + 1))
    CLS
    PRINT "The shopkeeper gives you a stern gaze in the eye."
    PRINT "I only upgrade weapons. Costs "; cost; " for you. Now what do you want?"
    PRINT "(I)ncense weapon strength"
    PRINT "(R)eturn to town center"
    INPUT action$

    SELECT CASE action$
        CASE "I"
            CLS
            IF gold >= cost THEN
                PRINT "You have succesfully upgraded your weapon!"
                damageQ = damageQ + 1
                gold = gold - cost
            ELSE
                PRINT "Does this look like a charity service to you?"
            END IF
        CASE "R"
            CLS
            PRINT "Thanks for leaving! Now I can go back to sleep."
            RETURN
    END SELECT

    GOTO 35

[ARMOUR_SHOP]
40  cost = int((level ^ 3 * defenseQ * 100) / (heroicDeeds + 1))
    CLS
    PRINT "The shopkeeper gives you a kind look as you enter the room."
    PRINT "What can I do for you today? Upgrading your armor will cost " ; cost; "."
    PRINT "(I)ncense armor hardness"
    PRINT "(R)eturn to the town center"
    INPUT action$

    SELECT CASE action$
        CASE "I"
            CLS
            IF gold >= cost THEN
                PRINT "You have succesfully upgraded your armor!"
                defenseQ = defenseQ + 1
                gold = gold - cost
            ELSE
                PRINT "Does this look like a charity service to you?"
            END IF
        CASE "R"
            CLS
            PRINT "Thank you. I await your next visit."
            RETURN
    END SELECT

    GOTO 40

[BATTLE]
    CLS
    PRINT "You encounter a beast!"
    IF (enemySpeed * RND(0) + enemySpeed) > (speed * RND(0) + speed) OR RND(0) < 0.4 THEN
        PRINT "You have been suprrised!"
        damageGiven = int(level * level / defenseQ * rnd(0) * 10 + 0.1)
        health = health - damageGiven
        PRINT "You have been hit for "; damageGiven; " damage!"
        IF health <= 0 THEN
            PRINT
            PRINT "The enemy knocks you down with a fine slash."
            PRINT "You attempt to get up, but your vision blurs..."
            enemyHealth = enemyMaxHealth
            GOSUB [PENALTY]
            RETURN
         END IF
    END IF
    mEncounter = mEncounter + 1
45  PRINT enemyName$(RND(0) * 7); ": "; enemyHealth
    PRINT alias$; ": "; health
    PRINT
    PRINT "The enemy looks at you menacingly. You get the first strike."
    PRINT "What would you like to do?"
    PRINT "(A)ttack the enemy"
    PRINT "(F)lee"
    INPUT action$

    SELECT CASE action$
        CASE "A"
            CLS
            PRINT "You lunge at the enemy with your weapon."
            damageGiven = int(level * damageQ * rnd(0) * 14 + 0.1)
            PRINT "You gave "; damageGiven; " damage!"
            enemyHealth = enemyHealth - damageGiven

            IF enemyHealth <= 0 THEN
                enemyHealth = enemyMaxHealth
                PRINT "The enemy, with a groan of anguish, falls by your feat, dead."
                PRINT "You have slain the beast!"
                PRINT "You have gained some gold!"
                PRINT "You have acquired some experience!"

                gold = int(gold + (level ^ 2 * rnd(0) * 10 + 0.1))
                exp = int(exp + (level * level * rnd(0) * 5 + 0.5)) * (heroicDeeds + 1)
                mKill = mKill + 1
                RETURN
            END IF

            PRINT "Your adversary makes its move."
            damageGiven = int(level * level / defenseQ * rnd(0) * 3 + 0.1)
            PRINT "You are hit with "; damageGiven; " damage!"
            health = health - damageGiven

        CASE "F"
            CLS
            PRINT "You run away. Grow some strengh next time!"
            RETURN
    END SELECT

    IF health <= 0 THEN
        PRINT
        PRINT "The enemy knocks you down with a fine slash."
        PRINT "You attempt to get up, but your vision blurs..."
        enemyHealth = enemyMaxHealth
        GOSUB [PENALTY]
        RETURN
    END IF

    GOTO 45

[FIGHT]
    CLS
    PRINT "We who are about to die salute you."
    PRINT
    PRINT "The crowd goes silent as a seven feet tall man approaches you."
    PRINT "His name is Arabest, and he is who fights to the death."
    PRINT "In order to become the true warrior, you must defeat him "; 10 - level; " more times."
    PRINT
50  PRINT "Arabest Level"; level; ": "; arabestHealth
    PRINT alias$; ": "; health

    PRINT
    PRINT "The enemy looks at you menacingly. You get the first strike."
    PRINT "What would you like to do?"
    PRINT "(A)ttack"
    INPUT action$

    SELECT CASE action$
        CASE "A"
            CLS
            PRINT "You lunge at the enemy with your weapon."
            damageGiven = int(level * damageQ * rnd(0) * 9 + 0.1)
            PRINT "You gave "; damageGiven; " damage!"
            arabestHealth = arabestHealth - damageGiven

            IF arabestHealth <= 0 THEN
                arabestHealth = int(arabestMaxHealth ^ 1.5)
                PRINT "Arabest shrieks in agony."
                PRINT "You have defeated your master!"
                PRINT "Congratulations! You have advanced one level!"
                level = level + 1
                maxHealth = maxHealth + level * 10
                health = maxHealth
                speed = int(speed * 2.5)
                enemyMaxHealth = level * 15
                enemyHealth = enemyMaxHealth
                enemySpeed = enemySpeed + level * 3
                RETURN
            END IF

            PRINT "Arabest makes his move."
            damageGiven = int(level * level / defenseQ * rnd(0) * 11 + 0.1)
            PRINT "You are hit with "; damageGiven; " damage!"
            health = health - damageGiven
    END SELECT

    IF health <= 0 THEN
        PRINT
        PRINT "Arabest knocks you down with a fine slash."
        PRINT "You attempt to get up, but your vision blurs..."
        PRINT "You have lost the tournament battle."
        arabestHealth = arabestMaxHealth
        health = maxHealth
        RETURN
    END IF

    GOTO 50

[MISSION]
    CLS
    PRINT "The general redirects you to a wall with a plethora of missions for you to complete."
    PRINT "(R)econnaisance - Costs 100 EXP"
    PRINT "(S)kirmish - Costs 200 EXP and 30 HEALTH"
    PRINT "(A)mbush Highwaymen - Costs 1000 EXP and 100 HEALTH"
    PRINT "(M)urder the Dragon - Costs 1000000 EXP and your life"
    PRINT "(G)o back to the town center"
55  INPUT "Which mission would you like to complete? "; action$
    SELECT CASE action$
        CASE "R"
            IF exp >= 100 THEN
                PRINT "While spying, you managed to salvage 1000 gold!"
                gold = gold + 1000
                exp = exp - 100
            ELSE
                PRINT "Your experience is not enough to complete this mission."
            END IF
        CASE "S"
            IF exp >= 200 AND health > 30 THEN
                PRINT "The skirmish is over, and you have salvated 3000 gold at the cost of minor injury."
                gold = gold + 3000
                health = health - 30
                exp = exp - 200
            ELSE
                PRINT "Your experience or health is not enough to complete this mission."
            END IF
        CASE "A"
            IF exp >= 1000 AND health > 1000 THEN
                PRINT "The highwaymen flee, and you salvage 30000 gold and additional strength at the cost of wounds."
                damageQ = damageQ + 1
                gold = gold + 30000
                health = health - 100
                exp = exp - 1000
            ELSE
                PRINT "Your experience or health is not enough to complete this mission."
            END IF
        CASE "M"
            IF exp >= 1000000 AND level >= 10 THEN
                exp = exp - 1000000
                GOTO [DRAGON]
            ELSE
                PRINT "The company prevents you from completing this mission until later."
            END IF
        CASE "G"
            CLS
            PRINT "The general bids you farewell."
            RETURN
    END SELECT

    GOTO 55

    RETURN

[CASINO]
    CLS
    PRINT "The smell of gambling is in the air. Winners and losers gather at one place: here."
    PRINT "You head towards your lottery area in order to press your luck at doubled gold."
60  PRINT "What do you wish to do with your gold?"
    PRINT "(S)lots"
    PRINT "(R)oulette"
    PRINT "(L)eave"
    INPUT action$

    SELECT CASE action$
        CASE "S"
            INPUT "How much money are you willing to gamble? "; action
            IF action >= 0 AND action <= gold THEN
                gold = gold - action
                FOR I = 0 TO 2 STEP 1
                    slot(I) = int(RND(0) * 3)
                    SELECT CASE slot(I)
                        CASE 0
                            PRINT "BAR"
                        CASE 1
                            PRINT "CHERRY"
                        CASE 2
                            PRINT "SEVEN"
                    END SELECT
                NEXT I
                IF slot(0) = slot(1) AND slot(1) = slot(2) AND slot(2) = slot(0) THEN
                    SELECT CASE slot(0)
                        CASE 0
                            PRINT "GOLD X2"
                            gold = gold + action * 2
                        CASE 1
                            PRINT "GOLD X1"
                            gold = gold + action * 1
                        CASE 2
                            PRINT "GOLD X4"
                            gold = gold + action * 4
                    END SELECT
                ELSE
                    PRINT "Sorry!"
                END IF
            ELSE
                PRINT "The machine does not accept the bid."
            END IF
        CASE "R"
            INPUT "How much money are you willing to gamble? "; action
            IF action >= 0 AND action <= gold THEN
                gold = gold - action
            ELSE
                PRINT "The machine does not accept your bid."
                GOTO 60
            END IF
            PRINT
            PRINT "(A) 0 - 4"
            PRINT "(B) 5 - 9"
            PRINT "(C) 10 - 14"
            PRINT "(D) 15 - 19"
            PRINT "(E) 19 - 24"
59          INPUT "What is your number range? "; action$
            ball = int(RND(0) * 25 + 0.5)
            IF action$ = "A" OR action$ = "B" OR action$ = "C" OR action$ = "D" OR action$ = "E" THEN
                IF (ball >= 0 AND ball <= 4 AND action$ = "A") OR (ball >= 5 AND ball <= 9 AND action$ = "B") OR (ball >= 10 AND ball <= 14 AND action$ = "C") OR (ball >= 15 AND ball <= 19 AND action$ = "D") OR (ball >= 20 AND ball <= 24 AND action$ = "E") THEN
                    gold = int(gold + action * 1.5 + 0.5)
                    PRINT "Good job! The number was "; ball; "."
                ELSE
                    PRINT "Sorry, the number was "; ball; "."
                END IF
            ELSE
                GOTO 59
            END IF
        CASE "L"
            PRINT "You get up off your seat and head back to the town center."
            RETURN
        END SELECT

        GOTO 60

[DRAGON]
    CLS
    PRINT "THE QUEST FOR THE BLACK DRAGON"
    PRINT "------------------------------"
    PRINT "You turn back and speak with the general, saying that you are ready to slay the dragon."
    PRINT "He spits out his wine in shock and gives you a dumbfounded look. Everyone else does as well."
    PRINT "You follow him to the town center, where apparently, everyone heard the news."
    PRINT "He leads you to the hills, and you say one thing before leaving your family forever."
    PRINT
    PRINT "We who are about to die salute you."
    INPUT ""; action$
    CLS
    PRINT "Nine days have passed since  you have been wandering in the hills searching for the black dragon."
    PRINT "If it comes and ransacks the town every day, why is it so difficut to find? The hills are not massive anyway."
    PRINT "Hungry, you lay down on the grass and wait, and several minutes later, you hear screaming and smoke from a cave."
    PRINT "You rush towards the cave, and a humungous black serpentine shape captivates your eyes as it eats one of your friends."
    INPUT ""; action$
    CLS
    PRINT "When the decapitation is done, the dragon tosses the body to the side to let it fester along with the others."
    PRINT "You march inside the cave, and bellow at the dragon."
    PRINT "My name is "; alias$; " and I will have my revenge!"
    PRINT "The dragon looks at you."
    INPUT ""; action$
    GOTO [FINAL_BATTLE]

[FINAL_BATTLE]
    CLS
    PRINT "THE FINAL BATTLE"
    PRINT "----------------"
    PRINT "We who are about to die salute you."
    PRINT
    PRINT "The dragon slithers your way and hurls a fireball at you."
    PRINT "You skilfully sidestep and block with your sword, deflectin the blow"
    PRINT "This is what you have been training for. Make your country proud, and die like a hero."
    PRINT
99  PRINT "Black Dragon: "; dragonHealth
    PRINT alias$; ": "; health

    PRINT
    PRINT "The dragon looks at you menacingly. You get the first strike."
    PRINT "What would you like to do?"
    INPUT action$

    SELECT CASE action$
        CASE "A"
            CLS
            PRINT "You lunge at the dragon with your weapon."
            damageGiven = int(level / 2 * damageQ * rnd(0) * 5 + 0.1)
            PRINT "You gave "; damageGiven; " damage!"
            dragonHealth = dragonHealth - damageGiven

            IF dragonHealth <= 0 THEN
                dragonHealth = (heroicDeeds + 1) * 2000000
                level = 1
                gold = 500
                bankGold = 0
                damageQ = 1
                defenseQ = 1
                GOTO [CLOSING]
            END IF

            PRINT "The black dragon makes his move."
            damageGiven = int(level * level / defenseQ * rnd(0) * 20 + 0.1)
            PRINT "You are hit with "; damageGiven; " damage!"
            health = health - damageGiven
    END SELECT

    IF health <= 0 THEN
        PRINT
        PRINT "The dragon hits you with a stray fireball."
        PRINT "You attempt to get up, but your vision blurs..."
        PRINT "The next thing you know, you wake up from a nightmare."
        PRINT "Do not die at the real battle."
        dragonHealth = 1000000
        health = maxHealth
        GOTO [TOWN_SQUARE]
    END IF

    GOTO 99


[PROFILE]
    PRINT
    PRINT "BASIC"
    PRINT "--"
    PRINT "Alias: "; alias$
    PRINT "Class: "; class$
    PRINT "Level: "; level
    PRINT "Experience: "; exp
    PRINT "Gold: "; gold
    PRINT "Bank Gold: "; bankGold
    PRINT "Health: "; health
    PRINT "Attack: "; damageQ
    PRINT "Defense: "; defenseQ
    PRINT "Speed: "; speed
    PRINT
    PRINT "STATS"
    PRINT "--"
    PRINT "Monsters Encountered: "; mEncounter
    PRINT "Monster Kills: "; mKill
    PRINT "Heroic Deeds: "; heroicDeeds
    INPUT ""; action$
    RETURN

[CLOSING]
    CLS
    PRINT "The dragon falls, nearly crushing you, but you step back and the head barely misses your feet."
    PRINT "You walk to the side of the dragon and stare at its neck, and you hold your sword up."
    PRINT "The decapitator gets decapitated. You chop its head off and throw it off of the cliff."
    PRINT "I came, I saw, I killed."
    INPUT ""; action$
    CLS
    PRINT "You have beaten INTERFECI! Fun fact: INTERFECI is Latin for I killed."
    PRINT "The next time you begin the game, you will get double experience and cheaper products."
    PRINT "Thank you for playing INTERFECI!"
    PRINT
    heroicDeeds = heroicDeeds + 1
    GOSUB [SAVE_GAME]
    INPUT ""; action$
    GOTO  [STD_VARIABLES]

[PENALTY]
    CLS
    PRINT "It has been a long and arduous journey for you. You are tired and ready to retire."
    PRINT "However, you cannot do that until you slay the black dragon!"
    PRINT "The townspeople have hired a medic for you. At the expense of your injuries, you are reset to level 1 with 0 experience."
    PRINT "Your weapons and armor have not been reset."
    PRINT "On the bright side, the government doubled the gold in your bank account. For the sake of your town, don't die again!"
    level = 1
    exp = 0
    bankGold = bankGold * 2
    health = maxHealth
    RETURN

[LOG]
    CLS
    PRINT "VERSION LOG"
    PRINT "-----------"
    PRINT "v1.0 - Game finished with basic features"
    PRINT "v1.1 - Log added for development updates"
    PRINT "v1.2 - Casino added as for doubling gold"
    PRINT "v1.3 - Added gaming instructions to play"
    PRINT "v1.4 - Encryption added to the save file"
    PRINT "v1.5 - Fixed save glitch and added speed"
    PRINT "v1.6 - Added to the casino with roulette"

END
