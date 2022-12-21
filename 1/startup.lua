local ccash = require("ccash.api")
ccash.meta.set_server_address("http://54.38.56.148/")
local backend_id = 2

rednet.open("back")

-- os.pullEvent = os.pullEventRaw

while true do
    term.clear()
    term.setCursorPos(1,1)

    print("enter username")
    local name = read()
    print("enter password")
    local pass = read("*")
    print()

    if not ccash.verify_password(name, pass) then
        print("invalid credentials")    
        os.sleep(2)
    else
        local answer, deposit
        repeat
            print("deposit or withdraw?")
            answer = read()
            deposit = (answer == "deposit")
        until deposit or (answer == "withdraw") or not print("invalid input\n")
        
        print("\nenter item ID")
        local item_id = read()
        if string.find(item_id, " ") then
            print("item_id must not contain spaces")
            os.sleep(2)
        else
            rednet.send(backend_id, textutils.serialize({name, pass, answer, deposit, item_id}, {compact = true, allow_repetitions = true}))
            if (deposit) then
                local _, message = rednet.receive()
                print("\n" .. message)
                os.sleep(2)
            end
        end
    end
end
