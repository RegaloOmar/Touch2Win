# Touch2Win 👆



**A simple and fun game to decide who pays the bill or who takes out the trash! "Touch 2 Win" is a small iOS app where the last finger left on the screen after a countdown, wins.**

This project was developed as part of my portfolio to demonstrate my skills in iOS development, including Swift, UIKit, MVVM architecture, and best coding practices.

---

## 📸 Screenshots

| Initial Screen | In-Game | Winner Screen |
| :---: | :---: | :---: |
| ![Initial screen](URL_TO_YOUR_SCREENSHOT_1.png) | ![In-Game screen](URL_TO_YOUR_SCREENSHOT_2.png) | ![Winner screen](URL_TO_YOUR_SCREENSHOT_3.png) |

*(Tip: Record a short GIF of the game in action and add it here. GIFs are very effective at showcasing the app's dynamics.)*

---

## ✨ Features

* **Multi-Touch Detection:** Detects two or more fingers on the screen to start the game.
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

Developed by [Your Name] - Let's connect!

* **Portfolio:** https://www.youtube.com/watch?v=p53M6uSUG4A
* **LinkedIn:** https://www.linkedin.com/help/linkedin/answer/a564064/your-linkedin-profile?lang=en
* **GitHub:** [@your-username](https://github.com/your-username)
