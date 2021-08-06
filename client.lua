local CreateThread = CreateThread

ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(250)
    end

    while ESX.GetPlayerData().job == nil do Wait(10) end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

-- Opening menu
local function openServerMenu()
    TriggerServerEvent("apx_menu:SvMenu")
end

RegisterCommand('menu', openServerMenu)

RegisterKeyMapping('menu', 'Open interaction menu', 'keyboard', 'f10')

RegisterNetEvent('apx_menu:OpenMenu', function(info)
    OpenInfoMenu(info)
end)

function OpenInfoMenu(info)
    ESX.UI.Menu.CloseAll()

    Trabajo = ("Trabajo: " .. ESX.PlayerData.job.label)
    Rango = ("Rango: " .. ESX.PlayerData.job.grade_label)
    DineroMano2 = ("Dinero: " .. info.money)
    DineroBanco2 = ("Banco: " .. info.bank)
    DineroNegro2 = ("Dinero Negro: " .. info.black)

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
                    }}, function(data2, menu2)
                end, function(data2, menu2)
                    menu2.close()
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