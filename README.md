# CPM-IASOP
Overview
IASOP & CPM is an innovative solution designed to revolutionize drug distribution and accessibility. The project consists of two main components: the IASOP app and the Compact Pharmaceutical Machine (CPM). The IASOP app connects users to these machines, ensuring efficient drug distribution and access to medications in both urban and rural areas. The CPM is an automated medicine dispensing machine that works in conjunction with the IASOP app.

Note: The current code repository contains only the user interface developed using Flutter. The main features, including hardware integration, prescription recognition, and outbreak prediction, are still in development.

Table of Contents
Features
Project Components
Getting Started
Prerequisites
Installation
Usage
Technology Stack
Outbreak Prediction ML Model
Contributing
License
Contact
Features
User Interface: A clean, intuitive UI built using Flutter.
Upcoming Features:
Location-based tracking of nearby pharmacies.
Integration with Kore.ai for advanced chatbot functionality.
Automated medicine dispensing via the CPM machine.
Handwritten prescription recognition.
Real-time stock management and expiry tracking.
Outbreak prediction using machine learning models.
Project Components
1. IASOP App
A mobile application that connects users to CPMs, allowing them to find nearby pharmacies, check medicine availability, and receive notifications about stock levels and expiry dates.

Note: The current version of the IASOP app includes only the user interface developed using Flutter. The core functionalities and backend integrations are under development.

2. Compact Pharmaceutical Machine (CPM)
A hardware component designed to dispense medicines efficiently and accurately. It aims to replace traditional pharmacies and improve the supply chain.

Note: The CPM hardware is currently under development, and updates will be provided as progress is made.

3. Kore.ai Chatbot
While the chatbot is not yet integrated into the app, you can interact with it directly via this link https://bots.kore.ai/webclient/c3b886c920d74581bb371890c8148ebba99fa6ad4bfe4290bc6e54883fd772dbst32 . The chatbot is designed to assist with prescription inquiries, refills, and more.

Getting Started
Follow these instructions to set up the IASOP app on your local machine.

Prerequisites
Flutter SDK: Installation Guide
Firebase Account: Sign up here
Android Studio or Visual Studio Code
Kore.ai Account: Sign up here
Installation
Clone the Repository

bash
Copy code
git clone https://github.com/your-username/iasop-cpm.git
cd iasop-cpm
Set Up the Flutter Environment

Install the necessary Flutter dependencies:

bash
Copy code
flutter pub get
Configure Firebase

Follow the instructions to add Firebase to your Flutter app: Firebase Setup.

Usage
Run the App

Connect your mobile device or start an emulator, then run:

bash
Copy code
flutter run
Explore the User Interface

Navigate through the app to explore the UI components.
Please note that the core functionalities (e.g., medicine dispensing, prescription recognition) are not yet implemented.
Interact with the Chatbot

You can interact with our Kore.ai chatbot by visiting this link. The chatbot can provide assistance with prescription queries and other pharmacy-related services.

Technology Stack
Frontend: Flutter
Backend: Firebase (to be integrated)
AI and Chatbot: Kore.ai (to be integrated)
Machine Learning: TensorFlow Lite (for future prescription recognition and outbreak prediction)
Hardware: Compact Pharmaceutical Machine (CPM) (under development)
Outbreak Prediction ML Model
The Outbreak Prediction ML Model is an upcoming feature aimed at predicting potential disease outbreaks based on data analysis. The model uses machine learning algorithms to analyze patterns and trends in medical data, helping healthcare providers anticipate and respond to potential outbreaks more effectively.

Current Status: The model is in the development phase, and we are working on integrating it with the IASOP app. Once implemented, this feature will provide valuable insights into potential health risks, enabling proactive measures and efficient resource allocation.

Contributing
Contributions are welcome! Please follow these steps to contribute:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Open a Pull Request.
License
This project is currently in the prototype phase and does not have a specific license. Please contact the project owner for more details if you wish to use or contribute to this project.

Contact
For any questions or inquiries, please contact:

Name: [P Vishwa]
Email: [vishwa.fury@gmail.com]
LinkedIn: [https://www.linkedin.com/in/vishwa-pandiyan-465326290?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app]
