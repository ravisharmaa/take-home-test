//
//  LandingViewController.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/23/21.
//

#import "LandingViewController.h"
#import "NetworkManager.h"
#import "UIViewController+AlertExtension.h"
#import "CJSONDeserializer.h"
#import "TextFieldAndButtonView.h"
#import "WeatherDetailViewController.h"


@interface LandingViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) CustomTextField *searchTextField;

@property (nonatomic, strong) TextFieldAndButtonView *searchView;

@property (nonatomic, assign) NSLayoutConstraint *searchViewCenterYConstraint;


@end

@implementation LandingViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    [self configureBackgroundview];
    
    [self confiureActivityIndicator];
    
    [self configureSearchView];
    
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) configureBackgroundview {
    
    UIImage *parisImage = [UIImage imageNamed:@"bg"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:parisImage];
    
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview: self.backgroundImageView];
    
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_backgroundImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_backgroundImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_backgroundImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_backgroundImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

- (void) confiureActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.activityIndicator.hidesWhenStopped = YES;
    
    [self.view addSubview:self.activityIndicator];
    
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

-(void) configureSearchView {
    self.searchView = [[TextFieldAndButtonView alloc] init];
    
    self.searchView.goButton.enabled = NO;
    
    [self.view addSubview:self.searchView];
    self.searchView.searchTextField.delegate = self;
    
    self.searchViewCenterYConstraint = [self.searchView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
    self.searchViewCenterYConstraint.active = YES;
    [self.searchView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.searchView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20].active = YES;
    [self.searchView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20].active = YES;
    
    [self.searchView.goButton addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
}


-(void) handleTap {

    NSLog(@"%@", self.searchView.searchTextField.text);
//    if (self.searchView.searchTextField.text.length > 3) {
//        WeatherDetailViewController *vc = [[WeatherDetailViewController alloc] initWithCityName:self.searchView.searchTextField.text];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    _searchViewCenterYConstraint.active = NO;

    __weak typeof(self) weakSelf = self;
    
    
    [UIView animateWithDuration:0.5 delay:0.6 usingSpringWithDamping:2.0 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
                __strong typeof(self) strongSelf = weakSelf;
        
        strongSelf.searchViewCenterYConstraint = [self.searchView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-350];
        strongSelf.searchViewCenterYConstraint.active = YES;
        [self.searchView layoutIfNeeded];
    } completion:nil];

}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    _searchViewCenterYConstraint.active = NO;

    [self.searchView layoutIfNeeded];
    
    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:0.5 animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        [self.searchView layoutIfNeeded];
        strongSelf.searchViewCenterYConstraint = [self.searchView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
        strongSelf.searchViewCenterYConstraint.active = YES;
    }];
}

- (void) changeImage {
    
}

#pragma mark - Search Bar Delegate Methods

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    NetworkManager *manager = [[NetworkManager alloc] init];
    
    if (searchBar.text.length > 3) {
        
        [self.activityIndicator startAnimating];
        
        if (searchBar.text.length > 3) {
            
            [self.activityIndicator startAnimating];
            
            __weak typeof(self) weakSelf = self;
            
            [manager getDataWith:searchBar.text completion:^(NSData * _Nonnull data, NSError * _Nonnull error) {
                
                __strong typeof(self) strongSelf = weakSelf;
                
                if (error != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf showAlertWith:@"Error" andMessage:error.localizedDescription];
                    });
                } else {
                    NSError *theError = nil;
                    id theObject = [[CJSONDeserializer deserializer] deserialize:data error:&theError];
                    
                    NSLog(@"%@", theObject);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf.activityIndicator stopAnimating];
                    });
                }
            }];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:textField.text];
    
    self.searchView.goButton.enabled = ( str.length > 3 ) ? YES : NO;
    
    return YES;
}
@end
