# NuDiet

This attempts to implement a recipe app utilising the https://dummyjson.com/docs/recipes for an iOS app showing recipes in a grid. This was built on a partial knowledge of TCA architecture so a few items are missing implementation. i.e appropriate unit testing, filter by rating and difficulty, search functionality and accessibility at minimum.

The decision here was to first implement fetching recipes appropriately using pagination. 

Ideal: To use swiftdata along side TCA to improvement architecture further i.e. allow for quick look up of recipes based on filters and tags (with the caveat given whether or not user had reached the end of the recipes in total, some search operations would result in partial results, given server provides only 50 recipes at the moment, pagination can be skipped to a later date and we instead fetch all recipes at once, save to swiftdata and use predicates for filter operations).

| Home | Filter (Binding not implemented)|
| --- | --- |
|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 09 40 49](https://github.com/user-attachments/assets/a4986807-1e8a-45b8-8900-e8e803c1acda)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 09 40 52](https://github.com/user-attachments/assets/bfee3613-496a-45f6-9427-6ed0aab992b3)|
