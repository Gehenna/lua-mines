gui = require('Gspot')

font = love.graphics.newFont(192)
local DIV = love._version_major >= 11 and 1/255 or 1

function love.load()
   MINE = "X"    -- mine define
   XSIZE = 10
   YSIZE = 10

   playingBoard = initBoard(XSIZE, YSIZE, 10)

   -- love.graphics.setFont(font)
   -- love.graphics.setColor(255 * DIV, 192 * DIV, 0 * DIV, 128 * DIV)
   --
   -- playingBoard = initBoard(XSIZE, YSIZE, 10)
   --
   -- local button = gui:button('A Button', {x = 200, y = 200, w = 128, h = 128})
   --     button.click = function(this, x, y) -- set element:click() to make it respond to gui's click event
   --         gui:feedback(tostring(this))
   --     end
end

function love.update(dt)
  gui:update(dt)
end

function love.mousepressed(x, y, button)
	gui:mousepress(x, y, button) -- pretty sure you want to register mouse events
end

function love.mousereleased(x, y, button)
	gui:mouserelease(x, y, button)
end

function love.wheelmoved(x, y)
	gui:mousewheel(x, y)
end

function love.draw()
    gui:draw()

    -- Print values of playing board:
    for i=1,XSIZE do
       for j=1,YSIZE do
           love.graphics.print(tostring(playingBoard[i][j]), i*25, j*25)
       end
   end
end

function initBoard(xsize, ysize, numberOfMines)
    board = {}

    -- init board with zeros:
    for i=1,xsize do
        board[i] = {}     -- create a new row
        for j=1,ysize do
            board[i][j] = 0
        end
    end

    -- place mines:
    bombsCounter = 0
    while (bombsCounter < numberOfMines) do
        -- create random x & y values:
        randomX = math.random(1, xsize)
        randomY = math.random(1, ysize)

        -- check if field is already mined
        if(board[randomX][randomY] ~= MINE) then
            -- no mine yet -> place mine:
            board[randomX][randomY] = MINE
            bombsCounter = bombsCounter + 1
        end
    end

    function sum(...)
        local s = 0
        for _,v in ipairs{...} do
            s = s + v
        end
        return s
    end

    -- update the other values:
    for i=1,xsize do
        for j=1,ysize do
            if(board[i][j] ~= MINE) then
                -- Check if left upper square contains mine:
                if(i-1 >= 1) and (j-1 >= 1) then
                    if(board[i-1][j-1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if upper square contains mine:
                if (j-1 >= 1) then
                    if(board[i][j-1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if right upper square contains mine:
                if (i+1 <= xsize) and (j-1 >= 1) then
                    if(board[i+1][j-1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if left square contains mine:
                if (i-1 >= 1) then
                    if(board[i-1][j] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if right square contains mine:
                if (i+1 <= xsize) then
                    if(board[i+1][j] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if left lower square contains mine:
                if(i-1 >= 1) and (j+1 <= ysize) then
                    if(board[i-1][j+1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if lower square contains mine:
                if (j+1 <= ysize) then
                    if(board[i][j+1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if right lower square contains mine:
                if (i+1 <= xsize) and (j+1 <= ysize) then
                    if(board[i+1][j+1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end
            end
        end
    end

    return board
end
