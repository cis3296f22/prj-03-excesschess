# HorizontalMove contains the logic for a move within a rank.


const linear = preload("res://engine/move/linear_move.gd")


# Properties
var name
var can_capture
var must_capture
var max_length


func _init(name_ = "left-and-right", can_capture_ = true, must_capture_ = false, max_length_= -1):
	name = name_
	can_capture = can_capture_
	must_capture = must_capture_
	max_length = max_length_


# Validates a line of spaces and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, _piece):
	var start
	var end
	# Check spaces to the right.
	start = pos + 1
	end = game.width * (pos / game.width + 1)
	if start < end:
		linear.add_pos_linear(positions, start, end, 1,
				game.max_pos, max_length, can_capture, must_capture, game.pieces)
	# Check spaces to the left.
	start = pos - 1
	end = game.width * (pos / game.width) - 1
	if start > end:
		linear.add_pos_linear(positions, start, end, -1,
				game.max_pos, max_length, can_capture, must_capture, game.pieces)
