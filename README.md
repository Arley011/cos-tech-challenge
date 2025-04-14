# COS Tech Challenge

## A COS code challenge application.

Tasks:
[x] User Identification
[x] VIN search with error handling
[x] Intermediate State processing with showing similar vehicles
[x] Data caching on successful VIN search
[x] Navigation and UX/UI to shown search result with feedback

The application starts on the AppHomeView, that displays the view depending on authentication status in AuthCubit.
If there was a previously logged in user (checked Remember Me checkbox on login), the VinSearchView will be shown.
If not, the LoginView will be shown with email and password fields.

VinSearchView is a simple view with an input field, a search button, errors presentation and ability to logout.
If VIN search was successful, navigates to AuctionView.
If VIN search returned error code 300, navigates to SimilarResultsView with list of similar results ordered by `similarity` property (ordering happens in VinSearchRepositoryImpl).
If VIN search fails, VinSearchError is shown with error title and a message to help resolve the problem.

## Used technologies, approaches, and libraries
- Flutter 3.24.5
- Architecture: Clean Architecture (data, domain, presentation layers) with feature-first structure
- State Management: BLoC (Cubit)
- Local storage: flutter_secure_storage package
- Network: http package

