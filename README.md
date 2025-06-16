Certainly! Below is the **clean, text-only version** focusing **only on the authentication flow** for your `README.md`:

---

## 🛠 OpsMate Authentication Data Flow & Dependency Summary

### Presentation Layer

- `LoginPage (UI)`
- `SignupPage (UI)`
- `AuthForm Widget (Form)`
- `GoogleSignInButton (Button)`

### BLoC Layer

- `AuthBloc (State Management)`
- `AuthEvent (Events)`
- `AuthState (States)`

### Domain Layer

- `LoginUseCase`
- `RegisterUseCase`
- `GoogleSignInUseCase`
- `LogoutUseCase`
- `CheckAuthStatusUseCase`
- `AuthRepository (Interface)`

### Data Layer

- `AuthRepositoryImpl`
- `AuthRemoteDataSource (Firebase)`
- `AuthLocalDataSource (Hive/Cache)`

### External Services

- `Firebase Auth`
- `Google Sign-In API`
- `Hive Local DB`

### Dependency Injection

- `GetIt (DI Container)`

---

## 🔄 Authentication Data Flow

- `LoginPage` and `SignupPage` use `AuthForm` for user input.
- `LoginPage` also provides a `GoogleSignInButton` for OAuth login.
- `AuthForm` dispatches:

  - `LoginEvent` (email/password login)
  - `RegisterEvent` (account creation)

- `GoogleSignInButton` dispatches:

  - `GoogleSignInEvent`

- `AuthBloc` listens to events and:

  - Calls appropriate use cases (`LoginUseCase`, `RegisterUseCase`, `GoogleSignInUseCase`, `LogoutUseCase`, `CheckAuthStatusUseCase`)
  - Emits `AuthState` updates (`loading`, `authenticated`, `unauthenticated`, `error`)

- Use cases interact with `AuthRepository`.
- `AuthRepositoryImpl` coordinates:

  - `AuthRemoteDataSource` → communicates with `Firebase Auth`, `Google Sign-In API`
  - `AuthLocalDataSource` → caches data in `Hive`

- Results propagate back:

  - `AuthBloc` updates `AuthState`
  - UI reacts (e.g., navigation on success, error display on failure)

---

## ⚙ Dependency Injection via GetIt

- `GetIt` provides:

  - `AuthBloc`
  - All use cases (`LoginUseCase`, `RegisterUseCase`, `GoogleSignInUseCase`, `LogoutUseCase`, `CheckAuthStatusUseCase`)
  - `AuthRepositoryImpl`
  - `AuthRemoteDataSource`
  - `AuthLocalDataSource`

---

✅ **This structure is GitHub-friendly for README.md — no diagram rendering required.**

If you want, I can also help:

- Add folder/file structure
- Write setup or usage instructions
- Document API references

Let me know your preference!
