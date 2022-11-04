extends Piece
# Bishop represents the bishop chess piece.


func _init(team_new, id_new).(team_new, id_new):
    type = Type.BISHOP


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
    var moves = []
    var start_file = orig_pos % board_width

    # Get movements.
    _add_moves(moves, orig_pos + board_width + 1, orig_pos + (board_width - start_file - 1) * (board_width + 1),
            board_width + 1, max_pos, board_map)
    _add_moves(moves, orig_pos + board_width - 1, orig_pos + (start_file) * (board_width - 1),
            board_width - 1, max_pos, board_map)
    _add_moves(moves, orig_pos - board_width - 1, orig_pos + (start_file) * (-1 - board_width),
            -1 - board_width, max_pos, board_map)
    _add_moves(moves, orig_pos - board_width + 1, orig_pos + (board_width - start_file - 1) * (1 - board_width),
            1 - board_width, max_pos, board_map)

    return moves


# Checks a range of potential spaces to move into, and adds validated spaces to
# the list of moves.
# Arguments:
# moves: The list of moves.
# start: The initial position to check.
# end: The final position, which is not checked.
# step: The distance between positions checked.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
func _add_moves(moves, start, end, step, max_pos, board_map):
    for pos in range(start, end, step):
        if not board_map.has(pos):
            if pos >= 0 and pos <= max_pos:
                moves.append(pos)
        else:
            # If the piece can be captured, then add move.
            if board_map[pos].get("team") != team:
                moves.append(pos)
            # Exit loop because pieces block further movement.
            break