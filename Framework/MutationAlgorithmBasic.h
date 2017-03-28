//
//  MutationAlgorithmBasic.h
//  Compras
//
//  Created by Exequiel Banga on 29/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAManager.h"

@interface MutationAlgorithmBasic : NSObject<MutationAlgorithm>
/**
 *  Determines the probability of mutation as 1/inverseProbability
 */
@property(nonatomic,assign)NSUInteger inverseProbability;

@end
