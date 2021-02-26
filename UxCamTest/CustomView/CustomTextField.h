//
//  CustomTextField.h
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextField : UITextField<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *searchResultsTableView;
@end


NS_ASSUME_NONNULL_END
