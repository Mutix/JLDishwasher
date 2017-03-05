# JLDishwasher

Hi John Lewis crew, and thanks for the opportunity to showcase some code.

First of all, you'll notice I only completed the product grid section of the test - I preferred building the product grid to a standard which I'm happy with, and that ended up filling the half day timebox I'd set myself for the exercise.

### Installation

I used [Cocoapods](https://cocoapods.org) to pull in a few external dependencies (see below), but have included them in the repo so all you should have to do is open the `JLDishwasher.xcworkspace`, hit `CMD+U` to run the unit tests and `CMD+R` to run the app.

Automatic code-signing is turned on, so you'll probably need to change the Team in order to build and run successfully.


### Dependencies
The third party frameworks I used are the following:
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON): Nice wrapper around `NSJSONSerialization` which takes the pain out of mapping the JSON API response to our model objects
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage): Used for the nifty UIImageView extension that handles async image downloading and caching.
  - Saved me time and was quick and easy for the scope of this tech test
  - Would probably deserve an image download service and discussion around caching strategy
  - Using an extension meant I couldn't easily unit test that the URL passed to the UIImageView was the correct one because I couldn't capture the URL by overriding the `af_setImage(withURL:)` function.


### Approach

- tried to separate out concerns and roles as much as possible (TDD certainly helps this).
- protocol oriented, dependency injection

Built the app services first and UI last, which is an approach that

a) I enjoy because it all magically comes together when you plug in the UI at the end, and <br />
b) I thought would be more suited to this exercise since if I ran out of time I imagine you'd probably be more interested in seeing the service layer than a cell nib and collection view data source


### Notes

Would I have had/taken more time, here's a few things I would have done;
- `ProductGridViewController` tests
  - injecting the `ProductSearchService` and `ProductGridDataSource` into the `ProductGridViewController` to enable this, rather then having the controller create its own instances
- refactored the `ProductGridDataSourceTests` a bit more
- ~~probably renamed the `ProductSearcher` struct and `RemoteProductSearching` protocol a few times (`ProductFetcher` & `ProductFetching`, maybe?)~~
  - Done
- created a `Theme` to handle the navigation title customization, and vend various fonts and colors
- added some sort of progress HUD or refresh control to the `ProductGridViewController`
- custom flow layout for the product grid
- nicer cell separators
- better error handling
- product detail page
- UI tests


That's about all I can think of for now, I'll let you discover the rest and look forward to discussing it with you in more detail!
