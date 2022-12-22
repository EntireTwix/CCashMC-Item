local ccash = require("ccash.api")
ccash.meta.set_server_address("http://54.38.56.148/")

function format_int(number)

    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  
    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")
  
    -- reverse the int-string back remove an optional comma and put the 
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

print("enter player to transfer")
local player_name = read()
local _, success, _ = commands.exec("/wallet balance " .. player_name)

success[1] = string.gsub(success[1], "%,", "")
local i = #(success[1]) - 3
while (string.sub(success[1], i, i) ~= " ") do
    i = i - 1
end

local balance = tonumber(string.sub(success[1], i + 1, #(success[1]) - 2))

if ccash.admin.impact_bal("admin", "F!4u21D@GK&X", player_name, balance * 100) then 
    commands.exec("/wallet set " .. player_name .. " 0")
    print("transfer successful!\n transferred " .. format_int(balance) .. " gp -> " .. format_int(balance * 100) .. " CSH")
else
    print("transfer failed")
end
