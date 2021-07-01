ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local PlayerClub, PlayerRankNum = nil, 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer
    ESX.TriggerServerCallback('sody_clubs:getPlayerClub', function(playerdata)
        PlayerClub = playerdata.club
        PlayerRankNum = playerdata.club_rank
    end)
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1, 57) then
      TriggerServerEvent("apx_menu:SvMenu")
    end
  end
end)


RegisterNetEvent("apx_menu:OpenMenu")
AddEventHandler("apx_menu:OpenMenu", function(dineromano, dinerobanco, blackmmoney )
    if PlayerClub == nil then
        OpenInfoMenu(dineromano, dinerobanco, blackmmoney )
    end

end)


function OpenInfoMenu(dineromano, dinerobanco, blackmmoney )
    ESX.UI.Menu.CloseAll()

    Trabajo = ("Trabajo: " ..ESX.PlayerData.job.label)
    Rango = ("Rango: " ..ESX.PlayerData.job.grade_label)
    DineroMano2 = ("Dinero: " ..dineromano)
    DineroBanco2 = ("Banco: " ..dinerobanco)
    DineroNegro2 = ("Dinero Negro: " ..blackmmoney)


    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'info', {
        title = 'Informacion Del jugador',
        align = 'bottom-right',
        elements = {
            {label = Trabajo, value = 'nil'},
            {label = Rango, value = 'nil'},
            {label = DineroMano2, value = 'nil'},
            {label = DineroBanco2, value = 'nil'},
            {label = DineroNegro2, value = 'nil'},
            {label = 'Dinero de Sociedad', value = 'bossmoney'}
        }
    }, function(data, menu)
        if data.current.value == 'nil' then
        elseif data.current.value == 'bossmoney' and ESX.PlayerData.job.grade_name == 'boss' then
            ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_label', {
                    title    = 'Dinero de Sociedad',
                    align    = 'bottom-right',
                    elements = {
                        {label = 'Dinero de Sociedad:  ' .. money, value = 'society_label'}
                    }}, function(data3, menu3)
                end, function(data3, menu3)
                    menu3.close()
                end)

            end, ESX.PlayerData.job.name)
        else
            ESX.ShowNotification("No eres Jefe de una Facción")
        end
          menu.close()
    end, function(data, menu)
        menu.close()
    end)
end







