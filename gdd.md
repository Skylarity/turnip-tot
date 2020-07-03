# Turnip Tot Game Design Document

## The Tot

Much like a Tamagotchi, the Tot requires human care. The player will need to feed the Tot, play with the Tot, and clean up after the Tot.

The Tot will produce visual indicators of its mood at all times in the form of icons floating away from it:

-   Happy
    -   Music notes
-   Bored
    -   Ellipses
-   Sad
    -   Broken hearts
-   Hungry
    -   Fork & knife
-   Sick
    -   Skulls

## Player Tasks

**These must be four-letter words in order to maintain UI placement.**

### PLAY

Spawns a ball that the player can "push" around the Tot's pen using the d-pad. Each press will apply an impulse to the ball. The Tot will chase the ball, and the player will need to play keepaway while still letting the Tot get the ball sometimes, otherwise the Tot will become sad (not getting the ball enough) or bored (getting the ball too easily), at which point the game will end. The player can also choose to end the game while the Tot is happy.

### FEED

When the Tot's hunger gets low the player will need to feed the Tot. When feeding the Tot, the player will be given a choice of food, and a choice of where to place the food in the pen. Healthy food will not raise the Tot's happiness, but also won't have a chance to cause sickness. Unhealthy food will raise the Tot's happiness, but also lower the Tot's health.

### TIDY

When the Tot is full (hunger at greater than ~85%) it will occasionally produce waste. The player must tidy the Tot's pen before too much waste accrues (>5 pieces) or else its health will start to deteriorate.

When tidying, the player is given a minigame where they must scoop the waste and carry it to a trash can. The Tot will chase the player around, and if it catches the player it will knock the waste out of the scoop. The player can move slightly faster than the Tot.

### CURE

When the Tot's health is less than full, the player must give it medicine. If the Tot's health drops to zero then it will pass away and the player will lose (and feel like an AWFUL PERSON).

To give the Tot medicine, the player must hide it under a treat. The treat will appear in a random place in the pen (maybe a certain distance away from the Tot?) and the player must use the d-pad to place the medicine on the treat before the Tot eats it. If the player fails three times in a row, they will not be able to cure the Tot for 5 realtime minutes.

## Happiness

The Tot's happiness level does not automatically decrease or increase, but is determined by experiences. The one exception is that if the player goes too long without interaction (any of the player tasks count) then the Tot will become sad.

If the Tot's happiness drops to zero then it will stop eating and start a chain of events that will eventually cause it to become sick and potentially die.

## Notes

How to get the current real-world time: ([reddit reference](https://www.reddit.com/r/pico8/comments/9p93hp/any_way_to_get_current_time/))

```lua
stat(80) -- UTC year
stat(81) -- UTC month
stat(82) -- UTC day
stat(83) -- UTC hour
stat(84) -- UTC minute
stat(85) -- UTC second

stat(90) -- local year
stat(91) -- local month
stat(92) -- local day
stat(93) -- local hour
stat(94) -- local minute
stat(95) -- local second
```
