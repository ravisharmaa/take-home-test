//
//  Section.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "Section.h"

#pragma mark - This serves as a the section for the collection view. As the modern collection view expects its section identifier type to be of ```NSObject``` we need to have it for our section.


@implementation Section

- (NSUUID *)UUID {
    return [[NSUUID alloc] init];
}

@end
