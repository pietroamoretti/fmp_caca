Config = {}


Config.addItemFunction = 'vRP.giveInventoryItem' -- Seu evento de givar item do inventario
Config.removeItemFunction = 'vRP.tryGetInventoryItem' -- Seu evento de retirar item do inventario


Config.progress = 'progress' -- Seu evento da barra de Progress
Config.notify = 'Notify' -- Seu evento da notificação

-------------------------------------------------------



Config.npcTrabalho = 'a_m_y_hippy_01' -- Npc que fica no local 


Config.blipanimal = 28 -- Blip animal


Config.localizaoAnimal = { -- Localização que o animal irá spawnar
    x = -491.53,
    y = 5520.57,
    z = 76.92,
    h = 10.34
}


Config.animalSpawn = 'ig_orleans' -- Animal que irá spawnar


Config.randomItems = {'meatS', 'meatC', 'meatB', 'meatA'} -- Itens aleatórios que podem dropar ao matar o animal (caso não queira, apenas remova)


Config.huntingItem = { -- Item que sempre dará ao matar o animal (caso queira mais itens, somente seguir o mesmo padrão)
    ['animalpelt'] = 1,
}


Config.items = { -- Itens que serão dados para a caçada
    ['wbody|WEAPON_MUSKET'] = 1,
    ['wbody|WEAPON_KNIFE'] = 1,
    ['wammo|WEAPON_MUSKET'] = 1,
}


Config.itemsToRemove = { -- Itens que serão removidos ao sair de serviço (Geralmente os mesmos usados quando é iniciado)
    ['wbody|WEAPON_MUSKET'] = 1,
    ['wbody|WEAPON_KNIFE'] = 1,
    ['wammo|WEAPON_MUSKET'] = 1,
}


Config.veiculoSpawn = 'sanchez' -- Veiculo que spawna no local


Config.localizacaoVeiculo = { -- Localização onde aparecerá o veiculo
    x = -679.47760009766,
    y = 5829.8540039063,
    z = 17.331321716309,
    h = 137.68986
}


----------------------------------------------------------------------------
------------------------------------------DELIVERY--------------------------
----------------------------------------------------------------------------
Config.npcDelivery = 'a_m_m_business_01'

Config.rotasDelivery = {
    { x = -687.06, y = 5862.83, z = 16.44 },
    { x = -696.26, y = 5839.04, z = 16.63 },
    { x = 206.15, y = -85.93, z = 69.41 },
    { x = 124.01, y = 64.86, z = 79.75 },
    { x = 105.93, y = 493.03, z = 147.15 },
    { x = -355.69, y = 516.42, z = 120.19 },
    { x = -768.78, y = 469.86, z = 100.17 },
    { x = -1045.72, y = 503.44, z = 84.17 },
    { x = -1357.05, y = 551.06, z = 130.72 },
    { x = -914.18, y = 693.68, z = 151.44 },
    { x = -575.2, y = 741.26, z = 184.06 },
    { x = -396.56, y = 877.59, z = 230.78 },
    { x = -172.67, y = 966.3, z = 237.54 },
    { x = 347.53, y = 930.02, z = 203.44 },
    { x = 148.79, y = 1667.29, z = 228.85 },
    { x = -43.75, y = 1960.0, z = 190.28 },
    
    
    -- adicione mais coordenadas conforme necessário
}

Config.itemDinheiro = 'dinheirosujo' -- Caso o dinheiro na sua cidade seja por item, adicione o nome do item aqui
Config.qtdDinheiro = '500'
Config.itemDelivery = '' -- Mesmo item que eh dado ao matar os animais

