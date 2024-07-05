if Config.framework = 'qbcore'
    console('The framework is QBCore')
    exports['qb-core']:GetCoreObject()
else Config.framwork = 'esx'
    console('The framework is ESX')
    ESX = exports["es_extended"]:getSharedObject()
else Config.framwork = 'oldesx'
    console('The framework is Old ESX')
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
-- else Config.framework = 'custom'
-- Your Framework get core
end


RegisterCommand('livery', function(source, args)
    local livery = tonumber(args[1])
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local count = GetVehicleLiveryCount(veh)
    local inveh = IsPedInAnyVehicle(ped, false)

    if inveh then
        if livery <= count and livery ~= 0 then
            SetVehicleLivery(veh, livery)

        else
            if Config.Notify = 'esx'
                TriggerClientEvent('esx:showNotification', source, Notify(locale('invalid_livery'), 'error'))
            elseif Config.Notify = 'qbcore'
                QBCore.Functions.Notify(locale('invalid_livery'), "error")
            --elseif Config.Notify = 'custom'
            -- Your Notify
            end
        end
    else Config.Notify = 'esx'
        TriggerClientEvent('esx:showNotification', source, Notify(locale('not_veh'), 'error'))
    else Config.Notify = 'qbcore'
        QBCore.Functions.Notify(locale('not_veh'), "error")
    -- else Config.Notify = 'custom'
    -- Your Notify
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(4000)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        local count = GetVehicleLiveryCount(veh)
        local inveh = IsPedInAnyVehicle(ped, false)

        local text = {}

        if inveh and count ~= -1 then
            text = string.format("Este vehículo tiene %d livery", count)

        elseif inveh and count == -1 then
            text = "Este vehículo no tiene livery"

        else
            text = "No estas en el vehiculo"
        end


        TriggerEvent('chat:addSuggestion', '/livery', 'Cambiar pintura', {
            { name="livery", help=text },
        })
    end
end)
