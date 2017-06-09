local discordia = require('discordia')
local client = discordia.Client()

cooldown = 5
mentioncooldown = 60
chance = 1

lastsent = os.time()-cooldown
lastmention = os.time()-mentioncooldown


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
	"Greg. Gregogreg."
}
rainbow = {
	"....greg. Greg! GREG!",
	"Greg!!!",
	"Greg!",
	"Greg. Greg! GREG!",
	"Greg...Greg greg greeeg!"
}

client:on('ready', function()
	gregchannel = client:getGuild('216411946017095693'):getChannel('322400629907652629')
	nextrand = os.time() + math.random(60,600)
end)

client:on('heartbeat', function()
	if os.time() >= nextrand then
		gregchannel:sendMessage(greg[math.random(1,#greg)])
		nextrand = os.time()+math.random(60,600)
	end
end)

client:on('messageCreate', function(message)
	if not message.author.bot then
		if os.time()-cooldown >= lastsent and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "shitpost") and string.find(message.content,"[Rr]+[Aa]+[Ii]+[Nn]+[Bb]+[Oo]+[Ww]+") ~= nil then
			message.channel:sendMessage(rainbow[math.random(1,#rainbow)])
			lastsent = os.time()
		elseif os.time()-cooldown >= lastsent and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "shitpost") and string.find(message.content,"[Gg]+[Rr]+[Ee]+[Gg]+") ~= nil then
			message.channel:sendMessage(greg[math.random(1,#greg)])
			lastsent = os.time()
		elseif math.random(1,100) <= chance and (string.sub(tostring(message.channel),19,-1) == "greg" or string.sub(tostring(message.channel),19,-1) == "general" or string.sub(tostring(message.channel),19,-1) == "shitpost") then
			message.channel:sendMessage(greg[math.random(1,#greg)])
		elseif os.time()-mentioncooldown >= lastmention and string.find(message.content,"<@!"..client.user.id..">") ~= nil then
			message.channel:sendMessage(greg[math.random(1,#greg)])
			lastmention = os.time()
		end
	end
end)


client:run('token')