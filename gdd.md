# Turnip Tot Game Design Document

## The Tot

Much like a Tamagotchi, the Tot requires human care. The player will need to feed the Tot, play with the Tot, and clean up after the Tot.

## Food

The Tot gets hungry over time, requiring a meal when it reaches a certain hunger level.
You can feed the tot snacks to increase happiness, but too many snacks will cause sickness. Snacks do not decrease hunger, only meals do. However, snacks too close to meal time can cause the tot to refuse to eat, causing happiness to decrease.

## Happiness

The Tot's happiness level does not automatically decrease or increase, but is determined by experiences. The one exception is that if the player goes too long without interaction then the Tot will become sad.

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
