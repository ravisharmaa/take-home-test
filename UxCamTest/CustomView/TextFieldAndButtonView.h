//
//  TextFieldAndButtonView.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldAndButtonView : UIView

@property (nonatomic, strong) CustomTextField *searchTextField;

@property (nonatomic, strong) UIButton *goButton;

@end

NS_ASSUME_NONNULL_END
