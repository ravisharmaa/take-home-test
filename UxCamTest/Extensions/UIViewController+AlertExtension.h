//
//  UIViewController+AlertExtension.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/23/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AlertExtension)

- (void) showAlertWith:(NSString *)title andMessage: (NSString*)message;

@end

NS_ASSUME_NONNULL_END
