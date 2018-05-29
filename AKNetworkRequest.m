//  AKNetworkRequest.m
//
//  Created by Anand Kumar Singh on 01/01/18.
//  Copyright © 2018 Vyrazu Labs Pvt Ltd. All rights reserved.
//

#import "AKNetworkRequest.m"
@implementation AKNetworkRequest

-(void)getdataFromWebService : (NSDictionary *)requestDict : (NSString *)requestUrl : (NSString *)requestType : (NSString *)contentType : (id)callBackTemp :(SEL)callBackSelector
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDict
                                                           options:0
                                                             error:&error];
        
        
    //Request API
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:requestUrl];
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:requestType];
    
    if ([contentType isEqualToString:@"JSON"])
    {
        //For network request of Content Type JSON
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString *length = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]];
        [request setValue:length forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsonData];
    }
    else if ([contentType isEqualToString:@"FORM-DATA"])
    {
        //For network request of Content Type Form Data
        NSMutableArray *keyValueParamArray = [[NSMutableArray alloc] init];
        NSArray *allKeys = [requestDict allKeys];
        for (int i = 0 ; i < allKeys.count ; i++)
        {
            NSString *key = [allKeys objectAtIndex:i];
            NSString *value = [requestDict objectForKey:key];
            NSString *keyValue = [NSString stringWithFormat:@"%@=%@",key,value];
            [keyValueParamArray addObject:keyValue];
        }
        NSString *requestParams = [keyValueParamArray componentsJoinedByString:@"&"];
        [request setHTTPBody:[requestParams dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSObject *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"Json Response from webservice : %@",jsonResponse);
            dispatch_async(dispatch_get_main_queue(), ^{
                [callBackTemp performSelector:callBackSelector withObject:jsonResponse];
            });
        }
    }];
    [dataTask resume];
   
}
@end
