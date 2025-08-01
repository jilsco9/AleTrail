# Improvements

Improvements that could be made on the existing app.

## Overview

This app was produced with a limited time frame, and thus some sacrifices to
functionality, scope, and implementation had to be made.

There are some API mechanics and limitations I discovered during development.
These would need to be worked around if there were continued development on
this app.

There are also a few improvements I want to explicitly call out that I considered
during development, as well as a few considerations & deliberate programmatic
choices I made during this rapid building.

## API Discoveries & Limitations

### Cut scope: Brewery Search vs Breweries by City
*BreweryServiceEndpoint/BreweryService*
I originally included a "search" endpoint for fetching Breweries by city, but really
the OpenBrewery API includes a true search endpoint, presumably
to search various properties. Ultimately, given more time, I would have liked to
include both "search" and "fetch by city" capabilities -- the city query item could be used
to show a tappable item on the brewery detail screen that allows the user
to view other breweries in the same city. Or, the app could display a list
of cities or allow for a city search, where tapping the city itself in the list brings
the user to a list of all breweries in
that city. In that way, "search" (../breweries/search?query=carmel...) would be distinct
from "by city" (../breweries?by_city=carmel...)

## Code Improvement Ideas

### Expand error definitions and error handling
*BreweryServiceError, NetworkingError, AleTrailNetworking - Whole App*
Implemented very limited error handling. Identifying valid response statuses would help
give more specific error information. I included a pretty broad "other" category for
NetworkingErrors in cases other than a URLError or DecodingError.
I also leveraged LocalizedError to allow the platform
to display the default alert, with an OK button. I would likely add more detailed error
handling, with a title, message, and even retry actions (depending on the specific error).

### Eliminate duplicate logic / repeated code

### Improve performance of brewery detail navigation
*BreweryList, BreweryDetail*
One of the last features I added was the brewery detail map.
This increased the time it takes to navigate from the brewery list to the
brewery detail screen. It would be nice to add some visual feedback (like a 
progress indicator) to communicate that the screen is transitioning and to
reduce the perceived delay in navigation. 

### HopStop
*HopStop*
I really wanted to name something "HopStop." Just because I think it would
be very cute to refer to a brewery as a "Hop Stop" along the "Ale Trail."

### Give attention to commit messages and content
*Source Control - Commits*
I made a decision before starting work on this project that I would not be spending due attention
to git/commit hygiene. Generally, I like to make my commits meaningful, with descriptive
commit messages and small, logical, focused groups of changes. However, given the time
constraint of this work, I knew sacrificing git organization would allow me to pursue other
capabilities I wanted to demonstrate.

### Add documentation
*Whole App*
Add more documentation in general. I added some DocC-style symbol
documentation, but many symbols are left undocumented. I'd also like to make 
this documenation catalogue more robust.
There are a number of symbols within this doc that could also be
explicitly attached via reference.

### Add and improve formatting
*BreweryContactView*
I would like to properly format phone numbers based on the
user's region/language settings. I would also like to have the
brewery's web URL open up the actual website  in browser
upon tapping. I added minimal formatting for address, but there is still
lots more that could be done.

### Expand upon testing - UI and unit
*Whole App*
One thing I did not set up was error testing -- creating the mock brewery 
service in such a way as to allow for returning an error. This could be 
accomplished simply by having a property that can be set within the test to 
define the return value or error. Alternatively, we could leverage a library
that allows us to set up more robust expectation capabilities within our mocks.
I could also expand testing to include snapshot testing.
I wanted to include testing of continued lazily loading brewery results in the 
Brewery list UI testing, but time was too short to accomplish this effectively.
For Unit testing, there are still some places to expand. The current unit tests are
larger than I'd generally like, and this indicates the methods themselves are likely
doing too much within the model. I'd also like to add more tests around string 
formatting.

### Add logging and analytics
I used a few debugPrint statements around the app, but a true logging library like
the native Logger would be ideal.
If desired, analytics could also be added via third party library to get some
insight into usage and potential issues.

### Build out localization
*Whole App*
I added very minimal localization -- just a string catalog with whatever
string literals the compiler found. I'd like to make sure everything is localized
fully.

### Streamline UI testing by Accessibility Identifier
*AleTrailUITests*
I could leverage our existing accessibility identifiers for the UI tests, i.e., 
either by creating a struct/enum with identifiers for each given screen or 
by simply adding the accessibility identifier files from the main app 
target to the UITest target as well. For now, though, I'm just going to use
string literals so as not to overdo dynamic string creation and instead create
very explicit expectations against which to test.

## Visual Improvements
### Improve launch screen appearance
*Launch Screen*
I used a variant of the AccentColor to enter a LaunchScreen background color in the
plist file. The plist isn't really an ideal way of customizing the LaunchScreen; 
if I were to continue to build out this app, I would either:
- continue to use the plist and add light/dark color variants and an image, or
- add a storyboard for the launch screen in order to have more control/customizatcapabilities

### Improve app icon
*App Icon*
I am certainly no designer. It's supposed to be two steins in front of a map...

### Add custom brewery type icons
*BreweryType*
I had to be fairly "creative" with SFSymbols to represent the brewery types. Custom
symbols/assets would be ideal.

## Added Feature Ideas
### Add visited Breweries feature
*Add VisitedIDs*
In addition to "FavoriteIDs" I thought it may be fun to have a similar set of
"VistedIDs", where the user could indicate whether they've been to a particular
brewery. That would also then be added to the BreweryListMode enum.
It may also be fun to have a "MyMap" feature, which would would show
a map with pins on all the breweries the user has marked as "visited".

### Add further endpoints for search, breweries by city, etc.
As mentioned in this doc, I ended up cutting out "Breweries by city" to focus
on making the existing initial features fully tested for accessibility,
performance, etc.

## Additional Considerations & Code Decisions

### Naming/Scope for primary data model
*AleTrailAppModel*
I don't love having an "AppModel" - a data aggregate model for the whole app,
but I think the app's scope is small enough in this case to not split it up further.
Ordinarily, I'd prefer a limited and logically distinct scope for a data aggregmodel,
which allows for thoughtful modularization of the app -- i.e., one where we can create
modular groupings of service(s)/aggregate model(s)/data model(s)/view(s)

### Folder/Naming/Organization Patterns
*Whole App*
I've been experimenting with various project organization patterns I've run across
recently. I like the idea of making a distinction between a "view" (basicallychild view
or reusable component view) and a "screen" (a parent view on the navigation stalike
"BreweryList" or "BreweryDetail"). Apple has somewhat moved away from the convention
of naming every view literally ending with View (e.g., BreweryListView), but I fit can
make things harder to identify when looking at the file structure. Thus, I think beginning
to lean toward identifying screens with "Screen" and child views with
"View" right there in the name. I digress...
For the actual project directory, I don't love breaking up the project into brstrokes
like "Models", "Networking", and "Views"... unless the scope is small enough. I think
this is a case where it makes sense not to get too granular. However, if tproject's
scope were larger, I might tend toward groupings that tend more toward the modularity
discussed above in "AleTrailAppModel - Naming/Scope". That's assuming the project
is too small to warrant making *actual* modules. I think project organization largely
goes by a "whatever makes sense" heuristic, unfortunately... and in this case,
with the size of this app, I think the Models/Networking/Views distinction is best route.
