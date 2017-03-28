//
//  Selection.m
//  Compras
//
//  Created by Exequiel Banga on 29/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//

#import "TableSelectionAlgorithm.h"

@implementation TableSelectionAlgorithm
@synthesize generationalJump,aptitudeBlock;

- (NSArray *)selectBestFrom:(NSArray *)population{
    NSMutableArray *ranking = [NSMutableArray new];
    NSMutableArray *sortedPopulation = [NSMutableArray new];
    NSComparator comparator = ^(NSNumber *object1, NSNumber *object2){
        return [object2 compare:object1];
    };

    for (id individual in population) {
        NSNumber *rankingValue = @(self.aptitudeBlock(individual));
        NSUInteger newIndex = [ranking indexOfObject:rankingValue
                                     inSortedRange:(NSRange){0, [ranking count]}
                                           options:NSBinarySearchingInsertionIndex
                                   usingComparator:comparator];
        
        [ranking insertObject:rankingValue atIndex:newIndex];
        [sortedPopulation insertObject:individual atIndex:newIndex];
    }
    return [sortedPopulation subarrayWithRange:NSMakeRange(0, self.generationalJump.floatValue*sortedPopulation.count)];
}

@end
