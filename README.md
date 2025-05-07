
# Clean Architecture for SwiftUI + Combine
Using Lastest technology which is SwiftUI and combine MVVM Archetecture 

## Architecture overview

### Presentation Layer

**SwiftUI views** that contain no business logic and are a function of the state.

Side effects are triggered by the user's actions (such as a tap on a button) or view lifecycle event `onAppear` and are forwarded to the `ViewModels`.

State and business logic layer (`AppState` + `ViewModels`) are natively injected into the view hierarchy with `@Environment`.

### Business Logic Layer

Business Logic Layer is represented by `ViewModels`. 

###  Data Access Layer

Data Access Layer is represented by `Repositories` .
Repositories provide asynchronous API (Publisher from Combine) for making CRUD operations on the backend or a local database. They don't contain business logic, neither do they mutate the AppState. Repositories are accessible and used only by the ViewModels .

### Home Screen Products Grid

<img width="478" alt="Screenshot 2025-05-07 at 1 48 31 PM" src="https://github.com/user-attachments/assets/e8bae4e8-b015-4760-b874-7941081084d0" />


### WishList Screen List of wishList product 

<img width="463" alt="Screenshot 2025-05-07 at 1 56 19 PM" src="https://github.com/user-attachments/assets/7ffb2e7f-209b-42e2-9b24-89b3b69161f0" />

