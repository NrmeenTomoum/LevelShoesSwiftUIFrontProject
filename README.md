#Demo of the Task


Uploading demo.mov…


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
### Home Screen Products Grid in 16 pro max
<img width="481" alt="Screenshot 2025-05-08 at 8 30 32 AM" src="https://github.com/user-attachments/assets/1527daca-6f17-465c-bb7a-482fffd6e148" />

### Home Screen Products Grid in 16 
<img width="504" alt="Screenshot 2025-05-07 at 8 54 12 PM" src="https://github.com/user-attachments/assets/60f75820-1e32-4f6e-894f-cd0bf0dc5c72" />



### WishList Screen List of wishList product 
<img width="501" alt="Screenshot 2025-05-07 at 8 55 25 PM" src="https://github.com/user-attachments/assets/4b5931bd-29f3-4aab-ac31-415f3f909834" />


### Loading screen Screen

<img width="484" alt="Screenshot 2025-05-07 at 2 57 09 PM" src="https://github.com/user-attachments/assets/a858bbe3-50d7-43c1-bca7-a9f8c12d3706" />

### Error Handling Screen

<img width="468" alt="Screenshot 2025-05-07 at 2 55 58 PM" src="https://github.com/user-attachments/assets/fb71d242-b617-407f-84ed-9c882a5058bb" />
