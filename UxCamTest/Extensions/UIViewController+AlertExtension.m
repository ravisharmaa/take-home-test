//
//  UIViewController+AlertExtension.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/23/21.
//

#import "UIViewController+AlertExtension.h"

@implementation UIViewController (AlertExtension)

- (void)showAlertWith:(NSString *)title andMessage:(NSString *)message {
    
#pragma mark- Dismiss any other view controllers.
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
