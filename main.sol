// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TicTacToe {
    enum Player { None, X, O }
    enum GameState { Waiting, InProgress, Finished }
    
    struct Game {
        address playerX;
        address playerO;
        Player[3][3] board;
        Player currentTurn;
        GameState state;
        address winner;
    }

    mapping(uint256 => Game) public games;
    uint256 public gameCounter;
    
    event GameCreated(uint256 gameId, address indexed playerX);
    event GameJoined(uint256 gameId, address indexed playerO);
    event MoveMade(uint256 gameId, address indexed player, uint8 row, uint8 col);
    event GameFinished(uint256 gameId, address winner);
    
    function createGame() external {
        gameCounter++;
        games[gameCounter] = Game(msg.sender, address(0), [[Player.None, Player.None, Player.None], [Player.None, Player.None, Player.None], [Player.None, Player.None, Player.None]], Player.X, GameState.Waiting, address(0));
        emit GameCreated(gameCounter, msg.sender);
    }
    
    function joinGame(uint256 gameId) external {
        Game storage game = games[gameId];
        require(game.state == GameState.Waiting, "Game not available");
        require(msg.sender != game.playerX, "Cannot play against yourself");
        
        game.playerO = msg.sender;
        game.state = GameState.InProgress;
        emit GameJoined(gameId, msg.sender);
    }
    
    function makeMove(uint256 gameId, uint8 row, uint8 col) external {
        Game storage game = games[gameId];
        require(game.state == GameState.InProgress, "Game is not active");
        require(game.currentTurn == Player.X && msg.sender == game.playerX || game.currentTurn == Player.O && msg.sender == game.playerO, "Not your turn");
        require(row < 3 && col < 3, "Invalid position");
        require(game.board[row][col] == Player.None, "Cell occupied");
        
        game.board[row][col] = game.currentTurn;
        emit MoveMade(gameId, msg.sender, row, col);
        
        if (checkWin(game.board, game.currentTurn)) {
            game.state = GameState.Finished;
            game.winner = msg.sender;
            emit GameFinished(gameId, msg.sender);
        } else {
            game.currentTurn = (game.currentTurn == Player.X) ? Player.O : Player.X;
        }
    }
    
    function checkWin(Player[3][3] memory board, Player player) internal pure returns (bool) {
        for (uint8 i = 0; i < 3; i++) {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true;
            if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true;
        }
        if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
        if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;
        return false;
    }
}
