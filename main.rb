class Board
    def initialize(default_char=" ")
        @board = Array.new(9, default_char)
        @default_char = default_char
        @result = ""
        @prng = Random.new
    end

    def getComputerMove(counter='X',difficulty=0)
        if difficulty == 0
            moveSuccess = false
            until moveSuccess do
                cand = @prng.rand(9)
                if @board[cand] == @default_char
                    moveSuccess = true
                    @board[cand] = counter 
                end
            end
        end
        cand + 1
    end

    def displayBoard
        for rowNum in 0..2
            row = Array.new(3)
            for colNum in 0..2
                if @board[rowNum * 3 + colNum] == @default_char
                    row[colNum] = ((rowNum * 3) + colNum + 1).to_s
                else 
                    row[colNum] = @board[rowNum * 3 + colNum]
                end
            end
            puts " #{row[0]} | #{row[1]} | #{row[2]}"
            if rowNum != 2
                puts " ----------"
            end
        end
    end

    def getPlayerMove(counter)
        needInput = true
        maxTries = 5
        currentTries = 0
        while currentTries < maxTries and needInput do
            if currentTries == 0
                self.displayBoard()
                puts "Observe the board and make your move."
            else 
                self.displayBoard()
                puts "Please choose a free space. Your move."
            end
            playerMove = gets.chomp.to_i
            currentTries += 1
            if @board[playerMove-1] == @default_char
                @board[playerMove-1] = counter
                needInput = false
                puts "Thank you"
            elsif currentTries == maxTries
                puts "If you won't co-operate, the computer wins by default. 0-1."
                return "null"
            end
        end
        playerMove
    end

    def gameEndCheck
        # rows [0,1,2], [3,4,5], [6,7,8]
        # cols [0,3,6], [1,4,7], [2,5,8]
        # diag [0,4,8], [2,4,6]

        if @board[0] != @default_char
            if @board[0] == @board[1] and @board[0] == @board[2]
                return @board[0]
            elsif @board[0] == @board[3] and @board[0] == @board[6]
                return @board[0]
            end 
        end 
        if @board[4] != @default_char
            if @board[1] == @board[4] and @board[1] == @board[7]
                return @board[4]
            elsif @board[3] == @board[4] and @board[3] == @board[5]
                return @board[4]
            elsif @board[0] == @board[4] and @board[0] == @board[8]
                return @board[4]
            elsif @board[2] == @board[4] and @board[2] == @board[6]
                return @board[4]
            end
        end 

        if @board[8] != @default_char
            if @board[6] == @board[7] and @board[6] == @board[8]
                return @board[8] 
            elsif @board[2] == @board[5] and @board[2] == @board[8]
                return @board[8]
            end
        end  
        
        draw = true 
        for i in @board do
            if i == @default_char
                draw = false 
            end 
        end 

        if draw 
            return "draw"
        else
            return "incomplete"
        end
    end
end

class NoughtsCrosses
    def initialize
        puts "Welcome to noughts and crosses!"
        @name = getPlayerName()
        @board = Board.new
    end

    def getPlayerName
        puts "What is your name?"
        name = gets.chomp
        puts "Hello, #{name}. Prepare to be crushed by the computer."
        name
    end

    def getPlayerSide
        needInput = true
        maxTries = 5
        currentTries = 0
        while currentTries < maxTries and needInput do
            if currentTries == 0
                puts "Would you like to be noughts (O) or crosses (X)?"
            else 
                puts "Please answer correctly. Noughts (O) or crosses (X)?"
            end
            playerSide = gets.chomp
            currentTries += 1
            if playerSide.upcase == "X" or playerSide.upcase == "O"
                playerSide = playerSide.upcase 
                needInput = false
                puts "Thank you"
            elsif currentTries == maxTries
                puts "If you won't co-operate, the computer wins by default. 0-1."
                return "null"
            end
        end
        return playerSide
    end

    

    def playGame
        playerCounter = self.getPlayerSide()
        if playerCounter == "null"
            return 
        end
        if playerCounter == "O"
            compCounter = "X"
            playerNext = true
        elsif playerCounter == "X"
            compCounter = "O"
            playerNext = false 
        end 

        game_continue = true 
        while game_continue do 
            if playerNext 
                playerMove = @board.getPlayerMove(playerCounter)
                if playerMove == "null"
                    return 
                end 
                puts "Player chooses #{playerMove} position."
                playerNext = false 
            else 
                compMove = @board.getComputerMove(compCounter)

                puts "Computer chooses #{compMove} position."
                playerNext = true
            end
            gameEnd = @board.gameEndCheck()
            if gameEnd == "X"
                game_continue = false 
                puts "Crosses win!"
                @board.displayBoard()
            elsif gameEnd == "O"
                game_continue = false 
                puts "Noughts win!"
                @board.displayBoard()
            elsif gameEnd == "draw"
                game_continue = false 
                puts "Draw!"
                @board.displayBoard()
            end
        end
    end
end


game = NoughtsCrosses.new
game.playGame()