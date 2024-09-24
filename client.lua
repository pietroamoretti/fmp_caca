-- VRP

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
--------------------------------------------------------------------------------------
------------------------FUNCTIONS SPAWNS----------------------------------------------
--------------------------------------------------------------------------------------
local hunting = false
local spawnedVehicle = nil
local spawnedDeers = {}

local function startHunting()
    local ped = PlayerPedId()
    local vehicle = GetHashKey(Config.veiculoSpawn)

    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end

    spawnedVehicle = CreateVehicle(vehicle, Config.localizacaoVeiculo.x, Config.localizacaoVeiculo.y, Config.localizacaoVeiculo.z, Config.localizacaoVeiculo.h, true, false)

    for i = 1, 3 do
        local deer = GetHashKey(Config.animalSpawn)
        RequestModel(deer)
        while not HasModelLoaded(deer) do
            Wait(1)
        end

        local animal = CreatePed(Config.blipanimal, deer, Config.localizaoAnimal.x + math.random(10, 20), Config.localizaoAnimal.y + math.random(10, 20), Config.localizaoAnimal.z, Config.localizaoAnimal.h, true, false)
        TaskWanderStandard(animal, 10, 10)

        local blip = AddBlipForEntity(animal)
        SetBlipSprite(blip, 442)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Animal Vivo")
        EndTextCommandSetBlipName(blip)

        table.insert(spawnedDeers, { animal = animal, blip = blip })
    end
    TriggerServerEvent("progress")
    Citizen.Wait(10000)
    ClearPedTasks(ped)
    ClearPedSecondaryTask(ped)
    TriggerServerEvent("dararmas")
    TriggerServerEvent("dararmas2")
    TriggerServerEvent("dararmas3")
    TriggerEvent(Config.notify,"verde","Você coletou os materias necessários",20000)
    TriggerEvent(Config.notify,"amarelo","Sua caçada foi marcada em seu mapa",20000)
end

local function stopHunting()
    if spawnedVehicle then
        DeleteEntity(spawnedVehicle)
        spawnedVehicle = nil
    end

    for _, deer in ipairs(spawnedDeers) do
        DeleteEntity(deer.animal)
        RemoveBlip(deer.blip)
    end
    spawnedDeers = {}

    hunting = false

    TriggerEvent(Config.notify,"vermelho","Voce saiu do serviço de caça",20000)
    TriggerServerEvent("tirararmas")
end


Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped) 
        local distance = #(coords - vector3(-679.460693359375,5834.02783203125,17.33130073547363))
        if distance < 10 then
            DrawMarker(31,-679.460693359375,5834.02783203125,17.33130073547363,0,0,0,0,0,0,1.00,1.00,1.00,255,255,255,100,0,0,0,1)
            time = 1
            if IsControlJustPressed(1, 51) then
                if hunting then
                    stopHunting()
                else
                    hunting = true
                    startHunting()
                end
            end
        end
        Wait(time)
    end
end)
--------------------------------------------------------------------------------------
------------------------COLETA--------------------------------------------------------
--------------------------------------------------------------------------------------

local collectedDeers = {}
local deerBlips = {}

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if hunting then
            local ped = PlayerPedId()
            local knifeHash = GetHashKey("weapon_knife")
            for i, deer in ipairs(spawnedDeers) do
                local deerCoords = GetEntityCoords(deer.animal)
                if IsEntityDead(deer.animal) then
                    if Vdist(GetEntityCoords(ped), deerCoords.x, deerCoords.y, deerCoords.z) < 3.0 then
                        if collectedDeers[deer.animal] then
                            TriggerEvent(Config.notify, "vermelho", "Você já coletou este veado.", 20000)
                        else
                            DrawMarker(31, deerCoords.x, deerCoords.y, deerCoords.z + 1.5, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 255, 0, 0, 100, 0, 0, 0, 1)
                            DrawText3D(deerCoords.x, deerCoords.y, deerCoords.z + 1.0, "Pressione [E] para coletar a carne")
                            if IsControlJustReleased(1, 51) and GetSelectedPedWeapon(ped) == knifeHash then
                                TriggerServerEvent('startHuntingAnim')
                                Citizen.Wait(10000)
                                TriggerEvent(Config.notify, "verde", "Voce esfolou o veado", 20000)
                                ClearPedTasks(ped)
                                DeleteEntity(deer.animal)
                                RemoveBlip(deer.blip)
                                deerBlips[deer] = nil
                                table.remove(spawnedDeers, i)
                            elseif IsControlJustReleased(1, 51) and GetSelectedPedWeapon(ped) ~= knifeHash then
                                TriggerEvent(Config.notify, "vermelho", "Você precisa estar com a faca na mão para coletar a carne.", 20000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------------------------------------------------------
----------------------------------------NPC--------------------------------------------
---------------------------------------------------------------------------------------
Citizen.CreateThread(function()

    RequestModel(GetHashKey(Config.npcTrabalho))
    while not HasModelLoaded(GetHashKey(Config.npcTrabalho)) do
        Citizen.Wait(1)
    end

    local npc = CreatePed(4, GetHashKey(Config.npcTrabalho),-679.04,5834.43,16.34, 135.62, false, false)

    SetEntityInvincible(npc, true)

    FreezeEntityPosition(npc, true)

    while true do
        Citizen.Wait(0)
        TaskStandStill(npc, -1)
    end
end)

------------------------------------------------------------------------------------
-------------------------DELIVERY---------------------------------------------------
------------------------------------------------------------------------------------


function MyDrawText3D(x, y, z, text, r, g, b, a)
    local onScreen,_x,_y = World3dToScreen2d(x, y, z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
 end

 function createNPC(coords)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - coords)

    local ped = nil
    local waypointBlip = nil

    if distance < 1000 then
        local hash = GetHashKey(Config.npcDelivery)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Wait(1)
        end

        local groundZ = 0
        local _, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z)
        coords = vector3(coords.x, coords.y, groundZ)
        
        ped = CreatePed(4, hash, coords.x, coords.y, coords.z, 0.0, false, false)
        SetEntityHeading(ped, 0.0)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        waypointBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(waypointBlip,1)
        SetBlipColour(waypointBlip,5)
        SetBlipScale(waypointBlip,0.4)
        SetBlipAsShortRange(waypointBlip,false)
        SetBlipRoute(waypointBlip,true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Vendas")
        EndTextCommandSetBlipName(waypointBlip)
        TriggerEvent(Config.notify,"verde","Um comprador foi identificado, va até ele",20000)
    end

    Citizen.CreateThread(function()
        while true do
            Wait(1000)

            if ped and waypointBlip then
                playerPed = PlayerPedId()
                playerCoords = GetEntityCoords(playerPed)
                distance = #(playerCoords - coords)

                if distance >= 1000 then
                    DeleteEntity(ped)
                    RemoveBlip(waypointBlip)
                    ped = nil
                    waypointBlip = nil
                    break
                end
            end
        end
    end)

    return ped, waypointBlip
end

Citizen.CreateThread(function()
    local ped = nil
    local blip = nil
    local stopLoop = false
    RegisterNetEvent('setDeliveryPoint')
    AddEventHandler('setDeliveryPoint', function(x, y, z)
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
        ped, blip = createNPC(vector3(x, y, z))

        local countDownStarted = false
        local countDownOver = false
        local countdown = 10
        stopLoop = false

        while true do
            Citizen.Wait(0)
            if stopLoop then
                break
            end
            local playerCoords = GetEntityCoords(PlayerPedId())
            if #(playerCoords - vector3(x, y, z)) < 2.0 then
                if countDownStarted and not countDownOver then
                    MyDrawText3D(x, y, z + 1.0, "AGUARDE ~r~"..tostring(countdown).."~w~ SEGUNDOS", 255, 255, 255, 215)
                elseif not countDownStarted then
                    MyDrawText3D(x, y, z + 1.0, "Pressione [E] para negociar", 255, 255, 255, 215)
                end

                if IsControlJustPressed(1, 51) and not countDownStarted then  
                    TriggerServerEvent("trocaDelivery")
                    countDownStarted = true
                    Citizen.CreateThread(function() 
                        while countdown > 0 do
                            Citizen.Wait(1000)
                            countdown = countdown - 1
                        end
                        countDownOver = true
                        SetEntityInvincible(ped, false)
                        FreezeEntityPosition(ped, false)
                        TaskWanderStandard(ped, 10.0, 10)
                        if DoesBlipExist(blip) then
                            RemoveBlip(blip)
                        end
                        stopLoop = true
                    end)
                end
            end
        end
    end)
end)


