ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('apx_menu:SvMenu', function()
    local _source <const> = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local info = {
        money = xPlayer.getMoney(),
        bank = xPlayer.getAccount('bank').money,
        black = xPlayer.getAccount('black_money').money
    }
    TriggerClientEvent('apx_menu:OpenMenu', _source, info)
end)