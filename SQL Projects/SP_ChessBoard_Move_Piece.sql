USE ChessDB
GO
DROP PROC SP_ChessBoard_Move_Piece
GO
CREATE PROC SP_ChessBoard_Move_Piece  @Piece CHAR(10) = 'B,Kt,2', @Position CHAR(2) = 'a1', @Simulate BIT = 0
AS
BEGIN

	DECLARE	@NewVertical		CHAR(1),
			@NewHorizontal		CHAR(1),
			@CurrentVertical	CHAR(1),
			@CurrentVerticalINT	TINYINT,
			@CurrentHorizontal	TINYINT,
			@PieceInitial		CHAR(2),
			@PieceID			TINYINT,
			@PieceSide			CHAR(1),
			@ExistingPieceID	TINYINT,
			@ExistingPieceSide	CHAR(1)

			--	EXEC	
	SELECT	@NewVertical	= LEFT(@Position,1)			-- Coorinates of the new positon where the piece is to be moved
	SELECT	@NewHorizontal	= RIGHT(@Position,1)

	SELECT	@PieceID			= CB.PieceID,			-- Current details of the piece which is to be moved
			@PieceSide			= P.Pieceside,			-- W/B Side
			@PieceInitial		= P.PieceInitial,		-- Initials of the Piece K, Q, R, Kt, B, P
			@CurrentVertical	= CB.Vertical,			-- Coordinates
			@CurrentHorizontal	= CB.Horizontal,
			@CurrentVerticalINT	= CB.Vertical_INT
	FROM	Chessboard CB
	JOIN	Piece P
	ON		CB.PieceID			= P.PieceID
	WHERE	P.PieceShortName	= @Piece				
	
	IF		ISNULL(@PieceID,0)	= 0						-- If it is not a valid piece, then return.
	BEGIN
		SELECT 'Invalid Piece Selected'
		RETURN
	END

	SELECT	@ExistingPieceID	= CB.PieceID,			-- In case if another opponent piece exists in the square position where the piece is to be moved, then gather its information.
			@ExistingPieceSide	= P.Pieceside
	FROM	Chessboard CB
	JOIN	Piece P
	ON		CB.PieceID			= P.PieceID
	WHERE	Vertical			= @NewVertical			-- Coordinates of the new position
	AND		Horizontal			= @NewHorizontal		

	IF		(@CurrentVertical = @NewVertical AND @CurrentHorizontal = @NewHorizontal AND @Simulate = 0) -- In case if by mistake same position is given as new move.
		BEGIN
			SELECT 'NO MOVEMENT'
			RETURN
		END
		
	DELETE FROM NextMoves	-- Initialize the next moves table

	IF @PieceInitial = 'K' -- If King piece is being moved
	BEGIN
		INSERT INTO NextMoves
		SELECT	Vertical, Vertical_INT, Horizontal, P.PieceSide, CB.PieceID		
		FROM	ChessBoard	CB
		JOIN	Piece P
		ON		CB.PieceID			= P.PieceID
		WHERE	(Vertical_INT		BETWEEN @CurrentVerticalINT - 1 AND @CurrentVerticalINT + 1 -- Consider all 9 position 3 by 3 squares.
		AND		Horizontal			BETWEEN @CurrentHorizontal - 1 AND @CurrentHorizontal + 1)	
		AND		(CB.PieceID	= 0		OR ISNULL(P.PieceSide,@PieceSide)	!= @PieceSide)			-- Consider ONLY empty and Opponent Pieces
	END

	IF @PieceInitial = 'Q' -- If Queen piece is being moved
	BEGIN
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 1, 1	-- Generate all possible moves in NE direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 1, -1	-- Generate all possible moves in NW direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, -1, 1 -- Generate all possible moves in SE direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, -1, -1 -- Generate all possible moves in SW direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 0, -1 -- Generate all possible moves in W direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 0, 1 -- Generate all possible moves in E direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 1, 0 -- Generate all possible moves in N direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, -1, 0 -- Generate all possible moves in S direction
	END


	IF @PieceInitial = 'B' -- If Bishop piece is being Moved
	BEGIN
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 1, 1	-- Generate all possible moves in NE direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 1, -1	-- Generate all possible moves in NW direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, -1, 1 -- Generate all possible moves in SE direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, -1, -1 -- Generate all possible moves in SW direction
	END

	IF	@PieceInitial = 'Kt'		-- If Knight piece is being moved
	BEGIN
		INSERT INTO NextMoves
		SELECT	Vertical, Vertical_INT, Horizontal, 'W',CB.PieceID
		FROM	Chessboard CB
		JOIN	Piece P
		ON		CB.PieceID = P.PieceID
		WHERE	(CB.PieceID = 0 OR P.PieceSide != ISNULL(@PieceSide,P.PieceSide))	-- Only Empty and Opponent Squares will be considered
		AND		CONCAT(Vertical_INT, Horizontal) IN 
				(
				CONCAT(@CurrentVerticalINT + 1 , @CurrentHorizontal + 2),	-- Lists all possible L Square Positions
				CONCAT(@CurrentVerticalINT - 1 , @CurrentHorizontal + 2),
				CONCAT(@CurrentVerticalINT + 1 , @CurrentHorizontal - 2),
				CONCAT(@CurrentVerticalINT - 1 , @CurrentHorizontal - 2),
				CONCAT(@CurrentVerticalINT + 2 , @CurrentHorizontal + 1),
				CONCAT(@CurrentVerticalINT - 2 , @CurrentHorizontal + 1),
				CONCAT(@CurrentVerticalINT + 2 , @CurrentHorizontal - 1),
				CONCAT(@CurrentVerticalINT - 2 , @CurrentHorizontal - 1)
				)
	END

	IF @PieceInitial = 'R' -- If Rook piece is being moved
	BEGIN
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 0, -1 -- Generate all possible moves in W direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 0, 1 -- Generate all possible moves in E direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, 1, 0 -- Generate all possible moves in N direction
		EXEC SP_Find_All_Valid_Moves @CurrentVerticalINT, @CurrentHorizontal, @PieceSide, -1, 0 -- Generate all possible moves in S direction	
	END

	IF @PieceInitial = 'P'		-- If Pawn piece is being moved
	BEGIN
		IF @PieceSide = 'B'		-- If it is a Black Pawn movement
		BEGIN			
			INSERT INTO NextMoves
			SELECT	Vertical, Vertical_INT, Horizontal, 0, 0
			FROM	ChessBoard	CB
			WHERE	Vertical_INT		= @CurrentVerticalINT 
			AND		(
							Horizontal				= @CurrentHorizontal - 1								-- One Square advacement
					OR		(Horizontal				= @CurrentHorizontal - 2 AND @CurrentHorizontal	= 7 )	-- First step... Two Square advancement
					)
			AND		CB.PieceID			= 0		-- Only Empty Squares
			
			INSERT INTO NextMoves
			SELECT	Vertical, Vertical_INT, Horizontal, P.PieceSide, CB.PieceID		
			FROM	ChessBoard	CB
			JOIN	Piece P
			ON		CB.PieceID		= P.PieceID
			WHERE	(Vertical_INT	IN (@CurrentVerticalINT - 1, @CurrentVerticalINT + 1)
			AND		Horizontal		= @CurrentHorizontal - 1)
			AND		@PieceSide		!= ISNULL(P.PieceSide,@PieceSide)		-- Diagnal Cut moves in case if opponent piece exists
		END
		ELSE
		BEGIN
			-- If it is a White piece movement	
			INSERT INTO NextMoves
			SELECT	Vertical, Vertical_INT, Horizontal, 0, 0
			FROM	ChessBoard	CB
			WHERE	Vertical_INT		= @CurrentVerticalINT 
			AND		(
							Horizontal				= @CurrentHorizontal + 1									-- One Square advacement
					OR		(Horizontal				= @CurrentHorizontal + 2 AND @CurrentHorizontal	= 2 )		-- First step... Two Square advancement
					)
			AND		CB.PieceID			= 0		-- Only Empty Squares
			
			INSERT INTO NextMoves
			SELECT	Vertical, Vertical_INT, Horizontal, P.PieceSide, CB.PieceID		
			FROM	ChessBoard	CB
			JOIN	Piece P
			ON		CB.PieceID		= P.PieceID
			WHERE	(Vertical_INT	IN (@CurrentVerticalINT - 1, @CurrentVerticalINT + 1)
			AND		Horizontal		= @CurrentHorizontal + 1)
			AND		@PieceSide		= ISNULL(P.PieceSide,@PieceSide)		-- Diagnal Cut moves in case if opponent piece exists
		END
	END
	
	IF @Simulate = 0
	BEGIN
		IF NOT EXISTS 
		(
			SELECT	'x'
			FROM	NextMoves					-- If the next move's coordinate does not exists in the possible next moves, then the move is invalid
			WHERE	Vertical	= @NewVertical
			AND		Horizontal	= @NewHorizontal
		)
		BEGIN
			SELECT 'Invalid Move'
			RETURN 
		END

		-- Inserting piece movements ito the piece_movement table.

		DECLARE @Move_Sequence_No SMALLINT
	
		SELECT	@Move_Sequence_No = ISNULL(Max(sequence_no),0) + 1		-- Finding next sequence number
		FROM	PieceMovement

		INSERT INTO PieceMovement
		(sequence_no, Removed_PieceID, Removed_PieceShortName, Moved_PieceID, Moved_PieceShortName, To_Vertical, To_Horizontal, From_Vertical, From_Horizontal)
		SELECT	@Move_Sequence_No, CB.PieceID, P.PieceShortName, @PieceID, @Piece, @NewVertical, @NewHorizontal,@CurrentVertical, @CurrentHorizontal 
		FROM	Chessboard CB
		JOIN	Piece P
		ON		CB.PieceID		= P.PieceID
		WHERE	CB.vertical		= @NewVertical
		AND		CB.Horizontal	= @NewHorizontal
	
		-- Marking the current Square to Empty

		UPDATE	ChessBoard
		SET		PieceID			= 0
		WHERE	Horizontal		= @CurrentHorizontal
		AND		Vertical		= @CurrentVertical

		-- Moving to the New Square 
	
		UPDATE	ChessBoard
		SET		PieceID			= @PieceID
		WHERE	Horizontal		= @NewHorizontal
		AND		Vertical		= @NewVertical

		EXEC SP_ChessBoard_Display @PieceSide -- Display the chessboard after the movement

	END
	ELSE
	BEGIN

		-- Marking all possible Moves 

		UPDATE	Chessboard 
		SET		PieceID			= CB.PieceID + 100		-- Updating all the potential movements with special records
		FROM	Chessboard	CB
		JOIN	NextMoves	NM
		ON		CB.PieceID		= NM.PieceID
		WHERE	CB.vertical		= NM.vertical
		AND		CB.Horizontal	= NM.Horizontal

		EXEC	SP_ChessBoard_Display @PieceSide		-- Display the chessboard after the movement

		UPDATE	Chessboard 
		SET		PieceID			= CB.PieceID - 100		-- Reverting back all the potential movements back to the original values
		FROM	Chessboard		CB
		WHERE	PieceID			>= 100
	END
END