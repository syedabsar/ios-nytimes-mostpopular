## ios-nytimes-mostpopular

A simple iOS Native app developed in Swift to hit the The NY Times Most Popular Articles (Most Viewed) API and show a list of articles, that shows details when items on the list are tapped (a typical master/detail app).

## Demonstrations

Covers the following:
* Object Oriented Programming Approach 
* Unit Tests 
* Generic and simple code 
* Leverage today's best coding practices

App Features:
* Supports Split View (Landscape orientation)
* Auto layout with Dynamic Cell Resizing
* Supports API Pagination 
* Dynamic Time Period Configuration 
* Dynamic Section Configuration 
* Leverage today's best coding practices (See Disclaimer)



## Installation - Using CocoaPods

After cloning the project, install the Pods.

```
Pod install
```

## Build

To build using xcodebuild without code signing
```
xcodebuild clean build -workspace "NYTimes_MostPopularArticles.xcworkspace" -scheme "NYTimes_MostPopularArticles" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
```


## Tests

Describe and show how to run the tests with code examples.
```
xcodebuild -workspace "NYTimes_MostPopularArticles.xcworkspace" -scheme "NYTimes_MostPopularArticles" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 7 Plus,OS=10.3' test
```


## Architecture at a Glance

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)


## Disclaimer

Although code quality can be subjective at times, and the approaches may not entirely be the best, I'll be happy to answer any questions related to existing implementations as well as acknowledged areas which can potentially be further improved.

## General Notes/FAQ's

* Why a protocol for Network Controller?
This keeps the Structure flexible and independent of the networking SDK used. I used Alamofire in this example, however the structure is flexible enough to accomodate any other framework or custom classes.

* Why base64encoded the api-key?
To keep the implementation simple, not recommended for production usages (Best to keep the api key on a server proxy, or use encryption if at all it has to be kept in the code), hard-coding the api-key in plain text inside the code should be avoided at any cost.

* Why some classes have static methods but are not Singletons?
None of the classes in the current scope are maintaining any stateful functionality at the moment. (Although a session like state can be maintained for current offset etc under a single class, but with a 2-page application, viewcontroller handling this is simplest) Unless a class needs to maintains a state, using singleton only for static methods should be avoided.

* What areas are potentially improvable, or to be updated in future?
- Unit Tests, current coverage is basic with minimum scenarios, this could be reflected more. Web service response stubs could be utilised for parsing tests etc.

- Config Manager can be further extended to support multiple environments and url configurations, for example QA, Production etc.

- Appearance could be further implemented in a more flexible way to plug and play multiple themes.

## License

A short snippet describing the license (MIT, Apache, etc.)
