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

  // Define suitToEnable variable to store the suit of the first card played
  CardSuit suitToEnable = CardSuit.spades;

  @override
  void initState() {
    super.initState();
    // Generate 13 unique open cards
    openCards = generateUniqueOpenCards();

    // Ensure throwCards is not empty before accessing its first element
    if (throwCards.isNotEmpty) {
      suitToEnable = throwCards[1].cardSuit;
    }

    // Shuffle the cards
    openCards.shuffle();

    // Distribute cards among players
    distributeCards();
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
    print('generatedCards = $generatedCards');

    return uniqueCards;
  }

  void cardonTop(PlayingCard card){
    String h = card.printCardInfo(card);
    print('CARD on top for player 1 = $h');
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

  void distributeCards() {
    int cardsPerPlayer = 13;
    player1 = openCards.sublist(0, cardsPerPlayer);
    player2 = openCards.sublist(cardsPerPlayer, cardsPerPlayer * 2);
    player3 = openCards.sublist(cardsPerPlayer * 2, cardsPerPlayer * 3);
    player4 = openCards.sublist(cardsPerPlayer * 3);
    // player2 =
    throwCards = [player1[0], player2[0], player3[0], player4[0]];
    print('player[0]=${player1[0]}');
    cardonTop(player1[0]);
    findSimilarSuitCard(player1, player2, player3, player4);

    printPlayerCards(player2, "Player 2");
    printPlayerCards(player3, "Player 3");
    printPlayerCards(player4, "Player 4");
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  void showCardComparisonDialog(String message, int playerIndex) {
    // Schedule the state update after the build method completes
    Future.delayed(Duration.zero, () {
      // Increment score based on player index
      switch (playerIndex) {
        case 0:
          setState(() {
            player1Score++; // Increment player 1's score
          });
          break;
        case 1:
          setState(() {
            player2Score++; // Increment player 2's score
          });
          break;
        case 2:
          setState(() {
            player3Score++; // Increment player 3's score
          });
          break;
        case 3:
          setState(() {
            player4Score++; // Increment player 4's score
          });
          break;
        default:
        // Handle invalid player index
          break;
      }

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



  void roundOne() {
    // Player 1 plays a card of their choice (You can implement UI to let the player select a card)
    PlayingCard selectedCard = throwCards[0];

    // Remove the selected card from Player 1's hand
    player1.remove(selectedCard);

    // Update throwCards with the card played by Player 1
    throwCards[0] = selectedCard;

    // Update the top card from each player's hand
    throwCards[1] = player2.isNotEmpty ? player2[0] : PlayingCard(cardSuit: CardSuit.spades, cardType: CardType.ace, faceUp: true, opened: true);
    throwCards[2] = player3.isNotEmpty ? player3[0] : PlayingCard(cardSuit: CardSuit.spades, cardType: CardType.ace, faceUp: true, opened: true);
    throwCards[3] = player4.isNotEmpty ? player4[0] : PlayingCard(cardSuit: CardSuit.spades, cardType: CardType.ace, faceUp: true, opened: true);

    // Call the game logic or any other necessary functions
    // Here you can call functions like biggerCard() or findSimilarSuitCard() as needed
    // For example:
    int? highestIndex = biggerCard(throwCards);
    if (highestIndex != null) {
      // Display the result in an AlertDialog
      showCardComparisonDialog('${throwCards[highestIndex].printCardInfo(throwCards[highestIndex])} is bigger', highestIndex);
    } else {
      // No card played yet, handle this case accordingly
    }

    // Update UI to reflect the changes
    setState(() {
      // Update throwCards with the selected card from Player 1 and top cards from other players
      throwCards[0] = selectedCard;
      throwCards[1] = player2.isNotEmpty ? player2[0] : throwCards[1];
      throwCards[2] = player3.isNotEmpty ? player3[0] : throwCards[2];
      throwCards[3] = player4.isNotEmpty ? player4[0] : throwCards[3];

      // Update the state for players 2, 3, and 4
      // This will trigger the UI update for their cards
      // Replace the empty lists with the actual card lists for players 2, 3, and 4
      updatePlayerCards(player2, player2);
      updatePlayerCards(player3, player3);
      updatePlayerCards(player4, player4);
    });
  }


  void currentSuitPlayed(CardSuit suit) {
    // Determine the index of the suit in the p2_s list
    int suitIndex = suit.index;

    // Get the sublist corresponding to the suit
    List<PlayingCard> suitSublist = p2_s[suitIndex];
    print('suitsublist = $suitSublist');

    // Check if the sublist is not empty
    if (suitSublist.isNotEmpty) {
      // Play the first card from the sublist
      PlayingCard playedCard = suitSublist.first;

      // Remove the played card from the sublist
      suitSublist.removeAt(0);

      // Update UI to reflect the played card
      // You need to implement UI update logic here
    }
  }



  @override
  Widget build(BuildContext context) {
    // Printing scores when the build method is called
    print('Player 1 Score: $player1Score');
    print('Player 2 Score: $player2Score');
    print('Player 3 Score: $player3Score');
    print('Player 4 Score: $player4Score');
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
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
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                print('Button pressed');
                playedround1 = true;
                print('played=$playedround1');

                // Get the selected card from Player 1's hand
                PlayingCard selectedCard = throwCards[0];

                // Remove the selected card from Player 1's hand
                player1.remove(throwCards[0]);

                // Update the top cards from each player's hand in throwCards
                // throwCards[1] = player2.isNotEmpty ? player2[0] : throwCards[1];
                // throwCards[2] = player3.isNotEmpty ? player3[0] : throwCards[2];
                // throwCards[3] = player4.isNotEmpty ? player4[0] : throwCards[3];
                // Update the top cards from each player's hand in throwCards with the highest card of the current suit
                // Update the top cards from each player's hand in throwCards with the highest card of the current suit
                throwCards[1] = player2[throwCards[0].cardSuit.index] != null && p2_s[throwCards[0].cardSuit.index].isNotEmpty ? p2_s[throwCards[0].cardSuit.index][0] : throwCards[1];
                throwCards[2] = player3[throwCards[0].cardSuit.index] != null && p3_s[throwCards[0].cardSuit.index].isNotEmpty ? p3_s[throwCards[0].cardSuit.index][0] : throwCards[2];
                throwCards[3] = player4[throwCards[0].cardSuit.index] != null && p4_s[throwCards[0].cardSuit.index].isNotEmpty ? p4_s[throwCards[0].cardSuit.index][0] : throwCards[3];

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
                if (highestIndex != null) {
                  // Display the result in an AlertDialog
                  setState(() {
                    showCardComparisonDialog('${throwCards[highestIndex].printCardInfo(throwCards[highestIndex])} is bigger', highestIndex);
                  });
                } else {
                  // No card played yet, handle this case accordingly
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
                    suitToEnable = throwCards[0].cardSuit;
                    if (tappedCard.cardSuit == suitToEnable) {
                      setState(() {
                        throwCards[0] = tappedCard;
                        int highestIndex = biggerCard(throwCards); // Call with only one argument
                        if (highestIndex >= 0) {
                          //showCardComparisonDialog('${throwCards[highestIndex].printCardInfo(throwCards[highestIndex])} is bigger');
                          currentSuitPlayed(tappedCard.cardSuit);
                        }
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
    );
  }

  // Function to update player's cards displayed on the UI
  void updatePlayerCards(List<PlayingCard> sourceCards, List<PlayingCard> targetPlayerCards) {
    // Iterate through each suit and update the corresponding card in the target player's cards
    for (int i = 0; i < sourceCards.length; i++) {
      // Update the card in the target player's cards
      targetPlayerCards[i] = sourceCards[i];
    }

    // Update the UI to reflect the changes
    setState(() {
      // No need to do anything here if the UI is properly bound to the player's cards
      // If UI widgets are properly bound to the targetPlayerCards list, Flutter will automatically update the UI
    });
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
}