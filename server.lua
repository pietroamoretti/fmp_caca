-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRPclient = Tunnel.getInterface("vRP")
local addItemFunction = load('return ' .. Config.addItemFunction)()
local removeItemFunction = load('return ' .. Config.removeItemFunction)()


RegisterServerEvent('progress')
AddEventHandler('progress', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    TriggerClientEvent(Config.progress,_source,10000,"Coletando materiais para iniciar sua caçada")
   -- TriggerClientEvent('emotes', _source, 'prancheta')
    Citizen.Wait(10000)
    --TriggerClientEvent('cancelando',_source,true)
    ClearPedSecondaryTask(_source) 
end)

-- ...
RegisterServerEvent('startHuntingAnim')
AddEventHandler('startHuntingAnim', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    TriggerClientEvent('emotes', _source, 'verificar')
    Citizen.Wait(10000)
    local chosenItem = Config.randomItems[math.random(#Config.randomItems)]
    addItemFunction(user_id, chosenItem, 1, true)
    for item, amount in pairs(Config.huntingItem) do
     addItemFunction(user_id, item, amount, true)
    end
end)
-- ...





-- ...
RegisterServerEvent('tirararmas')
AddEventHandler('tirararmas', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    for item, amount in pairs(Config.itemsToRemove) do
        removeItemFunction(user_id, item, amount, true)
    end
end)
-- ...


RegisterServerEvent('stopHuntingAnim')
AddEventHandler('stopHuntingAnim', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    TriggerClientEvent('cancelando',_source,false)
end)

-- ...
RegisterServerEvent('dararmas')
AddEventHandler('dararmas', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    for item, amount in pairs(Config.items) do
        addItemFunction(user_id, item, amount, true)
    end
end)
--[[RegisterServerEvent('dararmas2')
AddEventHandler('dararmas2', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    vRP.giveInventoryItem(user_id, "WEAPON_KNIFE", 1, 1, 2)
end)


RegisterServerEvent('dararmas3')
AddEventHandler('dararmas3', function()
    local __source = source
    local user_id = vRP.getUserId(__source)
    vRP.giveInventoryItem(user_id, "cm1", 1, 1, 3)
end)
--]]


------------------------------------------------------------------------------------
-----------------------------------DELIVERY-----------------------------------------
------------------------------------------------------------------------------------
RegisterCommand("delivery", function(source, args, rawCommand)
    local coords = Config.rotasDelivery[math.random(#Config.rotasDelivery)]
    TriggerClientEvent('setDeliveryPoint', source, coords.x, coords.y, coords.z)
end, false)

RegisterServerEvent('trocaDelivery')
AddEventHandler('trocaDelivery', function()
    local _source = source
    local user_id = vRP.getUserId(_source)
    TriggerClientEvent(Config.progress, _source, 10000, "Efetuando a venda")
    Citizen.Wait(10000)
    TriggerClientEvent(Config.notify, _source, "Venda concluída com sucesso!")

    if Config.itemDinheiro == '' then
        local amount = tonumber(Config.qtdDinheiro) 
        vRP.giveMoney(user_id, amount)
    else
        local item = Config.itemDinheiro
        local amount = tonumber(Config.qtdDinheiro) 
        addItemFunction(user_id, item, amount, true)
    end
end)