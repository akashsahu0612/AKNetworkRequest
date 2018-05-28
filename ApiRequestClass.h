//
//  ApiRequestClass.h
//  TripIn2
//
//  Created by Anand Kumar Singh on 01/01/18.
//  Copyright © 2018 Vyrazu Labs Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiRequestClass : NSObject <NSURLSessionDelegate>
-(void)getdataFromWebService : (NSDictionary *)requestDict : (NSString *)requestUrl : (NSString *)requestType : (NSString *)contentType : (id)callBackTemp :(SEL)callBackSelector;
@end
