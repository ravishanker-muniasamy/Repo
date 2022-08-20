DROP TABLE Piece
GO
CREATE TABLE Piece
(
PieceID			TINYINT PRIMARY KEY,		-- Piece Key
PieceName		VARCHAR(20) NOT NULL,		-- Piece Full Name
PieceShortName	VARCHAR(10) NOT NULL,		-- Piece Display Name
PieceInitial	VARCHAR(2) NOT NULL,		-- Piece Initial K, Q, R, Kt, B, P
PieceSide		CHAR(1),					-- W or B to represent White or Black
PieceNumber		TINYINT	NOT NULL			-- To represent multiple pieces since R, B, Kt has 2 Pieces and Pawn has 8 Pieces
)
GO
-- To Pupulate the Metadata

DELETE FROM Piece
GO
INSERT INTO Piece
Values (0, 'Empty', ' ', ' ',NULL, 0),		-- No Piece. This will be used to display Empty Square without any piece
(1, 'Black King', 'B,K', 'K','B', 1),
(2, 'Black Queen', 'B,Q', 'Q','B',1),
(3, 'Black Bishop 1', 'B,B,1', 'B', 'B', 1),
(4, 'Black Bishop 2', 'B,B,2', 'B', 'B', 2),
(5, 'Black Knight 1', 'B,Kt,1', 'Kt', 'B', 1),
(6, 'Black Knight 2', 'B,Kt,2', 'Kt', 'B', 2),
(7, 'Black Rook 1', 'B,R,1', 'R', 'B', 1),
(8, 'Black Rook 2', 'B,R,2', 'R', 'B', 2),
(9, 'Black Pawn 1', 'B,P,1', 'P', 'B', 1),
(10, 'Black Pawn 2', 'B,P,2', 'P', 'B', 2),
(11, 'Black Pawn 3', 'B,P,3', 'P', 'B', 3),
(12, 'Black Pawn 4', 'B,P,4', 'P', 'B', 4),
(13, 'Black Pawn 5', 'B,P,5', 'P', 'B', 5),
(14, 'Black Pawn 6', 'B,P,6', 'P', 'B', 6),
(15, 'Black Pawn 7', 'B,P,7', 'P', 'B', 7),
(16, 'Black Pawn 8', 'B,P,8', 'P', 'B', 8),
(17, 'White King', 'W,K', 'K','W', 1),
(18, 'White Queen', 'W,Q', 'Q','W',1),
(19, 'White Bishop 1', 'W,B,1', 'B', 'W', 1),
(20, 'White Bishop 2', 'W,B,2', 'B', 'W', 2),
(21, 'White Knight 1', 'W,Kt,1', 'Kt', 'W', 1),
(22, 'White Knight 2', 'W,Kt,2', 'Kt', 'W', 2),
(23, 'White Rook 1', 'W,R,1', 'R', 'W', 1),
(24, 'White Rook 2', 'W,R,2', 'R', 'W', 2),
(25, 'White Pawn 1', 'W,P,1', 'P', 'W', 1),
(26, 'White Pawn 2', 'W,P,2', 'P', 'W', 2),
(27, 'White Pawn 3', 'W,P,3', 'P', 'W', 3),
(28, 'White Pawn 4', 'W,P,4', 'P', 'W', 4),
(29, 'White Pawn 5', 'W,P,5', 'P', 'W', 5),
(30, 'White Pawn 6', 'W,P,6', 'P', 'W', 6),
(31, 'White Pawn 7', 'W,P,7', 'P', 'W', 7),
(32, 'White Pawn 8', 'W,P,8', 'P', 'W', 8)

-- The below Pieces will be used in the Simulation process to show the opponent piece which can be cut. The name will be displayed astrik suffixed

INSERT INTO Piece							
Values (100, '*', '*', '*','*', 0),						-- Empty square where the move is possible
(101, 'Black King', 'B,K*', 'K','B', 1),				-- Below are the squares where opponent pieces can be cut
(102, 'Black Queen', 'B,Q*', 'Q','B',1),
(103, 'Black Bishop 1', 'B,B,1*', 'B', 'B', 1),
(104, 'Black Bishop 2', 'B,B,2*', 'B', 'B', 2),
(105, 'Black Knight 1', 'B,Kt,1*', 'Kt', 'B', 1),
(106, 'Black Knight 2', 'B,Kt,2*', 'Kt', 'B', 2),
(107, 'Black Rook 1', 'B,R,1*', 'R', 'B', 1),
(108, 'Black Rook 2', 'B,R,2*', 'R', 'B', 2),
(109, 'Black Pawn 1', 'B,P,1*', 'P', 'B', 1),
(110, 'Black Pawn 2', 'B,P,2*', 'P', 'B', 2),
(111, 'Black Pawn 3', 'B,P,3*', 'P', 'B', 3),
(112, 'Black Pawn 4', 'B,P,4*', 'P', 'B', 4),
(113, 'Black Pawn 5', 'B,P,5*', 'P', 'B', 5),
(114, 'Black Pawn 6', 'B,P,6*', 'P', 'B', 6),
(115, 'Black Pawn 7', 'B,P,7*', 'P', 'B', 7),
(116, 'Black Pawn 8', 'B,P,8*', 'P', 'B', 8),
(117, 'White King', 'W,K*', 'K','W', 1),
(118, 'White Queen', 'W,Q*', 'Q','W',1),
(119, 'White Bishop 1', 'W,B,1*', 'B', 'W', 1),
(120, 'White Bishop 2', 'W,B,2*', 'B', 'W', 2),
(121, 'White Knight 1', 'W,Kt,1*', 'Kt', 'W', 1),
(122, 'White Knight 2', 'W,Kt,2*', 'Kt', 'W', 2),
(123, 'White Rook 1', 'W,R,1*', 'R', 'W', 1),
(124, 'White Rook 2', 'W,R,2*', 'R', 'W', 2),
(125, 'White Pawn 1', 'W,P,1*', 'P', 'W', 1),
(126, 'White Pawn 2', 'W,P,2*', 'P', 'W', 2),
(127, 'White Pawn 3', 'W,P,3*', 'P', 'W', 3),
(128, 'White Pawn 4', 'W,P,4*', 'P', 'W', 4),
(129, 'White Pawn 5', 'W,P,5*', 'P', 'W', 5),
(130, 'White Pawn 6', 'W,P,6*', 'P', 'W', 6),
(131, 'White Pawn 7', 'W,P,7*', 'P', 'W', 7),
(132, 'White Pawn 8', 'W,P,8*', 'P', 'W', 8)

