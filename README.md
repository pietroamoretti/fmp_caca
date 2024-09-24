**__Caça e Delivery para FiveM__**

Esse script é focado em dois sistemas principais: caçada e delivery. Ele foi desenvolvido para rodar com base no framework VRP, permitindo que os jogadores participem de caçadas e missões de entrega com recompensas configuráveis.

**Como Funciona**

Caçada
Na área de caça, o jogador pode iniciar o processo de caça, coletando materiais e itens específicos. Aqui está o passo a passo de como funciona:

**Iniciando a Caçada:**

**Sistema de Caça e Delivery para FiveM**

O jogador se aproxima do NPC da caçada (configurado em Config.npcTrabalho) e pressiona [E] para iniciar a caçada.
Um veículo (configurado em Config.veiculoSpawn) é spawnado e três animais são gerados no mapa.
O jogador recebe armas e equipamentos de caça automaticamente.
Os animais aparecem com um blip no mapa, e o jogador deve ir até eles para caçar.
Coletando Itens dos Animais:

Após matar um animal, o jogador precisa usar uma faca (configurada no script) para esfolá-lo.
Pressione [E] para coletar a carne e outros itens configurados.
Itens aleatórios e fixos podem ser recebidos ao esfolar um animal.
Saindo da Caçada:

O jogador pode finalizar a caçada se afastando da área ou interagindo novamente com o NPC.
Ao sair da caçada, as armas e equipamentos são removidos do inventário.

**Delivery**
Esse sistema de delivery permite que os jogadores realizem missões de entrega e recebam recompensas em dinheiro ou itens.

Iniciando o Delivery:

O jogador pode iniciar o trabalho de delivery usando o comando /delivery. Isso gerará um ponto aleatório de entrega no mapa.
Realizando a Entrega:

O jogador se desloca até o ponto marcado e interage com o NPC pressionando [E].
Um temporizador de 10 segundos é iniciado enquanto a venda/entrega é realizada.
Recompensa:

Após concluir a entrega, o jogador receberá a recompensa configurada. Pode ser dinheiro sujo ou algum item específico.
Configuração
Todas as configurações estão no arquivo config.lua. Aqui é onde você define os itens que os jogadores vão receber, as coordenadas dos NPCs e dos pontos de entrega, o tipo de veículo que será usado na caçada, e muito mais.

**Principais Configurações:**

Config.addItemFunction: Função usada para adicionar itens no inventário.
Config.removeItemFunction: Função usada para remover itens do inventário.
Config.randomItems: Itens aleatórios que podem dropar ao matar os animais.
Config.huntingItem: Itens fixos que serão dados ao caçar os animais.
Config.veiculoSpawn: Veículo que será spawnado para a caçada.
Config.npcDelivery: NPC utilizado para a entrega.
Config.qtdDinheiro: Quantidade de dinheiro ou item recebido por cada entrega.
Instalação
Baixe e coloque os arquivos do script na sua pasta de recursos do FiveM.
Adicione o recurso ao server.cfg da sua cidade.
Verifique se o framework VRP está corretamente configurado no seu servidor.
Personalize as configurações no arquivo config.lua de acordo com sua cidade.
Inicie o servidor e aproveite o sistema de caça e delivery!
Comandos
/delivery: Inicia uma missão de entrega aleatória no mapa.

**Observações**

O script foi feito para ser flexível. Você pode ajustar os itens, NPCs, veículos e locais conforme a necessidade da sua cidade.
Tudo é configurável diretamente no config.lua.
