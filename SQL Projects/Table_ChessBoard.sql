USE ChessDB
GO
DROP TABLE ChessBoard
GO
CREATE TABLE ChessBoard
(
Vertical			CHAR(1) NOT NULL,
Vertical_INT		TINYINT NOT NULL CONSTRAINT CHK_Vertical_INT   
   CHECK (Vertical_INT >= 1 AND Vertical_INT <= 8),
Horizontal			TINYINT NOT NULL CONSTRAINT CHK_Horizontal_INT   
   CHECK (Horizontal >= 1 AND Horizontal <= 8),
CellColor			BIT		NOT NULL,
PieceID				TINYINT
PRIMARY KEY(Vertical, Horizontal)
)
GO
