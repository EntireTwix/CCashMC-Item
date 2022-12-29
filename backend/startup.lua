local ccash = require("ccash.api")
ccash.meta.set_server_address("url")

rednet.open("back")

while true do
    local id, message = rednet.receive()
    local message = textutils.unserialize(message)
    local price = 0

    if message[5] == "minecraft:redstone" then
        price = 3
    elseif message[5] == "minecraft:coal" then
        price = 8
    elseif message[5] == "minecraft:lapis_lazuli" then
        price = 5
    elseif message[5] == "minecraft:iron_ingot" then
        price = 20
    elseif message[5] == "minecraft:gold_ingot" then
        price = 50
    elseif message[5] == "minecraft:emerald" then
        price = 100
    elseif message[5] == "minecraft:diamond" then
        price = 250
    end

    if message[4] then
        local count, success, amount = commands.exec("/clear " .. message[1] .. " " .. message[5])
        if count then
            print(message[1] .. " +" .. price * amount)
            ccash.impact_bal("admin", "root", message[1], price * amount)
        end
        rednet.send(id, success[1])      
    else
        local amount = math.floor(ccash.get_bal(message[1]) / price)
        ccash.impact_bal("admin", "root", message[1], -(price * amount))
        print(message[1] .. " -" .. price * amount)
        commands.exec("/give " .. message[1] .. " " .. message[5] .. " " .. amount)
    end
end
