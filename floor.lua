
local tArgs = { ... }
if #tArgs ~= 3 then
	print( "Usage: floor <x-width> <y-width> <left/right>" )
	return
end


-- both start at 0
-- and expand towards positive integers
-- eg no negative numbers
-- these describe the demensions 
-- for the floor
local input_x = tArgs[1]; -- -->
local input_y = tArgs[2]; -- ^
local turn_dir = tArgs[3][1];

if (not turn_dir == 'r' and not turn_dir == 'l') then
    print("argument 3 must be left/right");
    return
end

local slot_idx = turtle.getSelectedSlot();
local block_name = turtle.getItemDetail(slot_idx).name;

function more_blocks()
    for i=1, 16, 1 do
        if (turtle.getItemCount(i) > 0 and turtle.getItemDetail(i).name == block_name) then
            turtle.select(i);
            slot_idx = i;
            return 1;
        end
    end
    return 0;
end


function next_row()
    if (turn_dir == 'r') then
        turtle.turnRight();
    else
        turtle.turnLeft();
    end

    turtle.forward();
    turtle.placeDown();
    
    if (turn_dir == 'r') then
        turtle.turnRight();
        turn_dir = 'l';
    else
        turtle.turnLeft();
        turn_dir = 'r';
    end
    turtle.forward();
end


function main()
    for x=0, input_x, 1 do
        for y=0, input_y, 1 do
            if (0 >= turtle.getItemCount(slot_idx)) then
                if (more_blocks() == 0) then
                    return 0;
                end
            end

            if (not turtle.detectDown()) then
                turtle.placeDown();
            end
            
            if (turtle.detect()) then
                return 0;
            end

            turtle.forward();
        end
        next_row();
    end
end

print("starting...")
main()