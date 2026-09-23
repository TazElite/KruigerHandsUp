Config = {}

-- Hands up
Config.Command = 'handsup'
Config.Key = 'X'
Config.AnimationDictionary = 'missminuteman_1ig_2'
Config.AnimationName = 'handsup_base'
Config.AnimationFlag = 49

-- Hands on knees (/huk)
-- This does not remove, holster, or change the player's selected weapon.
Config.HUKCommand = 'huk'
Config.HUKAnimationDictionary = 'random@arrests'
Config.HUKAnimationName = 'kneeling_arrest_idle'
Config.HUKAnimationFlag = 1

-- Controls blocked while either surrender stance is active.
Config.DisableControls = {
    24,  -- Attack
    25,  -- Aim
    37,  -- Weapon wheel
    44,  -- Cover
    45,  -- Reload
    140, -- Melee light
    141, -- Melee heavy
    142, -- Melee alternate
    257, -- Attack 2
    263, -- Melee attack 1
    264  -- Melee attack 2
}
