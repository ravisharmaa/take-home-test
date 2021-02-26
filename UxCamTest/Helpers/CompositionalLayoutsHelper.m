//
//  CompositionalLayoutsHelper.m
//  UxCamTest
//
//  Created by Ravi Bastola on 2/26/21.
//

#import "CompositionalLayoutsHelper.h"

@implementation CompositionalLayoutsHelper

+ (UICollectionViewCompositionalLayout *)weatherDetailLayout {
    
    NSCollectionLayoutDimension *itemWidth = [NSCollectionLayoutDimension fractionalWidthDimension:1];
    
    NSCollectionLayoutDimension *itemHeight = [NSCollectionLayoutDimension fractionalHeightDimension:1];
    
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:itemWidth heightDimension:itemHeight];
    
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    
    item.contentInsets = NSDirectionalEdgeInsetsMake(5, 5, 0, 2);
    
    NSCollectionLayoutDimension *widthDimension = [NSCollectionLayoutDimension fractionalWidthDimension:0.2];
    
    NSCollectionLayoutDimension *heightDimension = [NSCollectionLayoutDimension absoluteDimension:80];
    
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:widthDimension heightDimension:heightDimension];
    
    
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
    
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    
    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
    
    section.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 0);
    
    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
}

@end
