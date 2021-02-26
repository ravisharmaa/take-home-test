//
//  NetworkManager.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/23/21.
//

#import "NetworkManager.h"
#import "Constants.h"

@implementation NetworkManager

#pragma mark - Get data with completion handler.

- (NSURLComponents *) urlComponents {
    if (_urlComponents == nil) {
        NSURLComponents *components = [[NSURLComponents alloc] init];
        components.scheme = SCHEME;
        components.host = BASE_URL;
        return components;
    }
    
    return _urlComponents;
}

#pragma mark- Outputs NSArray

-(void) getData:(NSString *)cityName needsHost: (BOOL) host forURL: (NSString *) url completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {

    NSURLComponents *innerURLComponents;
    
    if (host) {
        innerURLComponents = self.urlComponents;
        //innerURLComponents.host = BASE_URL;

        innerURLComponents.path = [innerURLComponents.path stringByAppendingString:url];

        innerURLComponents.queryItems = @[
            [[NSURLQueryItem alloc] initWithName:APP_ID value:API_KEY],
            [[NSURLQueryItem alloc] initWithName:QUERY_STRING_FOR_LOCATION value:cityName]
        ];
    } else {
        innerURLComponents = self.urlComponents;
        innerURLComponents.host = CITY_API;
        innerURLComponents.queryItems = @[[[NSURLQueryItem alloc] initWithName:@"city" value:cityName]];
    }
    
    
    
    [[NSURLSession.sharedSession
      dataTaskWithURL:innerURLComponents.URL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSError *err;

        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];

        if (err) {
            NSLog(@"Cant read json data");
            completion(nil, err);
            return;
        }

        completion(jsonData, nil);
    } ] resume] ;
}




#pragma mark - Outputs

-(void)  getDataWith:(NSString *)name completion:(void (^)(NSData * _Nullable, NSError * _Nullable ))completion {
    NSURLComponents *innerURLComponents = self.urlComponents;
    
    innerURLComponents.path = [innerURLComponents.path stringByAppendingString:WEATHER_URL];
    
    innerURLComponents.queryItems = @[
        [[NSURLQueryItem alloc] initWithName:APP_ID value:API_KEY],
        [[NSURLQueryItem alloc] initWithName:QUERY_STRING_FOR_LOCATION value:name]
    ];
    
    
    [[NSURLSession.sharedSession
      dataTaskWithURL:innerURLComponents.URL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Cant read json data");
            completion(nil, error);
            return;
        }
        
        completion(data, nil);
    } ] resume] ;
}




@end
