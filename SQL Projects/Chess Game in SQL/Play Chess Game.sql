-- Play Chess Game
-- This file is given with sample way of executing the SQL stored procedure to Play the game. 

USE ChessDB


EXEC SP_ChessBoard_Play 'N'	-- Start a New Game
EXEC SP_ChessBoard_Play 'M','W,P,6','c4' -- Move a Piece 
EXEC SP_ChessBoard_Play 'M','B,P,3','c6'
EXEC SP_ChessBoard_Play 'M','W,Kt,2','a3' -- select a piece & place to move
EXEC SP_ChessBoard_Play 'M','B,Q','a5'
EXEC SP_ChessBoard_Play 'M','W,P,4','e3'
EXEC SP_ChessBoard_Play 'M','B,Kt,2','f6'
EXEC SP_ChessBoard_Play 'S','B,Q' -- Show all possible moves of a Piece 
EXEC SP_ChessBoard_Play 'M','B,Q','a3'
EXEC SP_ChessBoard_Play 'H'	-- See the piece movements history 
EXEC SP_ChessBoard_Play 'DW' -- Display ChessBoard White pieces perspective
EXEC SP_ChessBoard_Play 'R' -- Reverse the previous piece movement
