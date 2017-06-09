local discordia = require('discordia')
local client = discordia.Client()
local timer = require('timer')

cooldown = 5
mentioncooldown = 120
chance = 0.1
randomtime = {min=60,max=600}

lastsent = os.time()-cooldown
lastmention = os.time()-mentioncooldown
if math.floor(chance) ~= chance then
	chancemult = 10^#string.sub(math.fmod(chance,1),3,-1)
end

greg = {
	"Greg.",
	"Greg!!!",
	"Greg!",
	"Greg. Greg? Greg greg.",
	"Greg.",
	"Greg. Greg! GREG!",
	"Greg...",
	"Greg...Greg greg greeeg!",
	"Greg.",
	"Greg. Greg.",
	"Greg?",
	"Greg. Greeeeg greg greg Greg?",
	"Greg!?",
	"Greg. Greg.",
	"Gregggggga gregga greg greg.",
	"Greg!? Greg. Gregga.",
	"Greg. Gregogreg.",
	"....greg. Greg! GREG!",
	"...donkey...",
	"...greg...",
	"...Gregga greg gregga gregga.",      
	"Greg.",
	"Greg!!!",
	"Greg!",
	"Greg. Greg? Greg greg.",
	"Greg.",
	"Greg. Greg! GREG!",
	"Greg...",
	"Greg...Greg greg greeeg!",
	"Greg.",
	"Greg. Greg."
}
rainbow = {
	"....greg. Greg! GREG!",
	"Greg!!!",
	"Greg!",
	"Greg. Greg! GREG!",
	"Greg...Greg greg greeeg!"
}

local function sendMessage(sendmessage,channel)
	channel:broadcastTyping()
	timer.sleep(#sendmessage*50)
	channel:sendMessage(sendmessage)
end
client:on('ready', function()
	print("bot connected to discord with id "..client.user.id)
	gregchannel = client:getGuild('216411946017095693'):getChannel('322400629907652629')
	nextrand = os.time() + math.random(randomtime.min,randomtime.max)
end)

client:on('heartbeat', function()
	if os.time() >= nextrand then
		gregchannel:sendMessage(greg[math.random(1,#greg)])
		nextrand = os.time()+math.random(randomtime.min,randomtime.max)
	end
end)

client:on('messageCreate', function(message)
	if not message.author.bot then
		if os.time()-cooldown >= lastsent and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "shitpost") and string.find(message.content,"[Rr]+[Aa]+[Ii]+[Nn]+[Bb]+[Oo]+[Ww]+") then
			lastsent = os.time()
			sendMessage(rainbow[math.random(1,#rainbow)],message.channel)
		elseif os.time()-cooldown >= lastsent and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "shitpost") and string.find(message.content,"[Gg]+[Rr]+[Ee]+[Gg]+") then
			lastsent = os.time()
			sendMessage(greg[math.random(1,#greg)],message.channel)
		elseif (math.random(1,100*chancemult)/chancemult) <= chance and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "general" or string.sub(tostring(message.channel),19,-1) == "shitpost") then
			sendMessage(greg[math.random(1,#greg)],message.channel)
		elseif os.time()-mentioncooldown >= lastmention and message:mentionsObject(client.user) then
			lastmention = os.time()
			sendMessage(greg[math.random(1,#greg)],message.channel)
			
		end
	end
end)


client:run('token')