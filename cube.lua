-- clear out a cube
-- btw, right dir doesn't work
-- and no im not fixing it

local tArgs = { ... }

if #tArgs ~= 5 then
	print( "Usage: clear <sideways> <forward> <volume> <left/right> <up/down>" )
	return
end


-- both start at 0
-- and expand towards positive integers
-- eg no negative numbers
-- these describe the demensions 
-- for the floor
local input_x = tArgs[1]; -- 
local input_y = tArgs[2]; -- 
local input_z = tArgs[3]; -- 

local turn_dir = tArgs[4][1];
local z_dir = tArgs[5][1];


function turn(d)
    if (d == 'r') then turtle.turnRight();
    else turtle.turnLeft();
    end
end

function cube(x_sz, y_sz, z_sz, dir, z_dir, on_move)
    local next_dir = dir;
    
    --[[Process column || left/right ]]
    
    for z=0, z_sz, 1 do 
        --[[Process column || left/right ]]
        for x=0, x_sz, 1 do

            --[[Process row || forward]]
            for y=0, y_sz, 1 do
                on_move();
                turtle.forward();
            end
            
            turn(next_dir)
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward();
            turn(next_dir)
            on_move()
            
            --[[ Once you complete the next row, 
            --   turn the opposite direction ]]
            
            if (next_dir == 'r') then next_dir = 'l'
            else next_dir = 'r'
            end
        end

        if (next_dir == 'r') then next_dir = 'l'
        else next_dir = 'r'
        end
        
        if turtle.detectUp() then
            turtle.digUp()
        end

        turtle.up()

        on_move()
    end
end

function action()
  if (turtle.detect()) then
    turtle.dig()
  end
end

cube(input_x-1, input_y-1, input_z-1, turn_dir, z_dir, action)
