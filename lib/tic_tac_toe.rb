require "pry"

class TicTacToe

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize(board = nil)
        @board = board || [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i-1
        
    end

    def move(index, token = "x")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0, 8)
    end

    def turn
        input = gets.chomp  #gets collects user input
        index = input_to_index(input)
        if valid_move?(index)
            player = current_player
            move(index, player)
            display_board
        else
            turn
        end
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        if turn_count.even?                      
            "X"
        else
            "O"
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|             #iterates through each winning combination to detect if any of them have all X or all O
            if @board[combo[0]] == "X" && @board[combo[1]] == "X" && @board[combo[2]] == "X"  
                return combo
            elsif
                @board[combo[0]] == "O" && @board[combo[1]] == "O" && @board[combo[2]] == "O"
                return combo
            end
        end
    end

    def full?
        @board.all? {|token| token != " "}                   
    end

    def draw?
        if won? || @board.include?(" ")
            false
        else
            true
        end
    end

    def over?
        if draw? || won?
           true
        else
           false
        end
    end

    def winner
        if won?
            @board[won?[1]]        #axxessing the winning comination return value from the won? method.
        end
    end

    def play
        until over? == true
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end