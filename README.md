# OpsMate Authentication Flow Diagram

```mermaid
graph TD
    %% UI Layer
    subgraph "Presentation Layer"
        LoginPage["LoginPage\n(UI)"]
        SignupPage["SignupPage\n(UI)"]
        AuthForm["AuthForm Widget\n(Form UI)"]
        GoogleSignInButton["GoogleSignInButton\n(UI)"]
    end

    %% BLoC Layer
    subgraph "BLoC Layer"
        AuthBloc["AuthBloc\n(Business Logic)"]
        AuthEvent["AuthEvent\n(User Actions)"]
        AuthState["AuthState\n(UI State)"]
    end

    %% Domain Layer
    subgraph "Domain Layer"
        LoginUseCase["LoginUseCase"]
        RegisterUseCase["RegisterUseCase"]
        LogoutUseCase["LogoutUseCase"]
        GoogleSignInUseCase["GoogleSignInUseCase"]
        CheckAuthStatusUseCase["CheckAuthStatusUseCase"]
        AuthRepository["AuthRepository\n(Interface)"]
    end

    %% Data Layer
    subgraph "Data Layer"
        AuthRepositoryImpl["AuthRepositoryImpl"]
        AuthRemoteDataSource["AuthRemoteDataSource\n(Firebase)"]
        AuthLocalDataSource["AuthLocalDataSource\n(Cache)"]
    end

    %% External Services
    subgraph "External Services"
        FirebaseAuth["Firebase Auth"]
        GoogleSignIn["Google Sign-In API"]
    end

    %% Dependency Injection
    DI["Dependency Injection\n(GetIt)"]

    %% Flow Connections
    LoginPage --> AuthForm
    SignupPage --> AuthForm
    AuthForm -- "1. User enters credentials" --> AuthForm
    AuthForm -- "2. Dispatches LoginEvent/RegisterEvent" --> AuthEvent
    GoogleSignInButton -- "Dispatches GoogleSignInEvent" --> AuthEvent

    AuthEvent -- "3. Triggers handler in" --> AuthBloc
    AuthBloc -- "4. Updates" --> AuthState
    AuthState -- "5. UI reacts to state changes" --> LoginPage
    AuthState --> SignupPage
    AuthState --> AuthForm

    AuthBloc -- "6. Calls" --> LoginUseCase
    AuthBloc --> RegisterUseCase
    AuthBloc --> LogoutUseCase
    AuthBloc --> GoogleSignInUseCase
    AuthBloc --> CheckAuthStatusUseCase

    LoginUseCase -- "7. Calls" --> AuthRepository
    RegisterUseCase --> AuthRepository
    LogoutUseCase --> AuthRepository
    GoogleSignInUseCase --> AuthRepository
    CheckAuthStatusUseCase --> AuthRepository

    AuthRepository -- "8. Implemented by" --> AuthRepositoryImpl

    AuthRepositoryImpl -- "9. Uses" --> AuthRemoteDataSource
    AuthRepositoryImpl -- AuthLocalDataSource

    AuthRemoteDataSource -- "10. Interacts with" --> FirebaseAuth
    AuthRemoteDataSource --> GoogleSignIn

    DI -- "Provides dependencies" --> AuthBloc
    DI --> LoginUseCase
    DI --> RegisterUseCase
    DI --> LogoutUseCase
    DI --> GoogleSignInUseCase
    DI --> CheckAuthStatusUseCase
    DI --> AuthRepositoryImpl
    DI --> AuthRemoteDataSource
    DI --> AuthLocalDataSource
```

## Authentication Flow Explanation

### 1. User Interaction (Presentation Layer)

- User enters email/password in `AuthForm` or clicks `GoogleSignInButton`
- Form validation occurs
- On submit, the appropriate event is dispatched:
  - `LoginEvent` (email, password)
  - `RegisterEvent` (name, email, password)
  - `GoogleSignInEvent`

### 2. BLoC Layer (Business Logic)

- `AuthBloc` receives the event
- Appropriate event handler is triggered:
  - `_onLogin` for `LoginEvent`
  - `_onRegister` for `RegisterEvent`
  - `_onGoogleSignIn` for `GoogleSignInEvent`
- BLoC emits `AuthState.loading` state

### 3. Domain Layer (Use Cases)

- BLoC calls the appropriate use case:
  - `LoginUseCase.call(LoginParams)`
  - `RegisterUseCase.call(RegisterParams)`
  - `GoogleSignInUseCase.call(NoParams)`
- Use cases encapsulate business logic and call repository methods

### 4. Repository Layer (Domain/Data Bridge)

- Use cases call methods on `AuthRepository` interface
- `AuthRepositoryImpl` implements the interface
- Repository coordinates between remote and local data sources

### 5. Data Layer (Data Sources)

- `AuthRemoteDataSource` handles Firebase Auth operations
- `AuthLocalDataSource` handles local caching of user data
- Data sources return model objects that are mapped to domain entities

### 6. External Services

- Firebase Auth handles actual authentication
- Google Sign-In API handles OAuth authentication

### 7. Response Flow (Back to UI)

- Data flows back up the layers
- BLoC emits new state:
  - `AuthState.authenticated` with user data on success
  - `AuthState.unauthenticated` with error message on failure
- UI reacts to state changes:
  - Navigate to tasks page on success
  - Show error message on failure

### 8. Dependency Injection

- GetIt provides dependencies to all layers
- Ensures proper separation of concerns
- Facilitates testing by allowing mock implementations
