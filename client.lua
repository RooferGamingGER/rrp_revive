local recentlyRevived = 0

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if recentlyRevived > 0 then
                recentlyRevived = recentlyRevived - 1
            end
        end
    end
)

function RespawnPedInPlace()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(playerPed, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(playerPed)
end

RegisterCommand("revive", function(source, args, rawCommand)
    if recentlyRevived <= 0 then
        recentlyRevived = 15
        RespawnPedInPlace()
    else
        TriggerEvent("chat:systemMessage", "Please wait 15 seconds before reviving again.")
    end
end, false)