# AKNetworkRequest
This is a simple obj-C library for performing network requests in ios. Currently this library only supports GET and POST request type.

## Getting Started

### Installation

#### Manually

- Add `AKNetworkRequest.h` and `AKNetworkRequest.m` files to your Xcode project.
- `#import "AKNetworkRequest.h"` in your code.

### Usage

Create `AKNetworkRequest` instance and use the method `getdataFromWebService : requestDict : requestUrl : requestType : contentType : callBackTemp : callBackSelector` to perform API request and receive the data 

#### Create the `AKNetworkRequest` instance

``` 
AKNetworkRequest *apiRequest = [[AKNetworkRequest alloc] init];
```

#### Create the request Dictionary to be sent as parameters in API 

```
NSDictionary *requestDict = @{
                                  @"api_key":@"KUq9QVWSoMOZrPkGMnH9aXl5D72Sxo",
                                  @"user_id": @"EMP0081",
                                  @"first_name": @"John",
                                  @"last_name": @"Doe",
                                  @"email" : @"john@gmail.com"
                              };
```

#### Create a dictionary of headers to be sent as headers in API

```
NSDictionary *requestHeaders = @{
                                     @"Authorization" : @"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImUxMDYyNDU0ZThkOTBiYzEzOTFkODU1NWIyN2Q3NmU0NTUzMmM2Mzg2NWU0MTBlMzY2YzJhOGIxOGMyNWE3MjY4Y2VjMjcyZGQzMzA3Y2ExIn0.eyJhdWQiOiI4IiwianRpIjoiZTEwNjI0NTRlOGQ5MGJjMTM5MWQ4NTU1YjI3ZDc2ZTQ1NTMyYzYzODY1ZTQxMGUzNjZjMmE4YjE4YzI1YTcyNjhjZWMyNzJkZDMzMDdjYTEiLCJpYXQiOjE1MjY1NjQwNzIsIm5iZiI6MTUyNjU2NDA3MiwiZXhwIjoxNTU4MTAwMDcyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.RsSHZeGbWiIzmlO68XoLmevjQ3sOm"
                                 };
```
				  
#### Implement the following method to perform the API request

- For POST method with Content-Type : form-data

```
//Now pass the request dictionary, request headers dictionary, request url, "POST" for request-type and "FORM-DATA" for content-type as parameters

[apiRequest getdataFromWebService: requestDict :requestHeaders :@"http://www.domain.com/api/path" :@"POST" :@"FORM-DATA" :self:@selector(receiveData :)];
```

- For POST method with Content-Type : application/json

```
//Now pass the request dictionary, request headers dictionary, request url, "POST" for request-type and "JSON" for content-type as parameters

[apiRequest getdataFromWebService: requestDict :requestHeaders :@"http://www.domain.com/api/path" :@"POST" :@"JSON" :self:@selector(receiveData :)];
```

- For GET method 

```
//Now pass the request dictionary, request headers dictionary, request url, "GET" for request-type as parameters

[apiRequest getdataFromWebService: nil : requestHeaders : @"http://www.domain.com/api/path": @"GET" :nil :self:@selector(receiveData :)];
```


*Note :* 
- `receiveData` is the callBack Selector used to receive the data from the API in the same view controller
- `requestUrl` and `requestType` are mandatory parameters
- `headersDict`, `requestDict` and `contentType` are optional parameters and should be passed as `nil` when there is no requirement


#### Receive the response fetched from API using the callback selector

```
-(void)receiveData : (NSDictionary *)resultDict
{
    
    NSLog(@"JSON response received from API : %@", resultDict);
    
}
```

## Requirements

- iOS 8.0 or later
- Xcode 8.0 or later

## Built With

* [NSURLSession](https://developer.apple.com/documentation/foundation/nsurlsession?language=objc) - ObjC class used


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
