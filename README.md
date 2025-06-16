Certainly! Below is your **clean text-only version** of the diagram for inclusion in your `README.md`. It describes the data flow and relationships clearly in **text format**, no graph rendering, so it will display properly on GitHub:

---

## 🛠 OpsMate Data Flow & Dependency Summary

### Presentation Layer

- `LoginPage (UI)`
- `SignupPage (UI)`
- `DashboardPage (UI)`
- `AuthForm Widget (Form)`
- `GoogleSignInButton (Button)`

### BLoC Layer

- `AuthBloc (State Management)`
- `TaskBloc (State Management)`
- `AuthEvent (Events)`
- `AuthState (States)`
- `TaskEvent (Events)`
- `TaskState (States)`

### Domain Layer

- `LoginUseCase`
- `RegisterUseCase`
- `GoogleSignInUseCase`
- `LogoutUseCase`
- `CheckAuthStatusUseCase`
- `FetchTasksUseCase`
- `AuthRepository (Interface)`
- `TaskRepository (Interface)`

### Data Layer

- `AuthRepositoryImpl`
- `TaskRepositoryImpl`
- `AuthRemoteDataSource (Firebase)`
- `AuthLocalDataSource (Hive/Cache)`
- `TaskRemoteDataSource (Firebase/REST)`
- `TaskLocalDataSource (Hive/Cache)`

### External Services

- `Firebase Auth`
- `Google Sign-In API`
- `Cloud Firestore`
- `Hive Local DB`

### Dependency Injection

- `GetIt (DI Container)`

---

## 🔄 Data Flow

- `LoginPage` → `AuthForm`

- `SignupPage` → `AuthForm`

- `LoginPage` → `GoogleSignInButton`

- `AuthForm` dispatches `LoginEvent` / `RegisterEvent` → `AuthBloc`

- `GoogleSignInButton` dispatches `GoogleSignInEvent` → `AuthBloc`

- `AuthBloc` processes events → triggers use cases (`LoginUseCase`, `RegisterUseCase`, `GoogleSignInUseCase`, `LogoutUseCase`, `CheckAuthStatusUseCase`)

- Use cases call `AuthRepository`

- `AuthRepositoryImpl` uses `AuthRemoteDataSource` + `AuthLocalDataSource`

- `AuthRemoteDataSource` interacts with `Firebase Auth` and `Google Sign-In API`

- `AuthLocalDataSource` interacts with `Hive`

- `AuthBloc` updates `AuthState` → UI reacts (`LoginPage`, `SignupPage`, `DashboardPage`)

- `DashboardPage` triggers `FetchTasksEvent` → `TaskBloc`

- `TaskBloc` processes event → triggers `FetchTasksUseCase`

- `FetchTasksUseCase` calls `TaskRepository`

- `TaskRepositoryImpl` uses `TaskRemoteDataSource` + `TaskLocalDataSource`

- `TaskRemoteDataSource` interacts with `Cloud Firestore`

- `TaskLocalDataSource` interacts with `Hive`

- `TaskBloc` updates `TaskState` → UI updates `DashboardPage`

- All components get their dependencies from `GetIt (DI Container)`

---

## ⚙ Example of Dependency Injection via GetIt

- `GetIt` provides:

  - `AuthBloc`, `TaskBloc`
  - All use cases (e.g. `LoginUseCase`, `FetchTasksUseCase`)
  - Repository implementations
  - Data sources

---

✅ **This text structure is suitable for GitHub README.md** — it will display correctly without requiring Mermaid or diagram rendering.

If you'd like, I can help:

- Generate a folder/file structure section
- Add installation/setup instructions
- Write testing strategies

Let me know!
