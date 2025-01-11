# Infinite List with Flutter BloC

## Description
This project demonstrates an implementation of an infinite scrolling list using Flutter and the BloC (Business Logic Component) architecture. It uses data fetched from the [JSONPlaceholder](https://jsonplaceholder.typicode.com) API to dynamically load posts as the user scrolls.

## Features
- **Infinite Scrolling**: Loads more data dynamically as the user reaches the bottom of the list.
- **BloC Architecture**: Manages state using the BloC pattern for better scalability and testability.
- **REST API Integration**: Fetches data from a remote API.
- **Error Handling**: Displays error messages when data fetching fails.
- **Loading Indicators**: Shows progress indicators when data is being loaded.

## Technology Stack
- **Flutter**: UI framework for building the application.
- **BloC**: State management library for managing the application's state.
- **HTTP**: For fetching data from the REST API.

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd infinite_list
   ```
3. Install the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Folder Structure
```
.
├── lib
│   ├── bloc
│   │   ├── post_bloc.dart     # Bloc for managing post events and states
│   │   └── post_event.dart    # Event definitions for the PostBloc
│   │   └── post_state.dart    # State definitions for the PostBloc
│   ├── model
│   │   └── post.dart          # Post model with API connection logic
│   ├── ui
│   │   ├── main_page.dart     # Main UI with infinite scrolling list
│   │   └── post_item.dart     # UI for rendering individual posts
│   └── main.dart              # Application entry point
├── pubspec.yaml                # Project dependencies
└── README.md                   # Project description and instructions
```

## How It Works
1. The `PostBloc` listens for events and manages the state of the posts.
   - **PostEvent** triggers the fetching of new posts.
   - **PostState** holds the current state of the post list and loading status.
2. The `Post` model fetches data from the API and converts it into Dart objects.
3. The `MainPage` UI listens to the state changes from `PostBloc` and updates the list accordingly.
4. A `ScrollController` detects when the user scrolls to the bottom and triggers the loading of additional posts.

## API Endpoint
The project uses the following API endpoint from JSONPlaceholder:
```
https://jsonplaceholder.typicode.com/posts
```
Query Parameters:
- `_start`: The starting index for fetching posts.
- `_limit`: The number of posts to fetch.

Example:
```
https://jsonplaceholder.typicode.com/posts?_start=0&_limit=10
```

## Screenshots
1. **Initial State**:
   Displays a loading indicator while the first batch of posts is fetched.
2. **Loaded State**:
   Shows a list of posts loaded from the API.
3. **End of List**:
   Displays a message or indicator when no more data is available.
4. **Error State**:
   Shows an error message if the API call fails.

## Contributing
Feel free to contribute to this project by submitting pull requests or reporting issues.

## License
This project is open source and available under the [MIT License](LICENSE).

---

Thank you for exploring this project! If you have any questions or suggestions, feel free to reach out.

