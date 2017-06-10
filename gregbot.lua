local discordia = require('discordia')
local client = discordia.Client()
local timer = require('timer')

cooldown = 5
mentioncooldown = 120
chance = 0.1
randomtime = {min=60,max=600}
randommessage = false

lastsent = os.time()-cooldown
lastmention = os.time()-mentioncooldown
if math.floor(chance) ~= chance then
	chancemult = 10^#string.sub(math.fmod(chance,1),3,-1)
end

greg = {
	{text="Greg.",weight=7},
	{text="Greg!!!",weight=2},
	{text="Greg. Greg? Greg greg.",weight=2},
	{text="Greg. Greg! GREG!",weight=2},
	{text="Greg...",weight=2},
	{text="Greg...Greg greg greeeg!",weight=2},
	{text="Greg. Greg.",weight=3},
	{text="Greg?",weight=1},
	{text="Greg. Greeeeg greg greg Greg?",weight=1},
	{text="Greg!?",weight=1},
	{text="Gregggggga gregga greg greg.",weight=1},
	{text="Greg!? Greg. Gregga.",weight=1},
	{text="Greg. Gregogreg.",weight=1},
	{text="....greg. Greg! GREG!",weight=1},
	{text="...donkey...",weight=1},
	{text="...greg...",weight=1},
	{text="...Gregga greg gregga gregga.",weight=1},
	{text="Greg!",weight=1}
}
rainbow = {
	{text="....greg. Greg! GREG!",weight=1},
	{text="Greg!!!",weight=1},
	{text="Greg!",weight=1},
	{text="Greg. Greg! GREG!",weight=1},
	{text="Greg...Greg greg greeeg!",weight=1}
}

greg.num = 0
for i=1,#greg-1 do
	greg.num = greg.num + greg[i].weight
	greg[i].max = greg.num
end
rainbow.num = 0
for i=1,#rainbow-1 do
	rainbow.num = rainbow.num + rainbow[i].weight
	rainbow[i].max = rainbow.num
end

local function randomtext(tab)
	rand = math.random(1,tab.num)
	for i=1,#tab-1 do
		if rand <= tab[i].max then
			return tab[i].text
		end
	end
end
local function sendMessage(sendmessage,channel)
	channel:broadcastTyping()
	timer.sleep(#sendmessage*50)
	channel:sendMessage(sendmessage)
end
client:on('ready', function()
	print("bot connected to discord with id "..client.user.id)
	if randommessage then
		gregchannel = client:getGuild('216411946017095693'):getChannel('322400629907652629')
		nextrand = os.time() + math.random(randomtime.min,randomtime.max)
	end
end)

client:on('heartbeat', function()
	if randommessage and os.time() >= nextrand then
		gregchannel:sendMessage(randomtext(greg))
		nextrand = os.time()+math.random(randomtime.min,randomtime.max)
	end
end)

client:on('messageCreate', function(message)
	if not message.author.bot then
		if os.time()-cooldown >= lastsent and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "shitpost") and string.find(message.content,"[Rr]+[Aa]+[Ii]+[Nn]+[Bb]+[Oo]+[Ww]+") then
			lastsent = os.time()
			sendMessage(randomtext(rainbow),message.channel)
		elseif os.time()-cooldown >= lastsent and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "shitpost") and string.find(message.content,"[Gg]+[Rr]+[Ee]+[Gg]+") then
			lastsent = os.time()
			sendMessage(randomtext(greg),message.channel)
		elseif (math.random(1,100*chancemult)/chancemult) <= chance and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "general" or string.sub(tostring(message.channel),19,-1) == "shitpost") then
			sendMessage(randomtext(greg),message.channel)
		elseif os.time()-mentioncooldown >= lastmention and message:mentionsObject(client.user) then
			lastmention = os.time()
			sendMessage(randomtext(greg),message.channel)
			
		end
	end
end)


client:run('token')