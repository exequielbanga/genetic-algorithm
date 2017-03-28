//
//  MutationAlgorithmBasic.m
//  Compras
//
//  Created by Exequiel Banga on 29/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//

#import "MutationAlgorithmBasic.h"

@implementation MutationAlgorithmBasic

- (void)mutate:(NSArray *)population{
    if (!(arc4random()%self.inverseProbability)) {
        [population[arc4random()%population.count] mutate];
    }
}

@end
