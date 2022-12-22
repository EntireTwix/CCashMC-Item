-- for transferring grand economy balances to CCash

local ccash = require("ccash.api")
ccash.meta.set_server_address("http://54.38.56.148/")

print("enter player to transfer")
local player_name = read()
local count, success, result = commands.exec("/wallet balance " .. player_name)

local i = #(success[1]) - 3
while (string.sub(success[1], i, i) ~= " ") do
    i = i - 1
end
local balance = tonumber(string.sub(success[1], i + 1, #(success[1]) - 2))
if ccash.admin.impact_bal("admin", "root", player_name, balance * 100) then 
    commands.exec("/wallet set " .. player_name .. " 0")
    print("transfer successful!\n transferred " .. balance .. "gp -> " .. balance * 100 .. "CSH")
else
    print("transfer failed")
end
