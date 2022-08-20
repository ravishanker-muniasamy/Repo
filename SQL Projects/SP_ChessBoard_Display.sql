USE ChessDB
-- ChessBoard Display

-- EXEC SP_ChessBoard_Display 'B'

DROP PROC SP_ChessBoard_Display
GO
CREATE PROC SP_ChessBoard_Display	@Inverted_Flag CHAR(1) = 'W'  -- Inverted Flag will be used to display the Chess board straight or Inverted.
AS
BEGIN

	-- Vertical columns are PIVOTed

		CREATE TABLE #ChessboardPivot
		(
		Horizontal TINYINT, 
		a VARCHAR(10), 
		b VARCHAR(10),
		c VARCHAR(10), 
		d VARCHAR(10), 
		e VARCHAR(10), 
		f VARCHAR(10), 
		g VARCHAR(10), 
		h VARCHAR(10)
		)
			
	-- Inverted_Flag W value is the default and display the board for Player who play with White Pieces 

	IF @Inverted_Flag = 'W'
	BEGIN

		INSERT INTO	#ChessboardPivot
		SELECT	Horizontal, a, b, c, d, e, f, g, h	
		FROM	
			(
			SELECT Horizontal, Vertical, PieceID
			FROM ChessBoard
			) SRC
		PIVOT	
		(
			AVG(PieceID)
			FOR Vertical IN ([a],[b],[c],[d],[e],[f],[g],[h])
		) AS PivotTable

	-- Piece short names are shown by JOINING with Piece table
	
		SELECT	Horizontal 'No', 
				a.PieceShortName a, 
				b.PieceShortName b, 
				c.PieceShortName c, 
				d.PieceShortName d,
				e.PieceShortName e, 
				f.PieceShortName f, 
				g.PieceShortName g, 
				h.PieceShortName h
		FROM	#ChessboardPivot CBP
		JOIN	Piece a ON CBP.a = a.PieceID
		JOIN	Piece b ON CBP.b = b.PieceID
		JOIN	Piece c ON CBP.c = c.PieceID
		JOIN	Piece d ON CBP.d = d.PieceID
		JOIN	Piece e ON CBP.e = e.PieceID
		JOIN	Piece f ON CBP.f = f.PieceID
		JOIN	Piece g ON CBP.g = g.PieceID
		JOIN	Piece h ON CBP.h = h.PieceID
		ORDER BY Horizontal DESC
	END
	ELSE		-- Inverted_Flag B value is the default and display the board for Player who play with Black Pieces 
	BEGIN
		
		INSERT INTO	#ChessboardPivot
		SELECT	Horizontal, h, g, f, e, d, c, b, a
		FROM	
			(
			SELECT Horizontal, Vertical, PieceID
			FROM ChessBoard
			) SRC
		PIVOT	
		(
			AVG(PieceID)
			FOR Vertical IN ([h],[g],[f],[e],[d],[c],[b],[a])
		) AS PivotTable

		SELECT	Horizontal 'No', 
				a.PieceShortName a, 
				b.PieceShortName b, 
				c.PieceShortName c, 
				d.PieceShortName d,
				e.PieceShortName e, 
				f.PieceShortName f, 
				g.PieceShortName g, 
				h.PieceShortName h
		FROM	#ChessboardPivot CBP
		JOIN	Piece a ON CBP.a = a.PieceID
		JOIN	Piece b ON CBP.b = b.PieceID
		JOIN	Piece c ON CBP.c = c.PieceID
		JOIN	Piece d ON CBP.d = d.PieceID
		JOIN	Piece e ON CBP.e = e.PieceID
		JOIN	Piece f ON CBP.f = f.PieceID
		JOIN	Piece g ON CBP.g = g.PieceID
		JOIN	Piece h ON CBP.h = h.PieceID
		ORDER BY Horizontal
	END

	DROP TABLE #ChessboardPivot
END
