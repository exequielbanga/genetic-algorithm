//
//  BinomialCross.h
//  Compras
//
//  Created by Exequiel Banga on 29/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAManager.h"

@interface BinomialCross : NSObject<CrossAlgorithm>

+ (NSArray *)crossPropertiesOf:(id)individualA withPropertiesOf:(id)individualB;

@end
