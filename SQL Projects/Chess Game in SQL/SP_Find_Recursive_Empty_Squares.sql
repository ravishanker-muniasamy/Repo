USE ChessDB
GO
CREATE PROC SP_Find_All_Valid_Moves
(@CurrentVerticalINT TINYINT, @CurrentHorizontal TINYINT, 
@CurrentPieceSide CHAR(1),
@VerticalIncrement SMALLINT, @HorizontalIncrement SMALLINT)
AS
BEGIN

		SELECT	CB.*, P.PieceSide
		INTO	#ChessBoard				-- creating a temporary table to fetch the current board information along with its PIECESIDE Value which is needed. 
		FROM	ChessBoard CB
		JOIN	Piece P
		ON		CB.PieceID		= P.PieceID;

		WITH	previous(Vertical, Vertical_INT, Horizontal, PieceID, PieceSide, Opponent_Piece_Flag) AS (
		SELECT	Vertical, Vertical_INT, Horizontal, PieceID, PieceSide, 
				CASE WHEN ISNULL(PieceSide,@CurrentPieceSide) != @CurrentPieceSide THEN 1 ELSE 0 END Opponent_Piece_Flag -- Opponent piece Flag will be set to 1 when it finds 1st opponent piece
		FROM	#ChessBoard	CB
		WHERE	Vertical_INT	= @CurrentVerticalINT + @VerticalIncrement
		AND		Horizontal		= @CurrentHorizontal + @HorizontalIncrement
		AND		(PieceID		= 0 OR ISNULL(PieceSide,@CurrentPieceSide) != @CurrentPieceSide)		-- It fetches empty & opponent piece squares
		UNION ALL
		SELECT	Cur.Vertical, Cur.Vertical_INT, Cur.Horizontal, cur.pieceid, Cur.PieceSide,
				CASE WHEN ISNULL(cur.PieceSide,@CurrentPieceSide) != @CurrentPieceSide THEN 1 ELSE 0 END Opponent_Piece_Flag
		FROM	#ChessBoard cur, previous		-- recurrsive. This will go till it finds empty square or first opponent sqaure. 
		WHERE	cur.Vertical_INT			= previous.Vertical_INT + @VerticalIncrement
		AND		cur.Horizontal				= previous.Horizontal + @HorizontalIncrement
		AND		(cur.PieceID				= 0 OR (ISNULL(cur.PieceSide,@CurrentPieceSide) != @CurrentPieceSide AND previous.Opponent_Piece_Flag = 0))) -- It fetches empty & opponent piece squares

		INSERT INTO NextMoves
		SELECT	Vertical, Vertical_INT, Horizontal, PieceSide, PieceID
		FROM	previous

		DROP TABLE #ChessBoard
END
