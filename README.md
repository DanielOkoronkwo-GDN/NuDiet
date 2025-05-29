## NuDiet iOS App (Based on [DummyJSON](https://dummyjson.com/docs/recipes))

### Architecture:
- [Swift Composible Architecture](https://github.com/pointfreeco/swift-composable-architecture) 

### SPM Packages: 
- Kingfisher for UI image caching and handling
- Switch Composable architecture
- ClientDomain (Local): Includes dummyclient service integration and TCA layer

### Improvements:
More test coverage, Snapshot testing (Prefire is a good choice), enhanced accessibility.
### Future enhancements

**SwiftData Integration:** To enhance the architecture and user experience, integrating SwiftData alongside The Composable Architecture (TCA) would be more ideal as currently saved in memory. This approach enables efficient local filtering and lookup of recipes based on user-defined criteria such as tags and other filters.

Note: As not all recipes may be retrieved initially, certain filter combinations may yield partial results until the complete dataset is available.

| Home | Filter| Detail |
| --- | --- | --- |
|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 09 40 49](https://github.com/user-attachments/assets/a4986807-1e8a-45b8-8900-e8e803c1acda)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 09 40 52](https://github.com/user-attachments/assets/bfee3613-496a-45f6-9427-6ed0aab992b3)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 14 16 17](https://github.com/user-attachments/assets/f5d4b8f8-bea1-4f0d-be13-9319259ff4bb)|
