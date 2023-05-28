
Photo Search app 

Design Pattern: 
MVVM: Helps cleanly separate presentation from business logic.

Frameworks:
No third party frameworks are used.
SwiftUI is used for UI side.
Combine is used to trigger search from search bar.

Description:
The app consists of two pages. List page and Detail page. List view is used twice to show photos on homepage and to show photos of specific user. Home list page shows recent photos or searched photos if search applied. User is able to search for photos from list home page based on all or tag criteria (username search coming soon). Detail page shows more details about the photo. Other list page(when clicked on user or user icon from home page) shows list of photos from specific user. View models are applied to models and pageViews to separate logic between them. Search is triggered evry second afer user stops writing in seearch bar Business logic is tested in Unit tests. Mocks are used to test async network calls and to stub network response.
