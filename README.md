# COS Tech Challenge

A COS code challenge application.

## Tasks
- [x] User Identification
- [x] VIN search with error handling
- [x] Intermediate State processing (showing similar vehicles)
- [x] Data caching on successful VIN search
- [x] Navigation and UX/UI to show search result with feedback

---

## Application Flow

1. **Startup (AppHomeView)**
    - Displays a view based on the authentication status in `AuthCubit`.
    - If a previously logged-in user exists (with "Remember Me" checked), the app navigates directly to the `VinSearchView`.
    - Otherwise, the user is taken to the `LoginView` (which includes fields for email and password).

2. **VinSearchView**
    - A simple view with:
        - An input field for VIN
        - A search button
        - Error presentation area
        - A logout button
    - **On Successful VIN Search**: Navigates to `AuctionView`.
    - **On Error Code 300**: Navigates to `SimilarResultsView`, which displays a list of similar vehicles ordered by their `similarity` property (ordering handled in `VinSearchRepositoryImpl`).
    - **On Other Errors**: Shows `VinSearchError` with an error title and a helpful message.

3. **SimilarResultsView**
    - Displays a list of vehicles similar to the searched VIN.
    - Each item in the list has a `similarity` property used for sorting.

4. **AuctionView**
    - Displays the result of a successful VIN search (details about the vehicle).

5. **LoginView**
    - Allows user to enter email and password.
    - Includes a "Remember Me" checkbox to save credentials for future sessions.

---

## Technologies, Approaches, and Libraries

- **Flutter 3.24.5**
- **Architecture**: Clean Architecture (data, domain, and presentation layers) with a feature-first structure
- **State Management**: BLoC (Cubit)
- **Local Storage**: `flutter_secure_storage` package
- **Networking**: `http` package
