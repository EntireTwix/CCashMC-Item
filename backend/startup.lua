rednet.open("back")

while true do
    local id, message = rednet.receive()
    local message = textutils.unserialize(message)

    if message[4] then
        local count, success, _ = commands.exec("/clear " .. message[1] .. " " .. message[5])
        if count then 
            local i = #(success[1]) - 6
            while (string.sub(success[1], i, i) ~= " ") do
                i = i - 1
            end
            local amount_removed = tonumber(string.sub(success[1], i + 1, #(success[1]) - 5))
            -- notify commoditites exchange of digital inventory change
        end
        rednet.send(id, success[1])                
    else
        -- get number of items in digital inventory from commodoties exchange
        local amount_withdrawn = 184 -- example value of 184
        while amount_withdrawn >= 64 do
            commands.exec("/give " .. message[1] .. " " .. message[5] .. " " .. 64)
            amount_withdrawn = amount_withdrawn - 64
        end
        commands.exec("/give " .. message[1] .. " " .. message[5] .. " " .. amount_withdrawn)
    end
end
    
