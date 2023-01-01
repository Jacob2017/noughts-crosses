# noughts-crosses
Classes:
* Game
* Board

## Game
Instance variables:
* board (class Board)
* player name (class String)
* result (class String)
* difficulty (class Integer)

Methods:
* get_player_name
* create_board
* player_move_first?
* get_player_move

## Board
Instance variables:
* board state (array class String)
* free spaces (array class Integer)
* game complete? (class Boolean)
* result (class String)

Methods:
* make_move
* evaluate_board/game_complete?