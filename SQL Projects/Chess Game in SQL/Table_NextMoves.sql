USE ChessDB
GO
CREATE TABLE NextMoves
	(
		Vertical			CHAR(1),	-- The Next Possible Moving Square's Vertical Alphabet
		Vertical_INT		TINYINT,	-- The Next Possible Moving Square's Vertical INT
		Horizontal			TINYINT,	-- The Next Possible Moving Square's Horizontal
		PieceSide			CHAR(1),	-- The Moving Piece Side
		PieceID				TINYINT		-- The Impacted Piece ID
	);
