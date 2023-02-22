
# Small application that displays movies list from The Movie DB. When user selects a movie from list, the Movie Detail screen should be displayed.

## The first build

You don't have to run any scripts to build the project.
The project uses SPM for dependencies.

## The stack

Apple Concurrency (async/await) family is used all across the app(VIPER).

Moya for networking.

SwiftGen for generation of resources.

## The app architecture

The application is designed with VIPER architecture pattern.

Models are presented as immutable structures.

The movies in the list are loaded by pages. When the movies list is about to reach bottom.

## User interface

The UI is written in UIKit + storyboards.

## Possible TODOs

Here is the list of possible futher improvements:
1. Add tests using RxTest framework.
2. Improve the look of UI.
3. Add images loading cancellation, so image loading is cancelled for images that are not loaded yet and that already has gone from the screens.

## Task :

Create an IOS application that displays the list of trending movies, when we select one movie it shows more details about it.

As a data provider, use the following REST API endpoints:

List of trending movies
```
https://api.themoviedb.org/3/discover/movie https://developers.themoviedb.org/3/discover/movie-discover
```
Details of a movie
```
https://developers.themoviedb.org/3/movies/{movie_id} https://developers.themoviedb.org/3/movies/get-movie-details
```


```
● Follow this documentation to get the full poster image path of a movie :
https://developers.themoviedb.org/3/getting-started/images
```
You can use the image below as a reference for implementing the UI but you are not required to follow it exactly. You can
unleash your creativity.

# Remarks:

```
● Even if it’s a simple project, Implement the app in the best way that represents your understanding of high quality
software. It will be your best way to share your knowledge with us.
● The application code should be pushed to a public github repository, and share the repository link with us.
● The application will be compiled and run under the latest iOS SDK with the latest production Xcode.
● The application is expected to be written in Swift and UIKit.
```
