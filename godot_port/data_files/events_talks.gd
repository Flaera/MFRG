extends Node
# event_id: [type_of_bg, [nameect_of_character, that_char_talk_in_moment, position_id: 0 (only_bg),1 (right), 2 (left)]]
var events_talks: Dictionary = {
	"1": [
		["Zu", "Não podemos competir contra os carros da polícia.\nDa última vez que eles vieram aqui eu perdi minha mulher.\nEu não gosto deles. Todo ano, toda vez é isso.", 1], 
		["Anne", "Eu ti entendo.\nQueria poder fazer algo, mas... num sei.", 1], 
		["Zu", "Nem se preocupe com isso, não.\nTemos a Maria ela pode contra qualquier carro da polícia.\n", 2],
		["Anne", "Quem é Maria?", 1],
		["Zu", "Logo tu conhece. Tudo que cê tem que fazer agora é fazer o melhor tempo na corrida.\nBora se preparar?", 2],
		["Anne", "Bora!", 1], 
		["Zu", "Beleza!", 2]
	],
	"2": [
		 ["Iuá", "Embora o terreno seja difícil, temos algumas pistas no início da\nfloresta...", 1],
		 ["Anne", "Sério? Isso num sabia.", 1],
		 ["Iuá", "Tome cuidado com os espíritos da floresta. Eles podem trazer algum\nmal. Antigas e antigos indígenas que não\ntiveramenterros dignos vagam pela floresta\ne podem te causar algum mau.", 2],
		 ["Anne", "Nem se preocupe! Eu não tenho medo!", 1],
		 ["Iuá", "Não é medo.", 2],
		 ["Anne", "Oxi! E é o quê?", 1],
		 ["Iuá", "Respeito! Eles existem. Eles não sabem o quê causam pra ti.\nElas e eles sofrem muito por não puderem “desaparecer”", 2],
		 ["Anne", "Desculpa! Cê tem razão, mas por que eles não tiveram enterro?", 1],
		 ["Iuá", "Infelizmente, os home branco foram lá e mataram elas e eles\npor terra, gado, ouro. Essas coisas de valor pra os branco.", 2],
		 ["Anne", "Que triste. Eles vagam sem rumo e sem saber pra onde vão…", 1],
		 ["Iuá", "Tudo bem, amiga. A mãe terra esta com a gente. As coisa vão mudar.", 2],
		 ["Anne", "Tá certo.", 1]
		],
	"3": [
		["Anne", "Não tendi porque ali assumiu seu machismo.\nMachismo é algo estrutural e ruim.\nDeveria ser mortalmente evitado.", 1], 
		["Moacir", "Exatamente por isso. É algo que esta em todos os lugares,\nem mim e você. Antes de olhar para os outros, eu olhei para\nmim mesmo e...", 2], 
		["Moacir", "vi que precisava melhorar também se eu quisesse que não existisse\nestas coisas más; como racismo e xenofobia...", 2], 
		["Moacir", "Mais do que apontar o dedo na cara de alguém,\neu resolvi mudar a mim mesmo.", 2], 
		["Anne", "Mas...", 1],
		["Moacir", "Você procura evitar tratar destas questões com seus colegas?", 2], 
		["Anne", "Não. É que...", 1],
		["Moacir", "Seu mundo nunca mudará, jovem.", 2], 
		["Anne", "Tendi o que cê fez. Desculpa.", 1], 
		["Moacir", "Tudo bem. Olhe para minha idade.\nTou quase um pai de santo já, então saber destas\ncoisas é fácil.", 2], 
		["Moacir", "Além disso, ao sair do terreiro mais cedo vi você\nse impondo muito diante daquele jovem armado. Parabéns!", 2],
		["Anne", "Brigada!",1],
		["Moacir", "Depois vo ter que falar com ele, por sinal;\nmas vamos ao que interessa.\nGostei d’ocê e cê quer vencer, né?", 2], 
		["Anne", "Claro!", 1], 
		["Moacir", "Então vamos nos preparar.", 2]
	],
	"4": [
		["Carlos", "Opa, gata! Tudo bom!?", 1], 
		["Anne", "Tudo! Boa tarde!", 1], 
		["Carlos", "Boa!", 2],
		["Traficante_Armado", "Quê que essa mulé quer, hein?\nSua bitch!?", 2], 
		["Traficante_Armado", "Sou puta de ninguém porque quero falar com outra pessoa de sexo\noposto, não, e outra, eu tô falando com cê,\npor acaso?", 1], 
		["Anne", "É o quê, quenga? Cê me respeite, viu?", 2], 
		["Traficante_Armado", "Se não vai fazer o quê? Me matar?\nAqui quem me faltô respeito foi você, viu?\nIsso é magoa.\nPorque na pista já ganhei de cê antes, otário.", 1], 
		["Anne", "Os outros ao redor vaiam e é possível ouvir as falas\n“Carai! Nessa cê morreu Marquinhos!” e “Se fudeu!” ao fundo:\nUuuuuuuu! - vaia coletiva.", 0], 
		["bg_only", "Oxi! Olha...", 2], 
		["Traficante_Armado", "Ela tá certa. Vacilou feio, mano", 2], 
		["Carlos", "Olha, meu nome é Carlos. Fala o que cê quer?", 2], 
		["Anne", "É você que gerencia as corridas de nível 1.\nComo faço pra participar do RUA?", 1],
		["Carlos", "Sou eu sim. Massa! Seja bem vinda.\nFique a vontade pra se enturmar com as meninas e meninos daqui.\nSó gente boa! Me dá seu nome compreto, celular e otras coisas.\nEu vou anotar e repassar pra Terceira, no fim das contas ela que\nmanda.", 2], 
		["Carlos", "", 1],
		["Anne", "", 1]
		],
	"5": [
		 ["Senhor", "Faz muito tempo que a burguesia reclamava de uns incômodo\nadvindo das pessoas habitantes da comunidade\nribeirinha do Cortiço de Cabeça de Gato.\nEles recramava e recramava na rádia que nôis era doença e era feio.", 0],
		 ["Senhor", "Eles então começaram\ncom essas cosas de mudar, de tirar, de obter posse; quando vimos\nchego aqui uma orde de juiz maldoso\n (Tosse interrompe a fala dele por um momento).", 0],
		 ["Senhor", "Esta orde dizia pra nôis sair de nossas casa,\nque aquelas casa nossa eles precisavam pegar e pegar o terreno.\nA maioria fico lá, como eu. Porque nascemo e crescemo e… e depois\n", 0],
		 ["Senhor", "de tanto tempo (Mais uma pausa inesperada por conta da\ntosse) deveríamos sair do lugar. Não pode. Isso tá errado.", 0],
		 ["Senhor", "Perdemo tudo. Foi tudo destruído.\nQuase morri na mão daqueles capangas deles que vestem aquelas\nfarda. Perdemo… Perdemo mermo.", 0],
		 ["Senhor", "Eu consigo me lembrar, até hoje! Até hoje!\nDaqueles carros, daquelas armaduras...\nmatano meu amor.", 0],
		 ["Senhor", "Então subimo o morro e invadimo o lixão. Moramo aqui a...\nagora. Na Favela do Baixo do Reginaldo. Té quando eles vorta de novo.\nSei lá! Hoje sobrevivemo ainda da pesca, mas andamo muito\naté chegar lá, mas alguns sobrevive do lixo.", 0],
		 ["Senhor", "Então veio esse doençero,\nesse lixo todo de computador, de carro, de comida, de tudo.\nTudo isso mata.", 0],
		 ["Senhor", "Eu amava minha terra. Por que isso? De todo modo,\ntenho minhas filhas e netas... e\ntenho que continuar, né? Não posso parar antes de\nver elas florescer e fica bem.", 0]
		],
	 "6": [
		 ["Carlos", "Agora você sobe de nível.", 1],
		 ["Anne", "O que isso significa?", 2],
		 ["Carlos", "Que Maria te guiará a partir de agora. Ela é a Segunda e muito boa\npixadora, além de ser a ótima corredora. Quanto a você\nparabéns por ter melhorado e nunca deixe isso te cegar.\nNunca se esqueça de onde veio e quem são os seus.", 2],
		 ["Anne", "Ahh, que fofo. Obrigada, nunca vou me esquecer das pessoas que\nconheci aqui na comunidade. A fama é o de menos\nquando se trata de ajudar a comunidade.", 1],
		 ["Carlos", "Agora você me lembrou a Terceira. Ela é a melhor gestora e\ncorredora que já conheci,\nmas nunca deixou o RUA pelos campeonatos estaduais e\ninternacionais da grande cidade.", 2],
		 ["bg_only", "Maria chegando de carro fala:", 0],
		 ["Maria", "E ai, Carlos. Essa é a novata?", 1],
		 ["bg_only", "Ela sai do carro e a cumprimenta.", 0],
		 ["Anne", "Sim, sou eu.", 2],
		 ["Maria", "Oxi! Então bora logo fazer umas pixações e correr por aí.", 1],
		 ["Anne", "Hahaha! Bora!", 2]
		]
}
