//
//  Country.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/25/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSObject

@property NSString *name;

- (instancetype) initWithCityName :(NSString *) cityName;
- (instancetype) initWithDictionary: (NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
