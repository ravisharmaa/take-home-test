//
//  Section.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Section : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSUUID *UUID;

@end

NS_ASSUME_NONNULL_END
