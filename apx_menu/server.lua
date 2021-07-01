ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent("apx_menu:SvMenu")
AddEventHandler("apx_menu:SvMenu", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local getmoney = xPlayer.getMoney()
    local getmoneybank = xPlayer.getAccount('bank').money
    local getmoneynegro = xPlayer.getAccount('black_money').money
    -- local getcoins = xPlayer.getAccount('nortecoins').money
    TriggerClientEvent("apx_menu:OpenMenu", source, getmoney, getmoneybank, getmoneynegro)
end)


