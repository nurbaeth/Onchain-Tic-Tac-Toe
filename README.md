# Onchain Tic-Tac-Toe

Onchain Tic-Tac-Toe is a decentralized tic-tac-toe game built on Solidity. Players can challenge each other, make moves, and verify results directly on the blockchain, ensuring fairness and transparency.

## Features
- Fully on-chain game logic
- Two-player mode
- Transparent and immutable game history 
- No third-party interference

## Smart Contract Overview
The contract supports:
- **Game Creation** – A player can create a new game.
- **Game Joining** – Another player can join an existing game.
- **Making Moves** – Players take turns making moves on the 3x3 grid.
- **Win Detection** – The contract verifies when a player wins.
- **Game State Management** – Keeps track of the game progress and results.

## How to Use
### 1. Deploy the Contract
Deploy the `TicTacToe` smart contract on an EVM-compatible blockchain.

### 2. Create a Game
Call `createGame()` to start a new game. The caller becomes Player X.

### 3. Join a Game
Another player can call `joinGame(gameId)` to join an available game as Player O.

### 4. Make a Move
Players take turns calling `makeMove(gameId, row, col)`, ensuring valid moves.

### 5. Win Detection
The contract automatically checks for a winner after each move and updates the game state.

## Smart Contract Functions
### `createGame()`
Creates a new game and assigns the sender as Player X.

### `joinGame(uint256 gameId)`
Allows another player to join the created game as Player O.

### `makeMove(uint256 gameId, uint8 row, uint8 col)`
Makes a move on the board if the position is valid and updates the game state.

### `checkWin(Player[3][3] memory board, Player player) internal pure returns (bool)`
Checks if the given player has won the game.

## Example Interaction
1. Alice calls `createGame()`, becoming Player X.
2. Bob calls `joinGame(gameId)`, becoming Player O.
3. Alice and Bob take turns calling `makeMove(gameId, row, col)`.
4. When a player wins, the contract emits `GameFinished(gameId, winner)`.

## License
This project is licensed under the MIT License.
