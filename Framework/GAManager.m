//
//  GAManager.m
//  Compras
//
//  Created by Exequiel Banga on 27/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//

#import "GAManager.h"
#import <UIKit/UIKit.h>

@interface GAManager()
@property(nonatomic,assign)NSUInteger iteration;
@property(nonatomic,strong)NSArray *bestPopulation;
@property(nonatomic,assign)CGFloat bestPopulationAptitude;

- (BOOL)shouldFinish;
- (id)bestIndividual;
- (void)selection;
- (void)cross;
- (void)mutation;
@end

@implementation GAManager

#pragma mark - Process
- (void)start{
    self.iteration = 0;
    self.bestPopulationAptitude = 0;
    self.bestPopulation = nil;
    
    while (![self shouldFinish]) {
        NSLog(@"Iteration #%lu",self.iteration);
        [self selection];
        [self cross];
        [self mutation];
        self.iteration ++;
    }
    self.population = self.bestPopulation;
    self.finishBlock(self.population,[self bestIndividual]);
}

- (void)selection{
    self.population = [self.selectionAlgorithm selectBestFrom:self.population];
}

- (void)cross{
    if ([self.crossAlgorithm respondsToSelector:@selector(crossFrom:)]) {
        self.population =  [self.population arrayByAddingObjectsFromArray:[self.crossAlgorithm crossFrom:self.population]];
    }else{
        NSMutableArray *population = [NSMutableArray arrayWithArray:self.population];
        NSMutableArray *cross = [NSMutableArray new];
        for (NSInteger i = 0; i < population.count; i++) {
            id parent1 = [population firstObject];
            [population removeObjectAtIndex:0];
            i--;
            NSUInteger indexParent2 = arc4random()%population.count;
            id parent2 = [population objectAtIndex:indexParent2];
            [population removeObjectAtIndex:indexParent2];
            i--;
            
            [cross addObjectsFromArray:[self.crossAlgorithm cross:parent1 with:parent2]];
        }
    }
}

- (void)mutation{
    [self.mutationAlgorithm mutate:self.population];
}

- (BOOL)shouldFinish{
    return self.iteration >= self.maxNumberOfIterations || self.selectionAlgorithm.aptitudeBlock([self bestIndividual])>=self.aptitudeThreshold;
}

- (id)bestIndividual{
    id bestIndividual;
    CGFloat bestAptitude = 0.0;
    for (id individual in self.population) {
        CGFloat aptitude = self.selectionAlgorithm.aptitudeBlock(individual);
        if (aptitude > bestAptitude) {
            bestAptitude = aptitude;
            bestIndividual = individual;
        }
    }
    NSLog(@"Best aptitude: %f",bestAptitude);
    
    // Save the best population
    if (self.bestPopulationAptitude < bestAptitude) {
        self.bestPopulationAptitude = bestAptitude;
        self.bestPopulation = self.population;
    }
    
    return bestIndividual;
}

@end
