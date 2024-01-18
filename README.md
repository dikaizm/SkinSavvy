# SkinSavvy App

## Team
InnoFours

### Member
- Ariq Heritsa Maalik (Hipster)
- Adrian Putra Pratama Badjideh (Hacker)
- Izzulhaq Mahardika (Hacker)
- Nadya Khairani (Hustler)

## About the App
This application combines artificial intelligence technology with dermatological knowledge to provide personalized skincare product solutions based on the individual needs of each user's skin.

## Tech Stack
- ⁠Golang: A general-purpose programming language used to develop the backend of the Skinsavvy app.
- ⁠onnx: A runtime for serving machine learning models. It allows the Skinsavvy app to serve its machine learning model for detecting skin problems.
- ⁠YOLO: A convolutional neural network (CNN) model training framework used to train the machine learning model for detecting skin problems.
- ⁠Fiber: A backend framework used for the server side of the Skinsavvy app.
- ⁠Firebase: A NoSQL database used to store data for the Skinsavvy app.
- ⁠Google Cloud Platform (Cloud Storage): A cloud storage service used to store images of skincare products and human faces for the Skinsavvy app.
- Google OAUTH: An authentication service used by the Skinsavvy app to allow users to sign in using their Google accounts.
- ⁠Gemini: A Google MultiModal LLM used to generate skincare product recommendations and skincare routines for the Skinsavvy app.
- ⁠Github: A version control system used to store the source code for the Skinsavvy app.
- ⁠Postman: An API documentation and testing tool used to document and test the API endpoints of the Skinsavvy app.
- Flutter: A Google UI software development toolkit that support cross-platform build.

## App Interface
### Login Screen
<img width="346" alt="image" src="https://github.com/dikaizm/SkinSavvy/assets/40682104/a06da230-3fd7-4647-810a-110a1ceb203a">

### Onboarding Screen
<img width="345" alt="image" src="https://github.com/dikaizm/SkinSavvy/assets/40682104/a09ad056-3afe-4af4-afaf-2886d0247011">

### Capture Face Screen
<img width="347" alt="Screen Shot 2024-01-12 at 22 24 20" src="https://github.com/dikaizm/SkinSavvy/assets/40682104/ee62fa89-8fdb-451c-9682-27a2162d2b66">

### Skin Analysis Result
<img width="346" alt="Screen Shot 2024-01-12 at 22 24 47" src="https://github.com/dikaizm/SkinSavvy/assets/40682104/fb8633e2-e689-4c46-a922-b3861fe36e92">

### Skincare Recommendation
<img width="344" alt="Screen Shot 2024-01-12 at 22 28 55" src="https://github.com/dikaizm/SkinSavvy/assets/40682104/9cba49cc-3b56-454a-8112-c6f42c0f7800">


# Documentation
## Clone This Repository

Download or clone this repo by using the link below:

```
https://github.com/dikaizm/SkinSavvy.git
```

## Backend
### Installation Guides

* Install Go 

    [Go Installation Link Here!](https://go.dev/doc/install)

* Go to backend directory

```
cd backend
```

* Add Value To ".env.example" File >> Change ".env.example" To ".env"
    You Must Add Value onto:
    1. Host
    2. Port 
    3. Firebase Project ID
    4. Gemini API Key
    5. Firebase Service Account Key (must be a json file and the path is on root directory)
    6. Google Oauth Credentials (Client ID, Client Secret, Redirect Urls)

* Run The Application With Your Terminal

    ```
    go run main.go
    ``` 

#### Project Support Features

Users can get recommendation about skincare that suitable for their skin problem.

### API Documentation

* User: [Click here for API documentation!](https://documenter.getpostman.com/view/25551317/2s9YsJDDW3)

### Technologies Used
* Golang - Backend Language
* onnx - Runtime for model serving
* Fiber - Backend Framework
* Firebase - firestore as database
* Google OAUTH - Authentication using google account
* Google Cloud Platform (Cloud Storage) - blob storage
* Gemini - Google MultiModal LLM
* Github - Version Control
* Postman - API Documentation


## Frontend
### Project Structure
This flutter sourcecode consists of 3 main folder:
1. `core`,
2. `presentation`,
3. `services`.

#### Core
This folder contains the core of the application. It holds the most basic and important part of the application like theming or helpers.

#### Presentation
This folder is the face of the application. It holds the UI layer of the application. Presentation folder is responsible for handling the UI flow of the application and contains the views and its UI components.

#### Services
This folder contains business logic, API calls, data handling, and other functionalities that are not directly related to UI or core application logic.


### Installation Guide

* Install Flutter
  
Install Flutter and its prerequisites. [Go to official Flutter docs.](https://docs.flutter.dev/get-started/install)

* Go to frontend directory

```
cd frontend
```

* Add Value To ".env.example" File >> Change ".env.example" To ".env"
    You Must Add Value onto:
    1. Server Address
    2. Google Oauth Credentials (Client ID, Client Secret)

* Execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

* Run using your IDE
