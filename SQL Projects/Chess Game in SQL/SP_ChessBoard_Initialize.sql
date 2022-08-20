USE ChessDB
GO
CREATE PROC SP_ChessBoard_Initialize
AS
BEGIN

-- This Procedure will reset the position of the pieces into the original chess board squares position

	DELETE FROM Piecemovement		-- Remove the previous game's movement records

	DELETE FROM ChessBoard			-- Remove the current chess board piece positions
	
	INSERT INTO ChessBoard			-- Move pieces to the original chess board positions
	(Vertical,Vertical_INT,Horizontal,CellColor,PieceID)
	Values
	('a',1,1,1,24),		-- White board Pieces
	('b',2,1,0,22),
	('c',3,1,1,20),
	('d',4,1,0,18),
	('e',5,1,1,17),
	('f',6,1,0,19),
	('g',7,1,1,21),
	('h',8,1,0,23),
	('a',1,2,0,32),
	('b',2,2,1,31),
	('c',3,2,0,30),
	('d',4,2,1,29),
	('e',5,2,0,28),
	('f',6,2,1,27),
	('g',7,2,0,26),
	('h',8,2,1,25),
	('a',1,3,0,0),		-- Empty Squares
	('b',2,3,1,0),
	('c',3,3,0,0),
	('d',4,3,1,0),
	('e',5,3,0,0),
	('f',6,3,1,0),
	('g',7,3,0,0),
	('h',8,3,1,0),
	('a',1,4,1,0),
	('b',2,4,0,0),
	('c',3,4,1,0),
	('d',4,4,0,0),
	('e',5,4,1,0),
	('f',6,4,0,0),
	('g',7,4,1,0),
	('h',8,4,0,0),
	('a',1,5,0,0),
	('b',2,5,1,0),
	('c',3,5,0,0),
	('d',4,5,1,0),
	('e',5,5,0,0),
	('f',6,5,1,0),
	('g',7,5,0,0),
	('h',8,5,1,0),
	('a',1,6,1,0),
	('b',2,6,0,0),
	('c',3,6,1,0),
	('d',4,6,0,0),
	('e',5,6,1,0),
	('f',6,6,0,0),
	('g',7,6,1,0),
	('h',8,6,0,0),
	('a',1,7,1,9),			-- Black board Pieces
	('b',2,7,0,10),
	('c',3,7,1,11),
	('d',4,7,0,12),
	('e',5,7,1,13),
	('f',6,7,0,14),
	('g',7,7,1,15),
	('h',8,7,0,16),
	('a',1,8,0,7),
	('b',2,8,1,5),
	('c',3,8,0,3),
	('d',4,8,1,2),
	('e',5,8,0,1),
	('f',6,8,1,4),
	('g',7,8,0,6),
	('h',8,8,1,8)
END
