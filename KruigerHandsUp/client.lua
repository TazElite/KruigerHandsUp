local stance = nil -- nil, "handsup", or "huk"

local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return true end
    RequestAnimDict(dict)
    local timeout = GetGameTimer() + 5000
    while not HasAnimDictLoaded(dict) do
        if GetGameTimer() > timeout then return false end
        Wait(10)
    end
    return true
end

local function currentAnim()
    if stance == "handsup" then
        return Config.AnimationDictionary, Config.AnimationName, Config.AnimationFlag
    elseif stance == "huk" then
        return Config.HUKAnimationDictionary, Config.HUKAnimationName, Config.HUKAnimationFlag
    end
end

local function clearStance()
    if not stance then return end
    local ped = PlayerPedId()
    local dict, anim = currentAnim()
    stance = nil
    if dict and anim then StopAnimTask(ped, dict, anim, 2.0) end
    ClearPedSecondaryTask(ped)
end

local function setStance(nextStance)
    local ped = PlayerPedId()
    if IsEntityDead(ped) or IsPedRagdoll(ped) or IsPedInAnyVehicle(ped, false) then return end

    if stance == nextStance then
        clearStance()
        return
    end

    if stance then clearStance() end

    local dict, anim, flag
    if nextStance == "handsup" then
        dict, anim, flag = Config.AnimationDictionary, Config.AnimationName, Config.AnimationFlag
    else
        dict, anim, flag = Config.HUKAnimationDictionary, Config.HUKAnimationName, Config.HUKAnimationFlag
    end

    if not loadAnimDict(dict) then return end
    stance = nextStance

    -- Intentionally do not call SetCurrentPedWeapon/RemoveWeaponFromPed.
    -- The player's selected weapon remains selected while the stance plays.
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, flag, 0.0, false, false, false)
end

RegisterCommand(Config.Command, function() setStance("handsup") end, false)
RegisterKeyMapping(Config.Command, 'Toggle hands up', 'keyboard', Config.Key)
RegisterCommand(Config.HUKCommand, function() setStance("huk") end, false)

CreateThread(function()
    while true do
        if stance then
            local ped = PlayerPedId()
            if IsEntityDead(ped) or IsPedRagdoll(ped) or IsPedInAnyVehicle(ped, false) then
                clearStance()
            else
                local dict, anim, flag = currentAnim()
                if dict and anim and not IsEntityPlayingAnim(ped, dict, anim, 3) then
                    if loadAnimDict(dict) then
                        TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, flag, 0.0, false, false, false)
                    end
                end
                for i = 1, #Config.DisableControls do
                    DisableControlAction(0, Config.DisableControls[i], true)
                end
            end
            Wait(0)
        else
            Wait(500)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    clearStance()
end)

exports('IsHandsUp', function() return stance == "handsup" end)
exports('IsHUK', function() return stance == "huk" end)
exports('GetSurrenderStance', function() return stance end)
