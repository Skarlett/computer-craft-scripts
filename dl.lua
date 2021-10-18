-- like pastebin but download from anywhere
local tArgs = { ... }

if #tArgs ~= 3 then
	print("download raw http.")
	print("Usage: dl <url> <output>" )
	return
end

local input = tArgs[1]
local output = tArgs[2]

local fd = fs.open(output, "w")

fd.write(http.GET(input).readAll())
fd.close()

print("Done")
