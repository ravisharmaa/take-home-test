//
//  ImageMapper.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageMapper : NSObject

+ (NSDictionary *) imageMap;

+ (NSString *) getImageOfName: (NSString *) name;


@end

NS_ASSUME_NONNULL_END
