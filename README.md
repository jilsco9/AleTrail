# AleTrail

AleTrail lets users view breweries and save them to favorites.

## Overview

AleTrail gives users information on breweries around the world.

It is built with Xcode 26 and targets iOS 26. It leverages modern Swift development
paradigms like Swift Testing, SwiftData, String catalog, Documentation catalog, and
Swift structured concurrency.

To run the app, ensure you have the latest Xcode 26 beta. Clone this repo, and run.

AleTrail uses the OpenBrewery API, which does not require an API key.

## Project Details

### Requirements
- iOS 26+
- Xcode 26+

### Resources
- [OpenBrewery API](https://www.openbrewerydb.org/documentation#list-breweries)

### Using the App

AleTrail uses the OpenBrewery API to show brewery information.
When the app is first installed and launched, the user will see the first items
of a list of all breweries in its database.

The bottom navigation bar has two primary navigation buttons, representing two
list states: all breweries, and favorite breweries.

As the user scrolls the all breweries list, the app will continue to fetch the 
next set of items from the API.

If a user taps one of the breweries in the list, the app presents a brewery detail
screen with information like the brewery's name, brewery type, location, and
contact information.

This brewery detail screen also has a button to allow the user to add a brewery
to their favorites list. If they navigate back to the previous screen,
and tap the favorites list navigation button, they will see the list of breweries
they have favorited from brewery detail.

If the user closes and relaunches the app, they will find that they see whichever
list (all or favorites) that they were currently viewing. They will also find
that their favorites list persists.

### Architecture

AleTrail aims to adopt Apple's current preferred architecture paradigm.
Sometimes described in the Swift community as ModelView (MV), this pattern leans 
into using environment objects and the declarative nature of SwiftUI to establish
a straightforward means of updating data, testing logic, and separating responsibilities.

An MV architecture relies on data models to perform logical functions if appropriate.
Alternatively, it can rely upon data aggregate models to perform logical functions
where multiple data models interact or where API calls are involved.

AleTrail relies on one such model, the AleTrailAppModel, to perform the primary
logical functionality for the app. It interacts with the BreweryService to fetch
data. The AleTrailAppModel uses this data to maintain a list of Brewery models 
as well as properties related to loading state, error state, and pagination.

Views, then, can rely directly upon models rather than intermediary UI-based
properties.

Many views can access the AleTrailAppModel, especially when they must leverage
functionality provided by the model. Otherwise, a subview may simply contain
one property passed in from its parent container. Swift now re-renders these
child views only when an accessed property changes, so there is no worry that a
robust data model will cause excessive screen re-loads.

The other functional model worth mentioning in the app is Settings, which acts
as a persistent model between launches. It uses SwiftData to persist data like
favorited brewery IDs and the latest viewed Brewery list mode.
