//
//  BinomialCross.m
//  Compras
//
//  Created by Exequiel Banga on 29/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//

#import "BinomialCross.h"
#import "NSObject+category.h"
#import <objc/runtime.h>

@implementation BinomialCross

- (NSArray *)crossFrom:(NSArray *)population{
    NSMutableArray *crossArray = [NSMutableArray new]; //The result Array
    NSMutableArray *populationAux = [NSMutableArray arrayWithArray:population]; // The parents array

    while (populationAux.count) {
        //Get the first parent
        NSUInteger individualAIndex = arc4random()%populationAux.count;
        id<Chromosome> individualA = populationAux[individualAIndex];
        [populationAux removeObject:individualA];

        //Get the second parent
        NSUInteger individualBIndex = arc4random()%populationAux.count;
        NSObject *individualB = populationAux[individualBIndex];
        [populationAux removeObjectAtIndex:individualBIndex];
        
        //Make the cross
        Class<Chromosome>class = [individualA class];
        [crossArray addObjectsFromArray:[class cross:individualA with:individualB]];
    }
    return crossArray;
}

+ (NSArray *)crossPropertiesOf:(id)individualA withPropertiesOf:(id)individualB{
    id childA = [[individualA class] new];
    id childB = [[individualA class] new];
    NSArray *listOfProperties = [self allPropertyNamesOfClass:[individualA class]];
    for (NSString *propertyName in listOfProperties) {
        if (arc4random()%2) {
            [childA setVoidValue:[individualA performSelector:NSSelectorFromString(propertyName) withParams:nil] forKey:propertyName];
            [childB setVoidValue:[individualB performSelector:NSSelectorFromString(propertyName) withParams:nil] forKey:propertyName];
        }else{
            [childB setVoidValue:[individualA performSelector:NSSelectorFromString(propertyName) withParams:nil] forKey:propertyName];
            [childA setVoidValue:[individualB performSelector:NSSelectorFromString(propertyName) withParams:nil] forKey:propertyName];
        }
    }
    return @[childA,childB];
}


+ (NSArray *)allPropertyNamesOfClass:(Class)class{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}

@end
