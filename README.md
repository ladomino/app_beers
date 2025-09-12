# app_beers

Flutter Application showing use of Riverpod and several other packages.

## Getting Started

This is an application that uses a Public API to retrieve Beers and images.
The goal is to show usage of a variety of packages, techniques used in Flutter
applications.

This application uses go_router for easier routing
This application uses Infinite Scroll for Beers List Page
This application uses Refresh Pulldown for Beers List Page
This application uses CachedNetworkImage for displaying Beers Image

State Management for this app is Riverpod.

For Infinite Scroll a StateNotifier is used as the state data is
added to.  So scrolling will load new data and only cause 
efficient rebuilds.    If a FutureProvider was used that is Stateless and
would require saving/controlling the fetched data to support Infinite scroll 
and refresh.

*Important to know How data is used/stored for rebuilds and whether it changed on the backend frequently or not when building pages!!

