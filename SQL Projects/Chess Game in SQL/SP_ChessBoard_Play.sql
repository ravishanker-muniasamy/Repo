
-- ChessBoard Display

-- EXEC SP_ChessBoard_Play 'DW'

DROP PROC SP_ChessBoard_Play
GO
CREATE PROC SP_ChessBoard_Play @Action CHAR(2), @Piece CHAR(10) = 'B,Kt,2', @Position CHAR(2) = 'a1'
AS
BEGIN
	
	IF @Action = 'N'		-- New Game Action
	BEGIN
		EXEC SP_ChessBoard_Initialize
		
		EXEC SP_ChessBoard_Display
		
		DELETE	FROM NextMoves

	END 
	
	IF @Action = 'M'		-- Piece Movement Action
	BEGIN
		EXEC SP_ChessBoard_Move_Piece @Piece, @Position, 0
	END

	IF @Action = 'S'		-- Piece Movement Simulation Action. It generates & shows all possible movements including cutting options
	BEGIN
		EXEC SP_ChessBoard_Move_Piece @Piece, @Position, 1
	END

	IF @Action = 'DW'		-- Just to display the Chess board from White piece player perspective
	BEGIN
		EXEC SP_ChessBoard_Display 'W'
	END
	IF @Action = 'DB'		-- Just to display the Chess board from Black piece player perspective
	BEGIN
		EXEC SP_ChessBoard_Display 'B'
	END

	IF @Action = 'H'		-- To list the game history with the piece movement sequence records.
	BEGIN
		SELECT	Sequence_No, Removed_PieceShortName, Moved_PieceShortName, From_Vertical, From_Horizontal, To_Vertical, To_Horizontal
		FROM	PieceMovement
		ORDER BY Sequence_No
	END
	
	IF @Action = 'R'		-- Rewind/Rollback the last move
	BEGIN
		EXEC SP_Rewind_Last_Move
	END
END