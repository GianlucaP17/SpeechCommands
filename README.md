# Mobile Voice Recognition App

Welcome to the Mobile Voice Recognition App, a take-home challenge for mobile developers! This app is designed to showcase my skills in building a mobile application that can use voice recognition commands and transform them into data displayed on the screen and to a json file to upload to a Back end! This README will guide you through the key features and requirements of this challenge.

## Goal

The primary goal of this challenge is to create a mobile app that can recognize voice commands and convert them into structured data. The app  have the following features:

- **Voice Command Recognition:** The app is be able to listen for voice commands spoken by the user.

- **Command Structure:** The recognized voice commands follow a specific structure. Each command start with a keyword, followed by parameters.

- **Data Output:** After recognizing a command, the app extract data from it and display it on the screen. Each command will have an associated input description and an output value, structured as follows:

  ```
  { "command": "name", "value": "output" }
  ```

- **State Management:** The app have two states: "waiting for command" and "listening to the current command." It transition between these states based on user input.

## Features

### 1. Voice Command Recognition

- The app  listen for voice commands from the user when button Start is tapped.

### 2. Command Structure

- Voice commands follow a specific structure, typically starting with a keyword, e.g., "Code," followed by parameters and data.

### 3. Data Output

- The app extract relevant data from recognized commands and display it on the screen using the structured format mentioned above.

### 4. State Management

- The app maintain two states:
  - **Waiting for Command:** The initial state where the app is actively listening for a command.
  - **Listening to Current Command:** The state activated when a command keyword is detected, allowing the app to capture the associated data.

### 5. Error Handling

- If a recognized command does not follow the required structure or cannot be validated, a popup notification inform the user of the issue.

## Getting Started

To get started with this take-home challenge, follow these steps:

1. Clone or download this repository to your development environment.

2. Download xcode and open the project

3. Set up your mobile development environment with the necessary tools and dependencies for the platform you are targeting (e.g., iOS, Android).

4. acceot any necessary permissions.

5. Start testing the app and have fun talking while coding

## Conclusion

I you enjoy working on this Mobile Voice Recognition App challenge. This project is an excellent opportunity to showcase my mobile development skills, especially in the areas of voice recognition, state management, and user interface design. Good luck, and happy speak coding!
