import 'package:flutter/material.dart';
import 'package:cardgame/models/cards.dart';
import 'dart:math';

class PlaywithComp extends StatefulWidget {
  @override
  State<PlaywithComp> createState() => _PlaywithCompState();
}

class _PlaywithCompState extends State<PlaywithComp> {
  List<PlayingCard> openCards = [];
  List<PlayingCard> player1 = [];
  List<PlayingCard> player2 = [];
  List<PlayingCard> player3 = [];
  List<PlayingCard> player4 = [];
  List<List<PlayingCard>> p1_s = [];
  List<List<PlayingCard>> p2_s = [];
  List<List<PlayingCard>> p3_s = [];
  List<List<PlayingCard>> p4_s = [];
  List<PlayingCard> throwCards = [];
  bool playedround1 = false;
  int player1Score = 0;
  int player2Score = 0;
  int player3Score = 0;
  int player4Score = 0;
  List eachRoundScore = [];
  int lastRoundWinner = 0;
  int roundscompleted = 0;

  // Define suitToEnable variable to store the suit of the first card played
  CardSuit suitToEnable = CardSuit.spades;

  @override
  void initState() {
    super.initState();
    // Generate 13 unique open cards
    openCards = generateUniqueOpenCards();

    // Shuffle the cards
    openCards.shuffle();

    // Distribute cards among players
    distributeCards();

    // Set the suitToEnable variable to the suit of the first card played
    suitToEnable = throwCards[0].cardSuit;
  }

  String getCardImagePath(PlayingCard card) {
    String suitString = card.cardSuit.toString().split('.').last.toLowerCase();
    String typeString = '';
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
    return 'assets/cards_images/$suitString' + '_$typeString.png';
  }

  List<PlayingCard> generateUniqueOpenCards() {
    List<PlayingCard> uniqueCards = [];
    Random random = Random();
    Set<String> generatedCards = Set();


    while (uniqueCards.length < 52) {
      CardSuit randomSuit = CardSuit.values[random.nextInt(CardSuit.values.length)];
      CardType randomType = CardType.values[random.nextInt(CardType.values.length)];
      String cardKey = '$randomSuit-$randomType';

      if (!generatedCards.contains(cardKey)) {
        uniqueCards.add(PlayingCard(cardSuit: randomSuit, cardType: randomType, faceUp: true, opened: true));
        generatedCards.add(cardKey);
      }
    }
    //print('generatedCards = $generatedCards');

    return uniqueCards;
  }

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

    // Initialize variables to store the highest card and its index
    PlayingCard? highestCard;
    int highestIndex = -1; // Initialize with an invalid index

    // Iterate through the cards to find the highest card
    for (int i = 0; i < cards.length; i++) {
      PlayingCard currentCard = cards[i];

      // Get the priority of the current card type
      int currentPriority = priorityOrder[currentCard.cardType] ?? 0;

      // Check if the current card is higher than the previous highest card
      if (highestCard == null || currentPriority > (priorityOrder[highestCard.cardType] ?? 0)) {
        highestCard = currentCard;
        highestIndex = i;
      }
    }

    // Return the index of the highest card
    return highestIndex;
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
      sublist.sort((a, b) => a.cardType.index.compareTo(b.cardType.index)); // Sort based on card type priority
    }
  }

  // Function to reverse the subarrays
  void reverseSubarrays(List<List<PlayingCard>> lists) {
    for (int i = 0; i < lists.length; i++) {
      lists[i] = lists[i].reversed.toList(); // Reverse the sublist and assign it back to the original list
    }
  }

  // Function to print segregated and sorted cards
  void printSegregatedAndSortedCards(List<List<PlayingCard>> p_s, String playerName) {
    print('Segregated and Sorted cards for $playerName:');
    for (int i = 0; i < p_s.length; i++) {
      List<String> cardNames = p_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }
  }

  void findSimilarSuitCard(List<PlayingCard> player1, List<PlayingCard> player2, List<PlayingCard> player3, List<PlayingCard> player4) {
    // Create lists to store segregated cards for each player and each suit
    p1_s = List.generate(4, (_) => []);
    p2_s = List.generate(4, (_) => []);
    p3_s = List.generate(4, (_) => []);
    p4_s = List.generate(4, (_) => []);

    // Populate lists with segregated cards based on suit
    populateSegregatedCards(player1, p1_s);
    populateSegregatedCards(player2, p2_s);
    populateSegregatedCards(player3, p3_s);
    populateSegregatedCards(player4, p4_s);

    // Sort the subarrays based on card type priority
    sortSubarrays(p1_s);
    sortSubarrays(p2_s);
    sortSubarrays(p3_s);
    sortSubarrays(p4_s);

    // Reverse the subarrays
    reverseSubarrays(p1_s);
    reverseSubarrays(p2_s);
    reverseSubarrays(p3_s);
    reverseSubarrays(p4_s);

    // Print segregated and sorted cards
    printSegregatedAndSortedCards(p1_s, 'Player 1');
    printSegregatedAndSortedCards(p2_s, 'Player 2');
    printSegregatedAndSortedCards(p3_s, 'Player 3');
    printSegregatedAndSortedCards(p4_s, 'Player 4');
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  void distributeCards() {
    int cardsPerPlayer = 13;
    player1 = openCards.sublist(0, cardsPerPlayer);
    player2 = openCards.sublist(cardsPerPlayer, cardsPerPlayer * 2);
    player3 = openCards.sublist(cardsPerPlayer * 2, cardsPerPlayer * 3);
    player4 = openCards.sublist(cardsPerPlayer * 3);

    throwCards = [player1[0], player2[0], player3[0], player4[0]];
    //print('player[0]=${player1[0]}');
    findSimilarSuitCard(player1, player2, player3, player4); //Used to segregate the cards as per suits

    //printPlayerCards(player2, "Player 2");
    //printPlayerCards(player3, "Player 3");
    //printPlayerCards(player4, "Player 4");
  }

  void showCardComparisonDialog(String message, int playerIndex) {
    // Schedule the state update after the build method completes
    Future.delayed(Duration.zero, () {
      // Print the index of the winning player
      print('Winner: Player ${playerIndex + 1}');

      // Show the dialog after updating the state
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Card Comparison Result'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message),
                SizedBox(height: 10),
                Text('Played by Player ${playerIndex + 1}'),
              ],
            ),
            actions: <Widget>[
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
    });
  }

  // Function to find the winner of the current round
  int findRoundWinner(int playerIndex) {
    if (playerIndex == 0) {
      return 1; //Returning player number
    }
    if (playerIndex == 1) {
      return 2;
    }
    if (playerIndex == 2) {
      return 3;
    }
    if (playerIndex == 3) {
      return 4;
    }
    return 0;
    // Implement your logic to determine the winner of the round
    // For now, let's assume player 4 always wins the round
  }

  void playerScore() {
    // Printing scores when the build method is called
    print('Player 1 Score: $player1Score');
    print('Player 2 Score: $player2Score');
    print('Player 3 Score: $player3Score');
    print('Player 4 Score: $player4Score');
  }

  int scoreValue(List<PlayingCard> cards) {
    // Define the priority order of card types with corresponding scores
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

    // Initialize variable to store the total score
    int totalScore = 0;

    // Iterate through the cards to calculate the total score
    for (PlayingCard card in cards) {
      // Get the score of the current card type
      int cardScore = priorityOrder[card.cardType] ?? 0;

      // Add the score of the current card to the total score
      totalScore += cardScore;
    }

    // Return the total score
    return totalScore;
  }

  int findMaxScore() {
    // Find the maximum score among player1, player2, player3, and player4 scores
    int maxScore = player1Score;
    if (player2Score > maxScore) {
      maxScore = player2Score;
    }
    if (player3Score > maxScore) {
      maxScore = player3Score;
    }
    if (player4Score > maxScore) {
      maxScore = player4Score;
    }
    return maxScore;
  }





  @override
  Widget build(BuildContext context) {
    String roundResultText = '';

    return Scaffold(
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Image.asset(
                          getCardImagePath(throwCards[index]),
                          width: 200,
                          height: 150,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row( // Row to contain the "Player 1 Cards" text and the PASS button
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Your Cards:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Get the selected card from Player 1's hand
                    PlayingCard selectedCard = throwCards[0];

                    // // Remove the selected card from Player 1's hand
                    player1.remove(throwCards[0]);
                    player2.remove(throwCards[1]);
                    player3.remove(throwCards[2]);
                    player4.remove(throwCards[3]);

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
                    if (highestIndex != null) {
                      // Display the result in an AlertDialog
                      setState(() {
                        showCardComparisonDialog('${throwCards[highestIndex].printCardInfo(throwCards[highestIndex])} is bigger', highestIndex);
                        lastRoundWinner = findRoundWinner(highestIndex);
                        roundscompleted=1;
                      });
                    } else {
                      print('Check again!!');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.zero, // No padding around the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'PASS',
                    style: TextStyle(
                      color: Colors.black,
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
                      PlayingCard tappedCard = player1[index];
                      if (!playedround1 || tappedCard.cardSuit == suitToEnable) {
                        setState(() {
                          // Update the card played by Player 1
                          throwCards[0] = tappedCard;

                          // Update suitToEnable if it's the first round
                          if (!playedround1) {
                            suitToEnable = tappedCard.cardSuit;
                          }

                          // Remove the played card from all players' hands
                          player1.remove(throwCards[0]);

                          // Ensure that indices are within bounds before accessing throwCards
                          if (throwCards.length > 1) {
                            player2.remove(throwCards[1]);
                          }
                          if (throwCards.length > 2) {
                            player3.remove(throwCards[2]);
                          }
                          if (throwCards.length > 3) {
                            player4.remove(throwCards[3]);
                          }
                        });
                      } else {
                        // If it's not the first round and the selected card's suit is not the same as the suitToEnable, prevent the player from selecting a card
                        // Optionally, you can show a message or disable interaction here
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
    );
  }
}