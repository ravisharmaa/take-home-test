//
//  CompositionalLayoutsHelper.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "CompositionalLayoutsHelper.h"

@implementation CompositionalLayoutsHelper

#pragma mark - Returns the layout used in the weekly weather view. The purpose of this is to hide the implemntaion of the layout.

+ (UICollectionViewCompositionalLayout *)weatherDetailLayout {
    
    // preparing the items
    NSCollectionLayoutDimension *itemWidth = [NSCollectionLayoutDimension fractionalWidthDimension:1];
    
    NSCollectionLayoutDimension *itemHeight = [NSCollectionLayoutDimension fractionalHeightDimension:1];
    
    // preparing item size
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:itemWidth heightDimension:itemHeight];
    
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    
    // item content insets
    item.contentInsets = NSDirectionalEdgeInsetsMake(5, 5, 0, 2);
    
    // group which encloses the item
    NSCollectionLayoutDimension *widthDimension = [NSCollectionLayoutDimension fractionalWidthDimension:0.2];
    
    NSCollectionLayoutDimension *heightDimension = [NSCollectionLayoutDimension absoluteDimension:90];
    
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:widthDimension heightDimension:heightDimension];
    
    // group direction
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
    
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    
    // groups scrolling behavior
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
    
    section.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 0);
    
    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
}

@end
