function love.load()
   MINE = "x"    -- mine define
   XSIZE = 10
   YSIZE = 10

   playingBoard = initBoard(XSIZE, YSIZE, 10)
end

function love.update(dt)

end

function love.mousepressed(mx, my, button, isTouch)
    -- if button == 1 and
    -- mx >= 400 and mx < 400 + tile:getWidth() and
    -- my >= 400 and my < 400 + tile:getHeight() then
    --     tile = love.graphics.newImage("images/example.png")
    -- else
    --     tile = love.graphics.newImage("images/tile.png")
    -- end
end

function love.draw()
    -- Print values of playing board:
    for i=1,XSIZE do
       for j=1,YSIZE do
           love.graphics.print(tostring(playingBoard[i][j]), i*25, j*25)
       end
       print()
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
