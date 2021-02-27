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

-(void) getData: (NSString *) cityName needsHost: (BOOL)host forURL: (NSString *) url completion:(void(^)(NSDictionary* data, NSError *error)) completion;

- (void) getImageData: (NSString *)url completion:(void(^)(NSData* data, NSError *error)) completion;

@end

NS_ASSUME_NONNULL_END
