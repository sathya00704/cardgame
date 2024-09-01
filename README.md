Game Working & Explanation along with screenshots:
Home screen:
The home screen of the app is decorated with a background image and has 2 buttons: PLAY WITH COMPUTER & PLAY WITH FRIENDS
It has 5 other buttons - Win/loss, Report a Bug, Profile, Settings & Cart
![WhatsApp Image 2024-09-02 at 01 29 23_b16d7dd9](https://github.com/user-attachments/assets/0d06b679-3c47-4492-8221-6e1623e7be2e)

Win/loss button: (Star icon)
The basic idea of win/loss icon is being shown. It can be further implemented in real time when the backend Firebase is used. Currently, it displays the Win/Loss% & Total number of games played by the user. 
![WhatsApp Image 2024-09-02 at 01 29 23_73c71e38](https://github.com/user-attachments/assets/2e39a860-728c-4696-b35c-ead93f7351c6)

Report a Bug: 
Incase if the user finds a bug, they are given an opportunity to mail the problem to the given email id. In future, it can be directly linked to the company’s official website and complaint can be registered.
![WhatsApp Image 2024-09-02 at 01 30 36_e524e7a2](https://github.com/user-attachments/assets/37afd828-d123-4628-b774-ac44219cb006)


Profile:
A numeric username can be currently provided. It can be implemented along with Firebase for unique ID generations.
![WhatsApp Image 2024-09-02 at 01 30 35_159c3efe](https://github.com/user-attachments/assets/3e9058a3-29ca-44e8-9205-845b6356312f)


Settings:
It has 2 buttons and 2 links. The buttons are Sound and Notifications. The links can be added to the two Texts - “Privacy Policy” and “Terms and Conditions” once the app is ready to be launched.
![WhatsApp Image 2024-09-02 at 01 30 34_66770dd4](https://github.com/user-attachments/assets/eb9edf11-6b0f-4149-85cc-068f4a7393e8)


Cart and Play with Friends:
Since, it is a future plan, an image called as COMING SOON has been added on the app. Play with Friends requires internet connection while Play with Computer can be played without internet.
![WhatsApp Image 2024-09-02 at 01 30 33_f573509c](https://github.com/user-attachments/assets/b0505253-a046-4393-bf36-65cfada88534)

Initial game screen:
The user will be prompted to select a starting suit with which the user will be starting the game. By default,it will be SPADES. The user can choose any suit. The user’s first card will be from this suit.
![WhatsApp Image 2024-09-02 at 01 30 32_e0f474c1](https://github.com/user-attachments/assets/b86392dd-f99e-49d8-b2dc-ad7d30e9ee12)


Screen after the select starting suit prompt:
All the cards of player 1 (user) is displayed below and all the top 4 cards are cards selected by player 1,2,3 and 4 respectively. The screen is scrollable to fit every phone’s width accordingly.
![WhatsApp Image 2024-09-02 at 01 30 32_28f80f45](https://github.com/user-attachments/assets/aece7a9f-8981-4abc-8e52-8a11d5502a37)

Notification to user:
If the user selects some other suit other than what he selected during the dialog box (for first round alone), it will prompt the user to enter the correct suit. For other rounds,if the user selects someother suit other than what other players have played,it will prompt the user to play correct suit.
![WhatsApp Image 2024-09-02 at 01 29 25_836ef1e9](https://github.com/user-attachments/assets/c78d3ffc-b5e1-435c-8e81-8c16d3d835a8)


Round Winner:
The winner of each round is displayed and the highest card in the round is displayed. In the meantime, the highest player’s next card is updated in the background to the top 4 cards (if winner is not player 1). 
![WhatsApp Image 2024-09-02 at 01 30 31_7f987b09](https://github.com/user-attachments/assets/fe64703a-8f50-4142-96d6-fb6b77091758)


Round Winner:
This will be the screen when other players are winning the contest. After the dialog box disappears, the user will be able to select a card for the next round.
![WhatsApp Image 2024-09-02 at 01 30 30_1da84447](https://github.com/user-attachments/assets/f406351b-7485-4c51-b3ff-042f234f0f70)



Card selection:
When other players won the round, the user will be asked to select a card of the same suit as the shown card is of. The tap feature is diabled for other suits if the user has the current suit that is being played.
![WhatsApp Image 2024-09-02 at 01 29 26_f84cafd4](https://github.com/user-attachments/assets/00d3f32f-45f9-4f0b-89ab-1652da030cd8)


Prompting the user to select same suit card:
The current suit being played is hearts. If user selects any other suit when the current suit is available, it will prompt the user to enter correct suit.
![WhatsApp Image 2024-09-02 at 01 29 25_8e5329f4](https://github.com/user-attachments/assets/8b57de74-3939-48ec-bb53-8478f94b6951)


Winner announcement:
Once all the rounds are finished, the final Winner is announced using a dialog box with scores of each player. 
![WhatsApp Image 2024-09-02 at 01 29 24_f0c82b83](https://github.com/user-attachments/assets/03be664c-bac3-4e29-9ffe-50c0870f97d5)


The user can go back and start a new game again. 
