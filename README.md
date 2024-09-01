Game Working & Explanation along with screenshots:
Home screen:
The home screen of the app is decorated with a background image and has 2 buttons: PLAY WITH COMPUTER & PLAY WITH FRIENDS
It has 5 other buttons - Win/loss, Report a Bug, Profile, Settings & Cart
![WhatsApp Image 2024-09-02 at 01 29 23_b16d7dd9](https://github.com/user-attachments/assets/0d06b679-3c47-4492-8221-6e1623e7be2e)










Win/loss button: (Star icon)
The basic idea of win/loss icon is being shown. It can be further implemented in real time when the backend Firebase is used. Currently, it displays the Win/Loss% & Total number of games played by the user. 

Report a Bug: 
Incase if the user finds a bug, they are given an opportunity to mail the problem to the given email id. In future, it can be directly linked to the company’s official website and complaint can be registered.


Profile:
A numeric username can be currently provided. It can be implemented along with Firebase for unique ID generations.


Settings:
It has 2 buttons and 2 links. The buttons are Sound and Notifications. The links can be added to the two Texts - “Privacy Policy” and “Terms and Conditions” once the app is ready to be launched.

Cart and Play with Friends:
Since, it is a future plan, an image called as COMING SOON has been added on the app. Play with Friends requires internet connection while Play with Computer can be played without internet.

Initial game screen:
The user will be prompted to select a starting suit with which the user will be starting the game. By default,it will be SPADES. The user can choose any suit. The user’s first card will be from this suit.


Screen after the select starting suit prompt:
All the cards of player 1 (user) is displayed below and all the top 4 cards are cards selected by player 1,2,3 and 4 respectively. The screen is scrollable to fit every phone’s width accordingly.

Notification to user:
If the user selects some other suit other than what he selected during the dialog box (for first round alone), it will prompt the user to enter the correct suit. For other rounds,if the user selects someother suit other than what other players have played,it will prompt the user to play correct suit.

Round Winner:
The winner of each round is displayed and the highest card in the round is displayed. In the meantime, the highest player’s next card is updated in the background to the top 4 cards (if winner is not player 1). 

Round Winner:
This will be the screen when other players are winning the contest. After the dialog box disappears, the user will be able to select a card for the next round.


Card selection:
When other players won the round, the user will be asked to select a card of the same suit as the shown card is of. The tap feature is diabled for other suits if the user has the current suit that is being played.

Prompting the user to select same suit card:
The current suit being played is hearts. If user selects any other suit when the current suit is available, it will prompt the user to enter correct suit.


Winner announcement:
Once all the rounds are finished, the final Winner is announced using a dialog box with scores of each player. 


The user can go back and start a new game again. 
