<<<<<<< HEAD
gui = require('Gspot')

font = love.graphics.newFont(192)
local DIV = love._version_major >= 11 and 1/255 or 1

function love.load()
    MINE = 9    -- mine define
    XSIZE = 10
    YSIZE = 10

    love.graphics.setFont(font)
    love.graphics.setColor(255 * DIV, 192 * DIV, 0 * DIV, 128 * DIV)

    playingBoard = initBoard(XSIZE, YSIZE, 10)

    local button = gui:button('A Button', {x = 200, y = 200, w = 128, h = 128})
        button.click = function(this, x, y) -- set element:click() to make it respond to gui's click event
		    gui:feedback(tostring(this))
	    end
=======
>>>>>>> c4cf47bfec67048642a3809ad6e7175c3210a70b
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
<<<<<<< HEAD
    gui:draw()

    -- Print values of playing board:
    -- for i=1,XSIZE do
    --    for j=1,YSIZE do
    --        love.graphics.print(tostring(playingBoard[i][j]), i*25, j*25)
    --    end
    --    print()
    -- end
=======
>>>>>>> c4cf47bfec67048642a3809ad6e7175c3210a70b
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
    numberOfMines = 10
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

    -- update the other values:
    for i=1,xsize do
        for j=1,ysize do
            if(board[i][j] ~= MINE) then
                -- Check if left upper square contains mine:
                    if(board[i-1][j-1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if upper square contains mine:
                    if(board[i][j-1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if right upper square contains mine:
                    if(board[i+1][j-1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if left square contains mine:
                    if(board[i-1][j] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if right square contains mine:
                    if(board[i+1][j] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if left lower square contains mine:
                    if(board[i-1][j+1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if lower square contains mine:
                    if(board[i][j+1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end

                -- Check if right lower square contains mine:
                    if(board[i+1][j+1] == MINE) then
                        board[i][j] = board[i][j] + 1
                    end
                end
            end
        end
    end

    return board
end
