# ESAPIManager

[![CI Status](http://img.shields.io/travis/1174060232@qq.com/ESAPIManager.svg?style=flat)](https://travis-ci.org/1174060232@qq.com/ESAPIManager)
[![Version](https://img.shields.io/cocoapods/v/ESAPIManager.svg?style=flat)](http://cocoapods.org/pods/ESAPIManager)
[![License](https://img.shields.io/cocoapods/l/ESAPIManager.svg?style=flat)](http://cocoapods.org/pods/ESAPIManager)
[![Platform](https://img.shields.io/cocoapods/p/ESAPIManager.svg?style=flat)](http://cocoapods.org/pods/ESAPIManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ESAPIManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ESAPIManager"
```
## Usage

遵守ESAPIProtocol协议。
```
ESWeatherAPI *weatherApi=[[ESWeatherAPI alloc] init];
weatherApi.password=@"DJOYnieT8234jlsK";
weatherApi.city=@"郑州";
weatherApi.day=0;
[weatherApi requestWithSuccess:^(id result) {

} failure:^(NSError *error) {

}];

```
## Author

tianpengtao, 1174060232@qq.com

## License

ESAPIManager is available under the MIT license. See the LICENSE file for more info.
