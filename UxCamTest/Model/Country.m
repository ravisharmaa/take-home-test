//
//  Country.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/25/21.
//

#import "Country.h"

@implementation Country

- (instancetype) initWithCityName :(NSString *) cityName {
    if (self = [super init]) {
        _name = cityName;
    }
    
    return self;
}

- (instancetype) initWithDictionary: (NSDictionary *) dictionary {
    NSString *city = dictionary[@"city"];
    return [self initWithCityName:city];
}


@end
