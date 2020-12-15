# iOS CarRepairDatabase-Realm
Create several [Realm](https://realm.io) objects by the schema.
## Image scheme
![alt text](https://github.com/lpopovic/CarRepairDatabase-Realm/blob/master/Scheme.png)

## Build and Runtime Requirements
+ Xcode 12.0 or later
+ Swift 4 or later
+ [CocoaPods](http://cocoapods.org/) 

## How to run 

1. Clone this repo
1. Open shell window and navigate to project folder
1. Run `pod install`
1. Open `CarRepairDatabase.xcworkspace`
1. Run playground file `CarRepairDatabasePlayground.playground`

## Realm Framework
+ [Link](https://realm.io/docs/swift/latest/)

### Installation Realm framework
You can install the framework with [CocoaPods](http://cocoapods.org/), by adding `'RealmSwift'` to your `Podfile`:

```ruby
# platform :ios, '9.0'

target 'YourApp' do
  use_frameworks!

  # Pods for YourApp
 pod 'RealmSwift'

end
```
