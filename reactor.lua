--[ This Program sends multiple redstone signals
--[ via rednet wires, the "slaves" are the colors
--[ configured on the wire
--[---------------------------
--[ though undocumented on the wiki
--[ It is commonly believed "rs.setBundledOutput"
--[ does not work with RedProject
--[ Though, undocumented - it does work with
--[ "RedNet"
--[---------------------------
--[ To use multiple redstone signals
--[ use the following code
--[---------------------------
--[ rs.setBundledOutput(side, colors.red + colors.white)
--[---------------------------
--[ Developer details & discoveries
--[ RedNet color is a unsigned 16 bit integer
--[ thus 65535 - sets all outputs as true.

slaves = {
 colors.white,
 colors.red,
 colors.yellow,
 colors.blue
};

local tArgs = { ... };
local signal = 0; 
local id_selector = 0;

if #tArgs == 0
then
  print("failed, select reactor")
  print("reactor <id, .. | all | off>")
  print("example: reactor 1 3")
  quit()

elseif tArgs[1] == "all"
then
  --[MAX u16]
  signal = 65535;  

elseif tArgs[1] == "off"
then
  print("turning off");

else
  for i = 1, #tArgs do
    id_selector = tonumber(tArgs[i]);
  
    if id_selector > #slaves or 0 > id_selector
    then
      print("ID unknown: " + tostring(id_selector));
    
    else 
      signal = signal + slaves[id_selector];
    end
  end
end

--[print("1: ".format(slave[1] & signal));
--[print("2: ", slave[2] & signal);
--[print("3: ", slave[3] & signal);
--[print("4: ", slave[4] & signal);

rs.setBundledOutput("right", signal);
print("done")
