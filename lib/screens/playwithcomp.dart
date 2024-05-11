import 'package:cardgame/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cardgame/models/cards.dart';
import 'dart:math'; // For generating random numbers
import 'dart:async'; // For using async features like Timer

// The game screen for playing with the computer
class PlaywithComp extends StatefulWidget {
  @override
  State<PlaywithComp> createState() => _PlaywithCompState();
}

// State class to manage the logic of the game
class _PlaywithCompState extends State<PlaywithComp> {
  // Lists to hold the cards for open deck, players, and throw cards
  List<PlayingCard> openCards = [];
  List<PlayingCard> player1 = [];
  List<PlayingCard> player2 = [];
  List<PlayingCard> player3 = [];
  List<PlayingCard> player4 = [];
  List<List<PlayingCard>> p1_s = [];
  List<List<PlayingCard>> p2_s = [];
  List<List<PlayingCard>> p3_s = [];
  List<List<PlayingCard>> p4_s = [];
  List<PlayingCard> throwCards = []; // Cards that are thrown in each round

  // State variables to track game status and scores
  bool playedround1 = false;
  int player1Score = 0;
  int player2Score = 0;
  int player3Score = 0;
  int player4Score = 0;
  List eachRoundScore = [];
  int lastRoundWinner = 0;
  int roundscompleted = 0;
  bool suitSelectionDialogShown = false; // To show/hide suit selection dialog

  // Boolean variables to determine whether to show or hide the top card for each player
  bool showPlayer1Card = false;
  bool showPlayer2Card = false;
  bool showPlayer3Card = false;
  bool showPlayer4Card = false;

  List<bool> playersArray = List.filled(4, false); // To track player status

  // Suit to enable based on the first card played
  CardSuit suitToEnable = CardSuit.spades;
  bool suitToEnableany = false;

  @override
  void initState() {
    super.initState();
    // Generate unique open cards and shuffle them
    openCards = generateUniqueOpenCards();
    openCards.shuffle();

    // Distribute the cards among players
    distributeCards();
  }

  // Function to get the image path for a given playing card
  String getCardImagePath(PlayingCard card) {
    String suitString = card.cardSuit.toString().split('.').last.toLowerCase(); // Get the suit in lowercase
    String typeString = ''; // Initialize an empty string for the card type

    // Convert the card type to its respective letter or number representation
    switch (card.cardType) {
      case CardType.ace:
        typeString = 'A';
        break;
      case CardType.two:
        typeString = '2';
        break;
      case CardType.three:
        typeString = '3';
        break;
      case CardType.four:
        typeString = '4';
        break;
      case CardType.five:
        typeString = '5';
        break;
      case CardType.six:
        typeString = '6';
        break;
      case CardType.seven:
        typeString = '7';
        break;
      case CardType.eight:
        typeString = '8';
        break;
      case CardType.nine:
        typeString = '9';
        break;
      case CardType.ten:
        typeString = '10';
        break;
      case CardType.jack:
        typeString = 'J';
        break;
      case CardType.queen:
        typeString = 'Q';
        break;
      case CardType.king:
        typeString = 'K';
        break;
    }

    return 'assets/cards_images/$suitString' + '_$typeString.png'; // Return the full image path
  }

  // Generate a unique set of 52 playing cards
  List<PlayingCard> generateUniqueOpenCards() {
    List<PlayingCard> uniqueCards = [];
    Random random = Random();
    Set<String> generatedCards = Set();

    // Generate unique cards until 52 unique cards are created
    while (uniqueCards.length < 52) {
      CardSuit randomSuit = CardSuit.values[random.nextInt(CardSuit.values.length)];
      CardType randomType = CardType.values[random.nextInt(CardType.values.length)];
      String cardKey = '$randomSuit-$randomType';

      if (!generatedCards.contains(cardKey)) {
        uniqueCards.add(PlayingCard(cardSuit: randomSuit, cardType: randomType, faceUp: true, opened: true));
        generatedCards.add(cardKey);
      }
    }

    return uniqueCards;
  }

  // Function to find the card with the highest priority in a list of cards
  int biggerCard(List<PlayingCard> cards) {
    // Define the priority order of card types
    Map<CardType, int> priorityOrder = {
      CardType.ace: 13,
      CardType.king: 12,
      CardType.queen: 11,
      CardType.jack: 10,
      CardType.ten: 9,
      CardType.nine: 8,
      CardType.eight: 7,
      CardType.seven: 6,
      CardType.six: 5,
      CardType.five: 4,
      CardType.four: 3,
      CardType.three: 2,
      CardType.two: 1,
    };

    // Find the card with the highest priority
    PlayingCard? highestCard;
    int highestIndex = -1;

    for (int i = 0; i < cards.length; i++) {
      int currentPriority = priorityOrder[cards[i].cardType] ?? 0;
      if (highestCard == null || currentPriority > (priorityOrder[highestCard.cardType] ?? 0)) {
        highestCard = cards[i];
        highestIndex = i;
      }
    }

    return highestIndex; // Return the index of the highest card
  }

  // Function to populate lists with segregated cards based on suit
  void populateSegregatedCards(List<PlayingCard> player, List<List<PlayingCard>> p_s) {
    for (PlayingCard card in player) {
      int index = card.cardSuit.index; // Get index based on enum value
      p_s[index].add(card);
    }
  }

  // Function to sort the subarrays based on card type priority
  void sortSubarrays(List<List<PlayingCard>> lists) {
    for (List<PlayingCard> sublist in lists) {
      sublist.sort((a, b) => a.cardType.index.compareTo(b.cardType.index)); // Sort based on card type
    }
  }

  // Function to reverse the subarrays
  void reverseSubarrays(List<List<PlayingCard>> lists) {
    for (int i = 0; i < lists.length; i++) {
      lists[i] = lists[i].reversed.toList(); // Reverse each subarray
    }
  }

  // Function to print segregated and sorted cards for debugging
  void printSegregatedAndSortedCards(List<List<PlayingCard>> p_s, String playerName) {
    print('Segregated and Sorted cards for $playerName:');
    for (int i = 0; i < p_s.length; i++) {
      List<String> cardNames = p_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }
  }

  // Function to segregate and sort player cards by suit and type
  void findSimilarSuitCard(
      List<PlayingCard> player1,
      List<PlayingCard> player2,
      List<PlayingCard> player3,
      List<PlayingCard> player4
      ) {
    // Initialize suit-based card groups for each player
    p1_s = List.generate(4, (_) => []);
    p2_s = List.generate(4, (_) => []);
    p3_s = List.generate(4, (_) => []);
    p4_s = List.generate(4, (_) => []);

    // Populate the groups based on the suit of each card
    populateSegregatedCards(player1, p1_s);
    populateSegregatedCards(player2, p2_s);
    populateSegregatedCards(player3, p3_s);
    populateSegregatedCards(player4, p4_s);

    // Sort and reverse the subarrays for consistency
    sortSubarrays(p1_s);
    sortSubarrays(p2_s);
    sortSubarrays(p3_s);
    sortSubarrays(p4_s);

    reverseSubarrays(p1_s);
    reverseSubarrays(p2_s);
    reverseSubarrays(p3_s);
    reverseSubarrays(p4_s);

    // Optional: Print segregated and sorted cards for debugging
    printSegregatedAndSortedCards(p1_s, 'Player 1');
    printSegregatedAndSortedCards(p2_s, 'Player 2');
    printSegregatedAndSortedCards(p3_s, 'Player 3');
    printSegregatedAndSortedCards(p4_s, 'Player 4');
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  // Function to distribute cards among four players
  void distributeCards() {
    int cardsPerPlayer = 13;

    // Split the open cards into four groups
    player1 = openCards.sublist(0, cardsPerPlayer);
    player2 = openCards.sublist(cardsPerPlayer, cardsPerPlayer * 2);
    player3 = openCards.sublist(cardsPerPlayer * 2, cardsPerPlayer * 3);
    player4 = openCards.sublist(cardsPerPlayer * 3);

    // Set initial throw cards
    throwCards = [player1[0], player2[0], player3[0], player4[0]];

    // Populate and segregate the cards by suit
    findSimilarSuitCard(player1, player2, player3, player4);
  }

  // Function to show a dialog comparing the winning card
  void showCardComparisonDialog(PlayingCard winningCard, int highestIndex) {
    // Show an AlertDialog with the winning card details
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on tap outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Round Winner'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Minimize the size of the column
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
            children: [
              Text('Round won by Player ${highestIndex + 1}\nCard Played:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Image.asset(
                getCardImagePath(winningCard),
                width: 100,
                height: 100,
              ),
            ],
          ),
        );
      },
    );

    // Dismiss the dialog after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the dialog

      // Reset the visibility of player cards
      setState(() {
        showPlayer1Card = false;
        showPlayer2Card = false;
        showPlayer3Card = false;
        showPlayer4Card = false;
      });
    });
  }

  // Function to find the winner of the current round based on the player index
  int findRoundWinner(int playerIndex) {
    switch (playerIndex) {
      case 0:
        return 1; // Player 1 is the winner
      case 1:
        return 2; // Player 2
      case 2:
        return 3; // Player 3
      case 3:
        return 4; // Player 4
      default:
        return 0; // Default value
    }
  }

  void playerScore() {
    // Printing scores when the build method is called
    print('Player 1 Score: $player1Score');
    print('Player 2 Score: $player2Score');
    print('Player 3 Score: $player3Score');
    print('Player 4 Score: $player4Score');
  }

  // Function to calculate the total score of a list of playing cards
  int scoreValue(List<PlayingCard> cards) {
    // Priority order for card types with corresponding scores
    Map<CardType, int> priorityOrder = {
      CardType.ace: 140,
      CardType.king: 130,
      CardType.queen: 120,
      CardType.jack: 110,
      CardType.ten: 100,
      CardType.nine: 90,
      CardType.eight: 80,
      CardType.seven: 70,
      CardType.six: 60,
      CardType.five: 50,
      CardType.four: 40,
      CardType.three: 30,
      CardType.two: 20,
    };

    int totalScore = 0; // Initialize the total score

    // Calculate the total score by summing the scores of all cards
    for (PlayingCard card in cards) {
      totalScore += priorityOrder[card.cardType] ?? 0; // Add card score to total score
    }

    return totalScore; // Return the total score
  }

  // Function to find the maximum score among all players
  int findMaxScore() {
    int maxScore = player1Score; // Initialize with Player 1's score

    if (player2Score > maxScore) {
      maxScore = player2Score; // Update if Player 2 has a higher score
    }

    if (player3Score > maxScore) {
      maxScore = player3Score; // Update if Player 3 has a higher score
    }

    if (player4Score > maxScore) {
      maxScore = player4Score; // Update if Player 4 has a higher score
    }

    return maxScore; // Return the maximum score among players
  }

  void suitenabler([int currplayer = 0]) {
    // Update suitToEnable if any of the showPlayerXCard is true
    int index = currplayer;
    suitToEnable = throwCards[index].cardSuit;
    print('inside fnc = $suitToEnable');
  }

  // Function to show a dialog indicating the winner of the game
  void showWinnerDialog() {
    // Find the player with the highest score
    int maxScore = findMaxScore();
    String winner;

    // Determine the winner based on the highest score
    if (maxScore == player1Score) {
      winner = 'Player 1';
    } else if (maxScore == player2Score) {
      winner = 'Player 2';
    } else if (maxScore == player3Score) {
      winner = 'Player 3';
    } else {
      winner = 'Player 4';
    }

    // Show the winner in an AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text(
              'The winner is $winner with a score of $maxScore.\nPlayer 1 Score: $player1Score\nPlayer 2 Score: $player2Score\nPlayer 3 Score: $player3Score\nPlayer 4 Score: $player4Score\n'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text('OK'), // OK button to confirm
            ),
          ],
        );
      },
    );
  }

  // Function to show a suit selection dialog to choose the starting suit
  void showSuitSelectionDialog() {
    // Delay the dialog display until the next frame
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text('Select Starting Suit'), // Dialog title
                content: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize the column
                  children: [
                    // Row of suit options for selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Even spacing
                      children: [
                        // Spades option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              suitToEnable = CardSuit.spades;
                            });
                          },
                          child: Image.asset(
                            'assets/spades.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        // Diamonds option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              suitToEnable = CardSuit.diamonds;
                            });
                          },
                          child: Image.asset(
                            'assets/diamonds.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        // Clubs option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              suitToEnable = CardSuit.clubs;
                            });
                          },
                          child: Image.asset(
                            'assets/clubs.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        // Hearts option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              suitToEnable = CardSuit.hearts;
                            });
                          },
                          child: Image.asset(
                            'assets/hearts.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Spacing
                    Text(
                        'Selected Suit: ${suitToEnable.toString().split('.').last.toUpperCase()}\n YOU ARE PLAYER 1'
                    ), // Display selected suit
                  ],
                ),
                actions: [
                  // OK button to confirm suit selection
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    });
  }

  // Function to remove a specific card from a nested list of playing cards
  void removeCardFromNestedList(List<List<dynamic>> nestedList, var cardToRemove) {
    for (var sublist in nestedList) {
      sublist.removeWhere((card) => card == cardToRemove); // Remove matching card
    }
  }

  // Function to check if a specific suit exists in a nested list of playing cards
  void findSuitAvailability(CardSuit suit, List<List<dynamic>> nestedList) {
    for (int i = 0; i < nestedList.length; i++) {
      if (nestedList[i].isEmpty) {
        suitToEnableany = true; // Indicates if any suit is available
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String roundResultText = '';
    print('current suit = $suitToEnable');

    setState(() {
      if (!suitSelectionDialogShown && roundscompleted==0) {
        // Show the suit selection dialog
        showSuitSelectionDialog();

        // Update the variable to indicate that the dialog has been shown
        suitSelectionDialogShown = true;
      }
    });


    return WillPopScope(
      onWillPop: () async {
        // Show a confirmation dialog when the back button is pressed
        bool closeGame = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Close Game?'),
              content: Text('Do you want to close the game?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // If the user chooses to close the game, pop the current route
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    // If the user chooses not to close the game, stay on the same page
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
        // Return the user's choice to close the game or not
        return closeGame ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set the scaffold background color to transparent
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg2.jpg'), // Replace 'background_image.jpg' with your image asset
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: throwCards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          // Background image
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/cards_images/back_light.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          // Overlay for the selected card's container
                          if ((index == 0 && showPlayer1Card) ||
                              (index == 1 && showPlayer2Card) ||
                              (index == 2 && showPlayer3Card) ||
                              (index == 3 && showPlayer4Card))
                            Container(
                              color: Colors.white, // Color overlay
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                child: Image.asset(
                                  getCardImagePath(throwCards[index]),
                                  width: 200,
                                  height: 150,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),

              ),
              Row( // Row to contain the "Player 1 Cards" text and the PASS button
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      'Your Cards:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: ElevatedButton(
                      onPressed: showPlayer1Card ? () {
                        setState(() {
                          showPlayer1Card = true;
                          showPlayer2Card = true;
                          showPlayer3Card = true;
                          showPlayer4Card = true;

                          playersArray[0] = false;
                          playersArray[1] = false;
                          playersArray[2] = false;
                          playersArray[3] = false;
                        });
                        // Get the selected card from Player 1's hand
                        PlayingCard selectedCard = throwCards[0];

                        // // Remove the selected card from Player 1's hand
                        player1.remove(throwCards[0]);
                        player2.remove(throwCards[1]);
                        player3.remove(throwCards[2]);
                        player4.remove(throwCards[3]);

                        // Remove the card from p1_s
                        removeCardFromNestedList(p1_s, selectedCard);
                        print('p1 length = ${p1_s.length}');

                        throwCards[1] = player2[selectedCard.cardSuit.index] != null && p2_s[selectedCard.cardSuit.index].isNotEmpty ? p2_s[selectedCard.cardSuit.index].removeAt(0) : throwCards[1];
                        throwCards[2] = player3[selectedCard.cardSuit.index] != null && p3_s[selectedCard.cardSuit.index].isNotEmpty ? p3_s[selectedCard.cardSuit.index].removeAt(0) : throwCards[2];
                        throwCards[3] = player4[selectedCard.cardSuit.index] != null && p4_s[selectedCard.cardSuit.index].isNotEmpty ? p4_s[selectedCard.cardSuit.index].removeAt(0) : throwCards[3];

                        // Update UI to reflect the changes
                        setState(() {
                          // Update throwCards with the selected card from Player 1 and top cards from other players
                          throwCards[1] = throwCards[1]; // Update the top card with Player 2's card
                          throwCards[2] = throwCards[2]; // Update Player 2's card with Player 3's card
                          throwCards[3] = throwCards[3]; // Update Player 3's card with Player 4's card
                        });

                        // Call the game logic or any other necessary functions
                        // Here you can call functions like biggerCard() or findSimilarSuitCard() as needed
                        // For example:
                        int? highestIndex = biggerCard(throwCards);
                        int? currentRoundScore = scoreValue(throwCards);
                        print('CurrentRoundScore = $currentRoundScore');
                        if (highestIndex==0) {
                          player1Score+=currentRoundScore;
                        }
                        if (highestIndex==1) {
                          player2Score+=currentRoundScore;
                        }
                        if (highestIndex==2) {
                          player3Score+=currentRoundScore;
                        }
                        if (highestIndex==3) {
                          player4Score+=currentRoundScore;
                        }
                        playerScore();
                        int maxScore = findMaxScore();
                        print('Maximum score among players: $maxScore');

                        // Call showWinnerDialog() when any of the player's card list becomes empty
                        if (player1.isEmpty || player2.isEmpty || player3.isEmpty || player4.isEmpty) {
                          showWinnerDialog();
                        }

                        print('Rounds completed = $roundscompleted');
                        if (highestIndex != null) {
                          // Display the result in an AlertDialog
                          setState(() {
                            showCardComparisonDialog(throwCards[highestIndex], highestIndex);
                            lastRoundWinner = findRoundWinner(highestIndex);
                            roundscompleted++;

                            // If player 4 wins the round, update throwCards with a random card from player4's array
                            setState(() {
                              if (lastRoundWinner == 4) {
                                throwCards[3] = player4[Random().nextInt(player4.length)];
                                suitenabler(3);
                              }
                              // If player 3 wins the round, update throwCards with a random card from player3's array
                              if (lastRoundWinner == 3) {
                                throwCards[2] = player3[Random().nextInt(player3.length)];
                                suitenabler(2);
                              }
                              if (lastRoundWinner == 2) {
                                throwCards[1] = player2[Random().nextInt(player2.length)];
                                suitenabler(1);
                              }
                              printSegregatedAndSortedCards(p1_s, 'Player 1');
                            });
                          });
                        } else {
                          print('Check again!!');
                        }

                        print('winner of last round = $lastRoundWinner');
                        suitToEnableany = false;
                        if (lastRoundWinner==1) {
                          //suitToEnable = CardSuit.clubs;
                          suitToEnableany = true;
                        }

                        findSuitAvailability(suitToEnable, p1_s);
                      } : null,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.zero, // No padding around the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'NEXT >>',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: player1.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Check if the card's suit matches the one to enable
                        if (player1[index].cardSuit != suitToEnable && !suitToEnableany) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You can play only ${suitToEnable.toString().split('.').last.toUpperCase()}'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          print('Card suit does not match suitToEnable. Tap ignored. $suitToEnable');
                        } else {
                          setState(() {
                            // Update the card played by Player 1
                            throwCards[0] = player1[index];

                            // Update suitToEnable if it's the first round
                            if (!playedround1) {
                              suitToEnable = player1[index].cardSuit;
                            }

                            // Update UI to show the selected card on the top player card
                            showPlayer1Card = true;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Image.asset(
                              getCardImagePath(player1[index]),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}