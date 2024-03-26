/*
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
  List<PlayingCard> throwCards = [];

  @override
  void initState() {
    super.initState();
    // Generate 13 unique open cards
    openCards = generateUniqueOpenCards();
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

  void gameLogic(PlayingCard card){
    String h = card.printCardInfo(card);
    print('CARD on top for player 1 = $h');
  }

  void enableonlySuit(PlayingCard card){
    String h = card.printCardInfo(card);
    print('CARD on top for player 1 = $h');
  }

  void findSimilarSuitCard(List<PlayingCard> player1, List<PlayingCard> player2, List<PlayingCard> player3, List<PlayingCard> player4) {
    List<List<PlayingCard>> p1_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p2_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p3_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p4_s = List.generate(4, (_) => []);


    for (PlayingCard card in player1) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p1_s[0].add(card);
          break;
        case CardSuit.hearts:
          p1_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p1_s[2].add(card);
          break;
        case CardSuit.clubs:
          p1_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player2) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p2_s[0].add(card);
          break;
        case CardSuit.hearts:
          p2_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p2_s[2].add(card);
          break;
        case CardSuit.clubs:
          p2_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player3) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p3_s[0].add(card);
          break;
        case CardSuit.hearts:
          p3_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p3_s[2].add(card);
          break;
        case CardSuit.clubs:
          p3_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player4) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p4_s[0].add(card);
          break;
        case CardSuit.hearts:
          p4_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p4_s[2].add(card);
          break;
        case CardSuit.clubs:
          p4_s[3].add(card);
          break;
      }
    }

    // Print the segregated cards for player 1
    print('Segregated cards for player 1:');
    for (int i = 0; i < p1_s.length; i++) {
      List<String> cardNames = p1_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 2:');
    for (int i = 0; i < p2_s.length; i++) {
      List<String> cardNames = p2_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 3:');
    for (int i = 0; i < p3_s.length; i++) {
      List<String> cardNames = p3_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 4:');
    for (int i = 0; i < p4_s.length; i++) {
      List<String> cardNames = p4_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    // Now you have segregated arrays for each player and each suit
    // You can use these arrays as needed
  }


  void distributeCards() {
    int cardsPerPlayer = 13;
    player1 = openCards.sublist(0, cardsPerPlayer);
    player2 = openCards.sublist(cardsPerPlayer, cardsPerPlayer * 2);
    player3 = openCards.sublist(cardsPerPlayer * 2, cardsPerPlayer * 3);
    player4 = openCards.sublist(cardsPerPlayer * 3);
    throwCards = [player1[0], player2[0], player3[0], player4[0]];
    print('player[0]=${player1[0]}');
    gameLogic(player1[0]);
    findSimilarSuitCard(player1, player2, player3, player4);

    printPlayerCards(player2, "Player 2");
    printPlayerCards(player3, "Player 3");
    printPlayerCards(player4, "Player 4");
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                    setState(() {
                      throwCards[0] = tappedCard;
                    });
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

        ],
      ),
    );
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
  List<PlayingCard> throwCards = [];

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

  void gameLogic(PlayingCard card){
    String h = card.printCardInfo(card);
    print('CARD on top for player 1 = $h');
  }

  void biggerCard(PlayingCard card1, PlayingCard card2, PlayingCard card3, PlayingCard card4) {
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

    // Get the priority of each card type
    int priority1 = priorityOrder[card1.cardType] ?? 0;
    int priority2 = priorityOrder[card2.cardType] ?? 0;
    int priority3 = priorityOrder[card3.cardType] ?? 0;
    int priority4 = priorityOrder[card4.cardType] ?? 0;

    // Compare the priorities
    if (priority1 > priority2 && priority1 > priority3 && priority1 > priority4) {
      print('${card1.printCardInfo(card1)} is bigger');
    } else if (priority2 > priority1 && priority2 > priority3 && priority2 > priority4) {
      print('${card2.printCardInfo(card2)} is bigger');
    } else if (priority3 > priority1 && priority3 > priority2 && priority3 > priority4) {
      print('${card3.printCardInfo(card3)} is bigger');
    } else if (priority4 > priority1 && priority4 > priority2 && priority4 > priority3) {
      print('${card4.printCardInfo(card4)} is bigger');
    } else {
      print('Both cards have the same priority');
    }
  }


  void findSimilarSuitCard(List<PlayingCard> player1, List<PlayingCard> player2, List<PlayingCard> player3, List<PlayingCard> player4) {
    List<List<PlayingCard>> p1_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p2_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p3_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p4_s = List.generate(4, (_) => []);


    for (PlayingCard card in player1) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p1_s[0].add(card);
          break;
        case CardSuit.hearts:
          p1_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p1_s[2].add(card);
          break;
        case CardSuit.clubs:
          p1_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player2) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p2_s[0].add(card);
          break;
        case CardSuit.hearts:
          p2_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p2_s[2].add(card);
          break;
        case CardSuit.clubs:
          p2_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player3) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p3_s[0].add(card);
          break;
        case CardSuit.hearts:
          p3_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p3_s[2].add(card);
          break;
        case CardSuit.clubs:
          p3_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player4) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p4_s[0].add(card);
          break;
        case CardSuit.hearts:
          p4_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p4_s[2].add(card);
          break;
        case CardSuit.clubs:
          p4_s[3].add(card);
          break;
      }
    }

    // Print the segregated cards for player 1
    print('Segregated cards for player 1:');
    for (int i = 0; i < p1_s.length; i++) {
      List<String> cardNames = p1_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 2:');
    for (int i = 0; i < p2_s.length; i++) {
      List<String> cardNames = p2_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 3:');
    for (int i = 0; i < p3_s.length; i++) {
      List<String> cardNames = p3_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 4:');
    for (int i = 0; i < p4_s.length; i++) {
      List<String> cardNames = p4_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    // Now you have segregated arrays for each player and each suit
    // You can use these arrays as needed
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
    gameLogic(player1[0]);
    findSimilarSuitCard(player1, player2, player3, player4);

    printPlayerCards(player2, "Player 2");
    printPlayerCards(player3, "Player 3");
    printPlayerCards(player4, "Player 4");
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  @override
  Widget build(BuildContext context) {
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
                        biggerCard(throwCards[0],throwCards[1],throwCards[2],throwCards[3]);
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
  List<PlayingCard> throwCards = [];

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

  void gameLogic(PlayingCard card){
    String h = card.printCardInfo(card);
    print('CARD on top for player 1 = $h');
  }

  void biggerCard(PlayingCard card1, PlayingCard card2, PlayingCard card3, PlayingCard card4) {
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

    // Get the priority of each card type
    int priority1 = priorityOrder[card1.cardType] ?? 0;
    int priority2 = priorityOrder[card2.cardType] ?? 0;
    int priority3 = priorityOrder[card3.cardType] ?? 0;
    int priority4 = priorityOrder[card4.cardType] ?? 0;

    // Compare the priorities
    if (priority1 > priority2 && priority1 > priority3 && priority1 > priority4) {
      print('${card1.printCardInfo(card1)} is bigger');
    } else if (priority2 > priority1 && priority2 > priority3 && priority2 > priority4) {
      print('${card2.printCardInfo(card2)} is bigger');
    } else if (priority3 > priority1 && priority3 > priority2 && priority3 > priority4) {
      print('${card3.printCardInfo(card3)} is bigger');
    } else if (priority4 > priority1 && priority4 > priority2 && priority4 > priority3) {
      print('${card4.printCardInfo(card4)} is bigger');
    } else {
      print('Both cards have the same priority');
    }
  }


  void findSimilarSuitCard(List<PlayingCard> player1, List<PlayingCard> player2, List<PlayingCard> player3, List<PlayingCard> player4) {
    List<List<PlayingCard>> p1_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p2_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p3_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p4_s = List.generate(4, (_) => []);


    for (PlayingCard card in player1) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p1_s[0].add(card);
          break;
        case CardSuit.hearts:
          p1_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p1_s[2].add(card);
          break;
        case CardSuit.clubs:
          p1_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player2) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p2_s[0].add(card);
          break;
        case CardSuit.hearts:
          p2_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p2_s[2].add(card);
          break;
        case CardSuit.clubs:
          p2_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player3) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p3_s[0].add(card);
          break;
        case CardSuit.hearts:
          p3_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p3_s[2].add(card);
          break;
        case CardSuit.clubs:
          p3_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player4) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p4_s[0].add(card);
          break;
        case CardSuit.hearts:
          p4_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p4_s[2].add(card);
          break;
        case CardSuit.clubs:
          p4_s[3].add(card);
          break;
      }
    }

    // Print the segregated cards for player 1
    print('Segregated cards for player 1:');
    for (int i = 0; i < p1_s.length; i++) {
      List<String> cardNames = p1_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 2:');
    for (int i = 0; i < p2_s.length; i++) {
      List<String> cardNames = p2_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 3:');
    for (int i = 0; i < p3_s.length; i++) {
      List<String> cardNames = p3_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 4:');
    for (int i = 0; i < p4_s.length; i++) {
      List<String> cardNames = p4_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    // Now you have segregated arrays for each player and each suit
    // You can use these arrays as needed
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
    gameLogic(player1[0]);
    findSimilarSuitCard(player1, player2, player3, player4);

    printPlayerCards(player2, "Player 2");
    printPlayerCards(player3, "Player 3");
    printPlayerCards(player4, "Player 4");
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0, right: 8.0), // Adjust right padding as needed
              child: TextButton(
                onPressed: () {
                  print('Button pressed');
                  // Add your logic for the tick button here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  // shape: MaterialStateProperty.all(
                  //   RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  // ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4), // Adjust spacing between icon and text
                    Text(
                      'PASS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16, // Adjust font size as needed
                      ),
                    ),
                  ],
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
                    setState(() {
                      throwCards[0] = tappedCard;
                    });
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



          // Add the tick button below the player's cards
          /*Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                // Add your logic for the tick button here
              },
            ),
          ),*/
        ],
      ),
    );
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
 */

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
  List<PlayingCard> throwCards = [];

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

  void gameLogic(PlayingCard card){
    String h = card.printCardInfo(card);
    print('CARD on top for player 1 = $h');
  }

  void biggerCard(PlayingCard card1, PlayingCard card2, PlayingCard card3, PlayingCard card4) {
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

    // Get the priority of each card type
    int priority1 = priorityOrder[card1.cardType] ?? 0;
    int priority2 = priorityOrder[card2.cardType] ?? 0;
    int priority3 = priorityOrder[card3.cardType] ?? 0;
    int priority4 = priorityOrder[card4.cardType] ?? 0;

    // Compare the priorities
    if (priority1 > priority2 && priority1 > priority3 && priority1 > priority4) {
      print('${card1.printCardInfo(card1)} is bigger');
    } else if (priority2 > priority1 && priority2 > priority3 && priority2 > priority4) {
      print('${card2.printCardInfo(card2)} is bigger');
    } else if (priority3 > priority1 && priority3 > priority2 && priority3 > priority4) {
      print('${card3.printCardInfo(card3)} is bigger');
    } else if (priority4 > priority1 && priority4 > priority2 && priority4 > priority3) {
      print('${card4.printCardInfo(card4)} is bigger');
    } else {
      print('Both cards have the same priority');
    }
  }


  void findSimilarSuitCard(List<PlayingCard> player1, List<PlayingCard> player2, List<PlayingCard> player3, List<PlayingCard> player4) {
    List<List<PlayingCard>> p1_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p2_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p3_s = List.generate(4, (_) => []);
    List<List<PlayingCard>> p4_s = List.generate(4, (_) => []);


    for (PlayingCard card in player1) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p1_s[0].add(card);
          break;
        case CardSuit.hearts:
          p1_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p1_s[2].add(card);
          break;
        case CardSuit.clubs:
          p1_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player2) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p2_s[0].add(card);
          break;
        case CardSuit.hearts:
          p2_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p2_s[2].add(card);
          break;
        case CardSuit.clubs:
          p2_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player3) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p3_s[0].add(card);
          break;
        case CardSuit.hearts:
          p3_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p3_s[2].add(card);
          break;
        case CardSuit.clubs:
          p3_s[3].add(card);
          break;
      }
    }

    for (PlayingCard card in player4) {
      switch (card.cardSuit) {
        case CardSuit.spades:
          p4_s[0].add(card);
          break;
        case CardSuit.hearts:
          p4_s[1].add(card);
          break;
        case CardSuit.diamonds:
          p4_s[2].add(card);
          break;
        case CardSuit.clubs:
          p4_s[3].add(card);
          break;
      }
    }

    // Print the segregated cards for player 1
    print('Segregated cards for player 1:');
    for (int i = 0; i < p1_s.length; i++) {
      List<String> cardNames = p1_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 2:');
    for (int i = 0; i < p2_s.length; i++) {
      List<String> cardNames = p2_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 3:');
    for (int i = 0; i < p3_s.length; i++) {
      List<String> cardNames = p3_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    print('Segregated cards for player 4:');
    for (int i = 0; i < p4_s.length; i++) {
      List<String> cardNames = p4_s[i].map((card) => '${card.cardType} of ${card.cardSuit}').toList();
      print("Suit ${i + 1}: $cardNames");
    }

    // Now you have segregated arrays for each player and each suit
    // You can use these arrays as needed
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
    gameLogic(player1[0]);
    findSimilarSuitCard(player1, player2, player3, player4);

    printPlayerCards(player2, "Player 2");
    printPlayerCards(player3, "Player 3");
    printPlayerCards(player4, "Player 4");
  }

  void printPlayerCards(List<PlayingCard> cards, String playerName) {
    List<String> cardNames = cards.map((card) => '${card.cardType} of ${card.cardSuit}').toList();
    print("$playerName: $cardNames");
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0, right: 8.0), // Adjust right padding as needed
              child: TextButton(
                onPressed: () {
                  print('Button pressed');
                  // Add your logic for the tick button here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  // shape: MaterialStateProperty.all(
                  //   RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  // ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4), // Adjust spacing between icon and text
                    Text(
                      'PASS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16, // Adjust font size as needed
                      ),
                    ),
                  ],
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
                        biggerCard(throwCards[0],throwCards[1],throwCards[2],throwCards[3]);
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