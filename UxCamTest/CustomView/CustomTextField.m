//
//  CustomTextField.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/24/21.
//

#import "CustomTextField.h"
#import "Constants.h"
#import "Country.h"

@interface CustomTextField()

@property (nonatomic, strong) UITableView *searchResultsTableView;

@property NSMutableArray *citiesArray;

@end

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderWidth:0.5];
        [self.layer setCornerRadius:12];
        
        UIImage *systemImage  = [[UIImage systemImageNamed:MAGNIFYING_GLASS] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = systemImage;
        [self setLeftView:imageView];
        [self setLeftViewMode:UITextFieldViewModeAlways];
    }
    return self;
}

- (void) willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    [self.searchResultsTableView removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self buildSearchTableView];
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidBeingEditing) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textFieldEndEditing) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(textFieldEndEditingOnExit) forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

- (void) textFieldDidChange {
    [self getCountriesData];
    [self updateTableView];
    [self.searchResultsTableView setHidden:false];
    
}

- (void) textFieldDidBeingEditing {
    
}

- (void) textFieldEndEditing {
    [self.searchResultsTableView setHidden:true];
}

- (void) textFieldEndEditingOnExit {
    [self.searchResultsTableView setHidden:true];
}



- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 35, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 35, 0);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += 10;
    return  textRect;
}



-(void) buildSearchTableView {
    
    [self.searchResultsTableView removeFromSuperview];
    
    self.searchResultsTableView = [[UITableView alloc] init];
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.delegate = self;
    [self.window addSubview:self.searchResultsTableView];
    
    [self updateTableView];
}

- (void) getCountriesData {
    if (self.text.length > 0) {
        
        _citiesArray = [[NSMutableArray alloc] init];
        
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:@"https://uxcam-api.herokuapp.com"];
        
        NSURLQueryItem *item = [[NSURLQueryItem alloc] initWithName:@"city" value:self.text];
        
        components.queryItems = @[item];
        
        [[NSURLSession.sharedSession dataTaskWithURL:components.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSError *err;
            
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            
            if (err) {
                NSLog(@"Cant read json data");
                return;
            }
            
            NSArray *fetchedData = jsonData[@"data"];
            
            for (NSDictionary *dic in fetchedData) {
                Country *country = [[Country alloc] initWithDictionary:dic];
                NSLog(@"%@", country.name);
                [self.citiesArray addObject:country];
            }
            
            NSLog(@"%lu", self.citiesArray.count);
            
           // dispatch_async(dispatch_get_main_queue(), ^{
                //[self.searchResultsTableView reloadData];
            //});
            
        }] resume];
    }
}

-(void) updateTableView {
    [self.superview bringSubviewToFront:self.searchResultsTableView];
    
    CGFloat tableHeight;
    
    tableHeight = self.searchResultsTableView.contentSize.height;
    
    if (tableHeight < self.searchResultsTableView.contentSize.height) {
        tableHeight -= 10;
    }
    
    CGRect tableFrame;
    
    tableFrame = CGRectMake(0, 0, self.frame.size.width, tableHeight);
    
    tableFrame.origin = [self convertPoint:tableFrame.origin toView:nil];
    
    tableFrame.origin.x += 2;
    
    tableFrame.origin.y =+ self.frame.size.height + 80;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.searchResultsTableView.frame = tableFrame;
    }];
    
    self.searchResultsTableView.layer.masksToBounds = YES;
    [self.searchResultsTableView setSeparatorInset:UIEdgeInsetsZero];
    self.searchResultsTableView.layer.cornerRadius = 10;
    self.searchResultsTableView.separatorColor = UIColor.lightGrayColor;
    self.searchResultsTableView.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.5];
    
    if (self.isFirstResponder) {
        [self.superview bringSubviewToFront:self];
    }
    
    //[self.searchResultsTableView reloadData];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    Country *country = self.citiesArray[indexPath.row];
    cell.textLabel.text = country.name;
    return  cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.citiesArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Country *country = self.citiesArray[indexPath.row];
    self.text = country.name;
    [self.searchResultsTableView setHidden:YES];
    [self endEditing:YES];
}


@end
