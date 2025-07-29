//
//  Improvements.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/27/25.
//

import Foundation

// TODO: - Move this file out... add notes to readme.
///
/// *AleTrailAppModel/BreweryService*
/// I discovered something problematic in my final round of testing -- the API has a limit on how
/// many IDs can be searched at one time. This means that once that limit is hit by adding favorite
/// breweries, the app will always show an alert on fetching favorite breweries. The user could
/// theoretically work around this error only by deleting the app (and/or its data) or by
/// navigating to the "all breweries" list and removing some favorites via the details screens.
/// The solution to this API limitation would be to implement
/// custom "pagination" for the favorite IDs, in which only the max number of favorites are fetched from
/// the service at one time.
///
/// *Settings - Offline model persistence*
/// Currently only storing favorite model IDs.
/// Depending on how we want the app to work, we could alternatively store
/// an entire Brewery model. I opted for IDs only, to ensure we're getting fresh
/// data from the server at each load.
///
/// *Settings - Naming/Scope*
/// The "Settings" model may be more of a catch-all than I'd prefer.
/// I knew I wanted to hold onto favoriteIDs without the need for a separate
/// API call (especially given that there's no "User" API or concept of
/// an account in this app). I also decided that rather than always showing
/// the ".all" mode of the BreweryList every time the app is opened, I wanted to
/// just show whatever the most recent BreweryListDisplayMode the user had
/// been employing. A single model seemed sufficient for persisting these two
/// pieces of data. Thus, simply "Settings".
///
/// *BreweryServiceEndpoint/BreweryService - Search and ByCity*
/// I originally included a "search" endpoint for fetching Breweries by city, but really
/// the OpenBrewery API includes a true search endpoint, presumably
/// to search various properties. Ultimately, given more time, I would have liked to
/// include both "search" and "fetch by city" capabilities -- the city query item could be used
/// to show a tappable item on the brewery detail screen that allows the user
/// to view other breweries in the same city. Or, the app could display a list
/// of cities or allow for a city search, where tapping the city itself in the list brings
/// the user to a list of all breweries in
/// that city. In that way, "search" (../breweries/search?query=carmel...) would be distinct
/// from "by city" (../breweries?by_city=carmel...)
///
/// *VisitedIDs - Additional Feature*
/// In addition to "FavoriteIDs" I thought it may be fun to have a similar set of
/// "VistedIDs", where the user could indicate whether they've been to a particular
/// brewery. That would also then be added to the BreweryListMode enum.
///
/// *Map - Additional Feature*
/// It would be fun to show a map on the BreweryDetail screen. For a first pass
/// this could show only on breweries with an included latitude/longitude, but it could
/// also expand to use a street address, if provided.
/// It may also be fun to have a "MyMap" feature, accessible from the
/// .visited BreweryListMode mentioned above in "VisitedIDs". This would show
/// a map with pins on all the breweries the user has marked as "visited".
///
/// *HopStop - Naming*
/// I really wanted to name something "HopStop." Just because I think it would
/// be very cute to refer to a brewery as a "Hop Stop" along the "Ale Trail."
///
/// *BreweryList - Handling display state cases*
/// It might be worthwhile to add a SettingsError, even if just for logging purposes.
/// We are using the settings model to store and read the list display mode.
/// This should only ever be one of the values from the BreweryListDisplayMode enum.
/// We can handle this unexpected case by simply re-setting the display mode to
/// one of our expected values; however, we may eventually want to let ourselves know
/// that this unexpected value is manifesting somehow.
///
/// *AleTrailAppModel - Naming/Scope*
/// I don't love having an "AppModel" - a data aggregate model for the whole app,
/// but I think the app's scope is small enough in this case to not split it up further.
/// Ordinarily, I'd prefer a limited and logically distinct scope for a data aggregate model,
/// which allows for thoughtful modularization of the app -- i.e., one where we can create
/// modular groupings of service(s)/aggregate model(s)/data model(s)/view(s)
///
/// *Whole App - Folder/Naming/Organization Patterns*
/// I've been experimenting with various project organization patterns I've run across
/// recently. I like the idea of making a distinction between a "view" (basically, a child view
/// or reusable component view) and a "screen" (a parent view on the navigation stack, like
/// "BreweryList" or "BreweryDetail"). Apple has somewhat moved away from the convention
/// of naming every view literally ending with View (e.g., BreweryListView), but I find it can
/// make things harder to identify when looking at the file structure. Thus, I think I'm beginning
/// to lean toward identifying screens with "Screen" and child views with
/// "View" right there in the name. I digress...
/// For the actual project directory, I don't love breaking up the project into broad strokes
/// like "Models", "Networking", and "Views"... unless the scope is small enough. I think
/// this is a case where it makes sense not to get too granular. However, if this project's
/// scope were larger, I might tend toward groupings that tend more toward the modularity
/// discussed above in "AleTrailAppModel - Naming/Scope". That's assuming the project
/// is too small to warrant making *actual* modules. I think project organization largely
/// goes by a "whatever makes sense" heuristic, unfortunately... and in this case,
/// with the size of this app, I think the Models/Networking/Views distinction is the best route.
///
/// *BreweryServiceError, NetworkingError, AleTrailNetworking - Whole App - Error Definition and Handling*
/// Implemented very limited error handling. Identifying valid response statuses would help
/// give more specific error information. I included a pretty broad "other" category for
/// NetworkingErrors in cases other than a URLError or DecodingError.
/// I also leveraged LocalizedError to allow the platform
/// to display the default alert, with an OK button. I would likely add more detailed error
/// handling, with a title, message, and even retry actions (depending on the specific error).
///
/// *AleTrailAppModel - Code Repetition*
/// Some lines of code are unnecessarily repeated in the three networking calls. Ideally
/// these can be extracted into their own function. I got caught up on naming, as taking
/// the code as it is now, the method would have to prepare the model to fetch as well as
/// return a Boolean determining whether the fetch should actually happen (i.e., if
/// allBreweriesHaveBeenLoaded, we should not proceed with the attempted fetch). I like
/// to have self-documenting method names so avoid unexpected side-effects, and
/// "prepareForLoadingAndReturnShouldLoadingOccur" seems excessive and hints at
/// too many responsibilities. So for now: I'm leaving the duplicate lines. With more time,
/// I'd have a more elegant means of sharing a method that performs the model prep.
///
/// *BreweryServiceEndpoint - Naming*
/// One endpoint is called "favorite", but it's not necessarily just for favorites. Perhaps to be more
/// consistent with the data aggregate model and the brewery service, this should just be an ids
/// endpoint. Or maybe this should simply be a struct shared by all three of the current "endpoints".
/// See Considerations -> BreweryServiceEndpoint
///
/// *Source Control - Commits*
/// I made a decision before starting work on this project that I would not be spending due attention
/// to git/commit hygiene. Generally, I like to make my commits meaningful, with descriptive
/// commit messages and small, logical, focused groups of changes. However, given the time
/// constraint of this work, I knew sacrificing git organization would allow me to pursue other
/// capabilities I wanted to demonstrate.
///
/// *Whole App - Documentation*
/// I would love to include a DocC library to document more of the app. I love documentation.
/// I included some minimal symbol documentation in the code, but with no time limitations,
/// I could expand that further.
///
/// *BreweryContactView - Formatting/Localization*
/// I would like to properly format phone numbers based on the
/// user's region/language settings. I would also like to have the
/// brewery's web URL open up the actual website  in browser
/// upon tapping.
///
/// *Whole App - Testing*
/// One thing I did not set up was error testing -- creating the mock brewery service in such a
/// way as to allow for returning an error. This could be accomplished simply by having a property
/// that can be set within the test to define the return value or error. Alternatively, we could
/// leverage a library that allows us to set up more robust expectation capabilities
/// within our mocks.
/// I could also expand testing to include snapshot testing.
/// I wanted to include lazy loading in my testing, but time was too short to
/// do this effectively.
///
/// *Whole App - Localization*
///
/// *Whole App - Accessibility*
///
/// *Launch Screen - Appearance*
/// I used a variant of the AccentColor to enter a LaunchScreen background color in the
/// plist file. The plist isn't really an ideal way of customizing the LaunchScreen; if I were to
/// continue to build out this app, I would either:
/// - continue to use the plist and add light/dark color variants and an image, or
/// - add a storyboard for the launch screen in order to have more control/customization capabilities
///
/// *App Icon - Appearance*
/// I am certainly no designer. It's supposed to be two steins in front of a map...
///
/// *BreweryType - Icons*
/// I had to be fairly "creative" with SFSymbols to represent the brewery types. Custom
/// symbols/assets would be ideal.
///
/// *View+AccessibilityModifier - Modifers*
/// Rather than having empty accessibilityLabels and accessibilityHints when none is defined,
/// I'd like to make an OptionalModifier to simply leave those modifications off entirely.
///
/// *AleTrailUITests - Identifiers*
/// I could leverage our existing accessibility identifiers for the UI tests, i.e., either by creating
/// a struct/enum with identifiers for each given screen or by simply adding the accessibility identifier
/// files from the main app target to the UITest target as well. For now, though, I'm just going to use
/// string literals so as not to overdo dynamic string creation and instead create very explicit expectations
/// against which to test.
///
///
/// CONSIDERATIONS
///
/// *BreweryServiceEndpoint*
/// AleTrailAppModel, BreweryService, and BreweryServiceEndpoint treat the three available calls
/// (getBreweriesByID, getBreweries, and getBreweriesByCity) as if they are, indeed, *separate*.
/// However, they are not necessarily distinct endpoints. We could just as easily have a single endpoint
/// that takes in optional values representing query items. However, reducing these into a single endpoint
/// and single function on the service side limits our ability to effectively communicate what each
/// method is doing. I prefered to treat them as separate functions for ease of use, and because
/// another given API could format the endpoint(s) differently.
///
/// *ContentView, BreweryList - Toolbar*
/// Initially, I really wanted to use the native TabView component, mostly just because I like
/// the way it looks with LiquidGlass. It also comes with built-in selection state. However,
/// as I began building it, it became clear that structuring the architecture with separate
/// list views (to occupy the Tabs) did not make much sense, as the lists are all based on
/// a brewery array. It made more sense to just update the brewery array and allow the list to
/// update in response. Unfortunately, the only way to leverage the TabView selection
/// component with that architecture would have been to create "invisible" tab view content
/// on the screen. It felt a little too hacky, and depending on how it's implemented, it could have
/// negative impacts on the screen's accessibility (e.g., on screen reader). In short: I decided
/// to just use a toolbar with a little stylizing. I think it is a fitting choice anyway, as
/// a toolbar is the recommended component in the Human Interface Guidelines when a button will perform
/// some action (i.e., fetch new data) rather than display a distinct view.
///
/// *BreweryDetail - Adding Favorite*
/// Adding a brewery to favorites was a little flaky, so I had to add the model
/// context to Brewery detail so that I could pass it to the Settings methods.
/// This allowed me to explicitly call "modelContext.save". It might be worth adding
/// some error handling in the future in case of failure.
