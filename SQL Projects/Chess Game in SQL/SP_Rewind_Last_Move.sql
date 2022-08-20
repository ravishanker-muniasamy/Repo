USE ChessDB
GO
ALTER PROC SP_Rewind_Last_Move
AS
BEGIN
	DECLARE	@Last_To_Vertical		CHAR(1),
			@Last_To_Horizontal		TINYINT,
			@Last_From_Vertical		CHAR(1),
			@Last_From_Horizontal	TINYINT,
			@Removed_PieceID		TINYINT,
			@Moved_PieceID			TINYINT,
			@LastMoveNo				SMALLINT

	SELECT	@LastMoveNo	= ISNULL(Max(Sequence_No),0)		-- Get the last movement sequence number
	FROM	PieceMovement

	IF	@LastMoveNo	= 0						-- If no records found, then there is no movement to reverse
	BEGIN
			SELECT 'No Previous Move Found'
			RETURN
	END

	SELECT	@Last_To_Vertical		= To_Vertical,
			@Last_To_Horizontal		= To_Horizontal,
			@Last_From_Vertical		= From_Vertical,
			@Last_From_Horizontal	= From_Horizontal,
			@Removed_PieceID		= Removed_PieceID,
			@Moved_PieceID			= Moved_PieceID
	FROM	PieceMovement
	WHERE	Sequence_No		= @LastMoveNo				-- Fetch all details of the previous move

	UPDATE	ChessBoard
	SET		PieceID			= @Removed_PieceID			-- Reverse the last move's to square
	WHERE	Horizontal		= @Last_To_Horizontal
	AND		Vertical		= @Last_To_Vertical

	-- Moving to the New Square 
	
	UPDATE	ChessBoard
	SET		PieceID			= @Moved_PieceID			-- Reverse the last move's from square
	WHERE	Horizontal		= @Last_From_Horizontal
	AND		Vertical		= @Last_From_Vertical

	DELETE												-- Delete the previous movement record
	FROM	PieceMovement
	WHERE	Sequence_No		= @LastMoveNo

END