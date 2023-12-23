import 'dart:io';
//This class encapsulates the functionalities of the Tic-Tac-Toe game.
class TicTacToe {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';
//Displays the welcome message, player markers, and the initial empty board.
  void startGame() {
      
    print('Welcome to Tic-Tac-Toe!');
    print('Player 1: X | Player 2: O');
    printBoard();
    playGame();
  }
//Displays the current state of the board in a 3x3 grid format.
  void printBoard() {
    print(' ${board[0]} | ${board[1]} | ${board[2]}');
    print('-----------');
    print(' ${board[3]} | ${board[4]} | ${board[5]}');
    print('-----------');
    print(' ${board[6]} | ${board[7]} | ${board[8]}');
  }
//Contains the main game loop.
// Continuously prompts players to make moves until there's a winner or a draw.
// Handles move validation, checks for a winner after each move, and switches players.
// Allows the option to play another game at the end.
  void playGame() {
    while (true) {
      int move = askForMove();
      if (move == -1) {
        print('Invalid input. Please enter a number between 1 and 9.');
        continue;
      }
      if (board[move] != ' ') {
        print('Cell already taken. Choose another.');
        continue;
      }
      board[move] = currentPlayer;
      printBoard();
      if (checkWinner()) {
        print('Player $currentPlayer wins!');
        break;
      }
      if (board.every((element) => element != ' ')) {
        print('It\'s a draw!');
        break;
      }
      currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    }
    if (playAgain()) {
      board = List.filled(9, ' ');
      currentPlayer = 'X';
      print('\nNew game started!');
      printBoard();
      playGame();
    } else {
      print('Thanks for playing!');
    }
  }

  int askForMove() {
    print('Player $currentPlayer, enter your move (1-9):');
    int? move = int.tryParse(stdin.readLineSync()!);
    return (move != null && move >= 1 && move <= 9) ? move - 1 : -1;
  }
// Defines the winning conditions for Tic-Tac-Toe based on the game board.
// Checks for all possible win conditions (rows, columns, diagonals) to determine if there's a winner.
  bool checkWinner() {
    List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var condition in winningConditions) {
      if (board[condition[0]] != ' ' &&
          board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]]) {
        return true;
      }
    }
    return false;
  }

  bool playAgain() {
    print('Do you want to play again? (yes/no)');
    String? choice = stdin.readLineSync()?.toLowerCase();
    return choice == 'yes';
  }
}

void main() {
  TicTacToe().startGame();
}
