USE ChessDB
-- Table to store the piece that were cut in the chess game
GO
CREATE TABLE PieceMovement
(
Sequence_No				SMALLINT,
Removed_PieceID			TINYINT, 
Removed_PieceShortName	VARCHAR(10), 
Moved_PieceID			TINYINT, 
Moved_PieceShortName	VARCHAR(10), 
To_Vertical				CHAR(1),
To_Horizontal			CHAR(1),
From_Vertical			CHAR(1),
From_Horizontal			CHAR(1),
Move_time				DATETIME DEFAULT(GETDATE())
)
GO
SELECT	* 
FROM	PieceMovement
