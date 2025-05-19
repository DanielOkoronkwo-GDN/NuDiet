# NuDiet

## Architectural Enhancement: SwiftData + TCA Integration
To enhance the architecture and user experience, we propose integrating SwiftData alongside The Composable Architecture (TCA). This approach enables efficient local filtering and lookup of recipes based on user-defined criteria such as tags and other filters.

Currently, the server provides a maximum of 50 recipes per response. To simplify the initial implementation, pagination will be deferred. Instead, all available recipes will be fetched in a single request and persisted locally using SwiftData. This allows us to leverage SwiftData’s predicate-based querying for fast, offline-capable filtering.

Note: As not all recipes may be retrieved initially, certain filter combinations may yield partial results until the complete dataset is available.

| Home | Filter (Binding not implemented)|
| --- | --- |
|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 09 40 49](https://github.com/user-attachments/assets/a4986807-1e8a-45b8-8900-e8e803c1acda)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 09 40 52](https://github.com/user-attachments/assets/bfee3613-496a-45f6-9427-6ed0aab992b3)|
