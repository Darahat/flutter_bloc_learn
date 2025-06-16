graph TD
%% Presentation Layer
subgraph "Presentation Layer"
LoginPageUI["LoginPage (UI)"]
SignupPageUI["SignupPage (UI)"]
DashboardPageUI["DashboardPage (UI)"]
AuthFormUI["AuthForm Widget (Form)"]
GoogleSignInButtonUI["GoogleSignInButton (Button)"]
end

    %% BLoC Layer
    subgraph "BLoC Layer"
        AuthBloc["AuthBloc (State Management)"]
        TaskBloc["TaskBloc (State Management)"]
        AuthEvent["AuthEvent (Events)"]
        AuthState["AuthState (States)"]
        TaskEvent["TaskEvent (Events)"]
        TaskState["TaskState (States)"]
    end

    %% Domain Layer
    subgraph "Domain Layer"
        LoginUC["LoginUseCase"]
        RegisterUC["RegisterUseCase"]
        GoogleSignInUC["GoogleSignInUseCase"]
        LogoutUC["LogoutUseCase"]
        CheckAuthStatusUC["CheckAuthStatusUseCase"]
        FetchTasksUC["FetchTasksUseCase"]
        AuthRepo["AuthRepository (Interface)"]
        TaskRepo["TaskRepository (Interface)"]
    end

    %% Data Layer
    subgraph "Data Layer"
        AuthRepoImpl["AuthRepositoryImpl"]
        TaskRepoImpl["TaskRepositoryImpl"]
        AuthRemoteDS["AuthRemoteDataSource (Firebase)"]
        AuthLocalDS["AuthLocalDataSource (Hive/Cache)"]
        TaskRemoteDS["TaskRemoteDataSource (Firebase/REST)"]
        TaskLocalDS["TaskLocalDataSource (Hive/Cache)"]
    end

    %% External Services
    subgraph "External Services"
        FirebaseAuth["Firebase Auth"]
        GoogleAPI["Google Sign-In API"]
        Firestore["Cloud Firestore"]
        Hive["Hive Local DB"]
    end

    %% Dependency Injection
    DI["GetIt (DI Container)"]

    %% Flow
    LoginPageUI --> AuthFormUI
    SignupPageUI --> AuthFormUI
    LoginPageUI --> GoogleSignInButtonUI
    AuthFormUI -->|Dispatch Login/Register| AuthEvent
    GoogleSignInButtonUI -->|Dispatch GoogleSignIn| AuthEvent

    AuthEvent --> AuthBloc
    AuthBloc --> AuthState
    AuthState --> LoginPageUI
    AuthState --> SignupPageUI
    AuthState --> DashboardPageUI

    AuthBloc --> LoginUC
    AuthBloc --> RegisterUC
    AuthBloc --> GoogleSignInUC
    AuthBloc --> LogoutUC
    AuthBloc --> CheckAuthStatusUC

    LoginUC --> AuthRepo
    RegisterUC --> AuthRepo
    GoogleSignInUC --> AuthRepo
    LogoutUC --> AuthRepo
    CheckAuthStatusUC --> AuthRepo

    AuthRepo --> AuthRepoImpl
    AuthRepoImpl --> AuthRemoteDS
    AuthRepoImpl --> AuthLocalDS
    AuthRemoteDS --> FirebaseAuth
    AuthRemoteDS --> GoogleAPI
    AuthLocalDS --> Hive

    DashboardPageUI -->|Triggers FetchTasksEvent| TaskEvent
    TaskEvent --> TaskBloc
    TaskBloc --> FetchTasksUC
    FetchTasksUC --> TaskRepo
    TaskRepo --> TaskRepoImpl
    TaskRepoImpl --> TaskRemoteDS
    TaskRepoImpl --> TaskLocalDS
    TaskRemoteDS --> Firestore
    TaskLocalDS --> Hive
    TaskBloc --> TaskState
    TaskState --> DashboardPageUI

    DI --> AuthBloc
    DI --> TaskBloc
    DI --> LoginUC
    DI --> RegisterUC
    DI --> GoogleSignInUC
    DI --> LogoutUC
    DI --> CheckAuthStatusUC
    DI --> FetchTasksUC
    DI --> AuthRepoImpl
    DI --> TaskRepoImpl
    DI --> AuthRemoteDS
    DI --> AuthLocalDS
    DI --> TaskRemoteDS
    DI --> TaskLocalDS
