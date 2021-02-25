//
//  NetworkManager.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/23/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

@property (nonatomic, strong) NSURLComponents *urlComponents;


-(void) getData: (NSString *) cityName completion:(void(^)(NSArray* data, NSError *error)) completion;

-(void) getDataWith: (NSString *) name completion: (void(^) (NSData * data, NSError *error)) completion;
@end

NS_ASSUME_NONNULL_END
