# Touch2Win 👆

![T2W_icon](https://github.com/user-attachments/assets/f860dbd9-e537-4541-b151-aa34a0c53555)


**A simple and fun game to decide who pays the bill or who takes out the trash! "Touch 2 Win" is a small iOS app where the last finger left on the screen after a countdown, wins.**

This project was developed as part of my portfolio to demonstrate my skills in iOS development, including Swift, UIKit, MVVM architecture, and best coding practices.

---

## 📸 Screenshots

| Initial Screen | In-Game | Winner Screen |
| :---: | :---: | :---: |
| ![IMG_1183](https://github.com/user-attachments/assets/de46cee3-ab6c-45ec-aae0-1f8e5f2781a8) | ![IMG_1181](https://github.com/user-attachments/assets/0239ecde-ba47-4413-8f97-64faecf6d9e9) | ![IMG_1182](https://github.com/user-attachments/assets/687e4ac2-205a-4fe3-ba37-130d127a6c05)|
 
 ---

## ✨ Features

* **Multi-Touch Detection:** Detects two to five fingers on the screen to start the game.
* **Random Winner Selection:** A 3-second timer randomly selects a winner from the fingers remaining on the screen.
* **Dynamic Color Backgrounds:** The interface uses randomly generated background colors for a fresh visual experience in every round.
* **Fluid Animations:** Clean transitions and animations using `CoreAnimation` to reveal the winner.
* **Haptic Feedback:** Uses the Taptic Engine to provide tactile feedback at key moments in the game.
* **Clean Architecture:** Structured with the **MVVM** pattern and the use of **Protocols/Delegates** for a clear separation of responsibilities.
* **Test Coverage:** Includes **Unit Tests** for the game logic and **UI Tests** to validate the interface flow.

---

## 🏛️ Architecture

The project is implemented following the **MVVM (Model-View-ViewModel)** design pattern.

* **Model:** The game state is implicit within the ViewModel, but in a larger app, it would be extracted into its own data structures.
* **View:** The `ViewController` is solely responsible for presenting the UI and delegating user interactions to the ViewModel.
* **ViewModel:** The `GameViewModel` contains all the presentation logic and game state. It has no knowledge of UIKit.
* **Communication:** Communication from the ViewModel to the View is handled through the **Delegate** pattern, using a protocol (`GameViewModelDelegate`) for complete decoupling.

This approach ensures the code is **maintainable, scalable, and easy to test**.

---

## 🚀 How to Build and Run

To build and run the project, you will need:

* macOS
* Xcode 14 or later
* Swift 5.7 or later

**Steps:**

1.  Clone the repository:
    ```bash
    git clone [https://github.com/your-username/touch-2-win.git](https://github.com/your-username/touch-2-win.git)
    ```
2.  Open the `.xcodeproj` file in Xcode.
3.  Select a simulator or a physical device.
4.  Press `Cmd + R` to build and run the application.

---

## 📞 Contact

Developed by Omar Regalado (Regy) - Let's connect!

* **Email:** regaladomendozaomar@gmail.com
* **LinkedIn:** [https://www.linkedin.com/help/linkedin/answer/a564064/your-linkedin-profile?lang=en](https://www.linkedin.com/in/omar-regalado/)
* **GitHub:** [@RegaloOmar]([https://github.com/your-username](https://github.com/RegaloOmar))
