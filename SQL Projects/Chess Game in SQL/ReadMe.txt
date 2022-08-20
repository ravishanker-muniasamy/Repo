This Project is for creating a simple Chess Game using SQL

The recent International Chess Olympiad held at Chennai triggered a thought in me to build the game using SQL. It was little challenging and interesting to spend couple of days to complete this project. I have uploaded source code of this project to GITHUB for others to look into and provide feedback.

How to Play the Game:
=====================
Open the 'Play Chess Game' File and find the Sample stored procedure command given to execute to play the game. 

To Start a New Game:
EXEC SP_ChessBoard_Play 'N'	-- This startement will be the first SP execution to start a new game.

To move a piece: 
EXEC SP_ChessBoard_Play 'M','W,P,6','c4' -- Execute SP with 'M' Parameter to Move a Piece. 2nd Parameter is the Piece that you want to move. W/B will represent White or Black piece, second character will be K/Q/R/Kt/B/P to represent King/Queen/Rook/Knight/Bishop/Pawn and the third character will represent the identity of the piece if there are multiple pieces. For example, King and Queen are single piece per side. So this is not needed. You can pass 'W,Q' or 'B,K' as second parameter without specifying the number. 'W,B,1' or 'W,B,2' for White Bishop pieces and 1 to 8 for Pawns like  'W,P,6' etc.
The 3rd parameter will be the square place to where you want to move this piece in the Chess board in Row,Column format. Rows are a,b,c,d,e,f,g,h and columns will be from 1-8. 

To Simulate a move:
If you want to simulate the next move without making the move and also to get all possible moves possible for a given piece, then enter with 'S' in the first parameter and the piece information in the second parameter like given below.

EXEC SP_ChessBoard_Play 'S','W,P,6'

To get the list of all moves History made in the current game:
EXEC SP_ChessBoard_Play 'H'	

To display the chessboard, you can execute the command:
EXEC SP_ChessBoard_Play 'DW' This will display the board in White pieces player perspective
EXEC SP_ChessBoard_Play 'DB' This will display the board in Black pieces player perspective

To Reverse/Undo the last moves:
EXEC SP_ChessBoard_Play 'R' You can execute the SP with 'R' parameter to reverse the last move made. This will undo the last move. This command can be executed multiple times to undo all the moves of this game and take it to original position by executing as many number of times.

Implemented Functionalities:
============================
•	Players can pay the Chess Game by calling Stored Procedure with simple parameters
•	All next possible moves of the selected piece will be generated and shown
•	Previous played piece movements can be reversed one by one till start of the play
•	All the piece movement history is maintained
•	Chess board layout will be displayed in SQL output
•	Chess board layout will be shown in both White pieces player and Black piece Player perspective

Technical Implementation:
=========================
•	Normalized Table design
•	Recursive SQL Query & PIVOT are used
•	Modularized Stored Procedures approach
•	Error handling
•	Totally 10 Objects (4 Tables & 6 Stored Procedures)
•	Approximate 600 Lines of Code written
•	Added detailed Comments for easy to understand
