//
//  TextFieldAndButtonView.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import "TextFieldAndButtonView.h"


@implementation TextFieldAndButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchTextField = [[CustomTextField alloc] initWithFrame:CGRectZero];
        self.searchTextField.placeholder = @"Enter your location...";
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.searchTextField.heightAnchor constraintEqualToConstant:55].active = YES;
        
        self.goButton = [[UIButton alloc] init];
        [self.goButton setTitle:@"Go" forState:UIControlStateNormal];
        [self.goButton setBackgroundColor:UIColor.blueColor];
        [self.goButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.goButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateDisabled];
        [self.goButton.layer setCornerRadius:12];
        [self.goButton setClipsToBounds:YES];
        
        self.goButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.goButton.widthAnchor constraintEqualToConstant:60].active = YES;
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews: @[self.searchTextField, self.goButton]];
        [stackView setAxis:UILayoutConstraintAxisHorizontal];
        [stackView setAlignment:UIStackViewAlignmentFill];
        [stackView setSpacing:10];
        
        [self addSubview:stackView];
        
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [stackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        [stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

@end
