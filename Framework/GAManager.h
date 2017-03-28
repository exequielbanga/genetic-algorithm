//
//  GAManager.h
//
//  Created by Exequiel Banga on 27/12/15.
//  Copyright © 2015 Codika. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
/**
 `GAManager` is the main class of the genetic algorithm model made by Codika.
 Using its instances you can manage a genetic algorithm process in a declarative way, just saying wich algorithms you will use for crossing, selecting and mutating the individuals. You will also find process properties like number of iteration, aptitudeThreshold and the population itself.
 In order to start the process you have to call the 'start' method. Once finished, the process will call 'finishBlock' wich will receive the finalPopulation and the bestIndividual from that population.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  This is the block that will evaluate each individual and assign them the aptitude value
 *
 *  @param individual A specific individual
 *
 *  @return The aptitude of the individual
 */
typedef CGFloat (^AptitudeBlock)(id individual);


/**
 *  Defines the selection algorithm of the process
 */
@protocol SelectionAlgorithm<NSObject>
/**
 *  Percentage of the population that will be replaced. From 0 to 1
 */
@property (nonatomic,strong)NSNumber    *generationalJump;
@property(nonatomic,copy)AptitudeBlock  aptitudeBlock;

/**
 *  Returns the best individuals of a population
 *
 *  @param population The original population
 *
 *  @return The best individuals of the population
 */
- (NSArray *)selectBestFrom:(NSArray *)population;

@end

/**
 *  Defines the cross algorithm of the process
 */
@protocol CrossAlgorithm<NSObject>
@optional
/**
 *  Generate two new individuals based on two parents
 *
 *  @param individualA The first parent
 *  @param individualB The secont parent
 *
 *  @return The two new individuals
 */
- (NSArray *)cross:(id)individualA with:(id)individualB;

/**
 *  Returns The new generation based on an array of parents
 *
 *  @param population The array of parents
 *
 *  @return The new generation
 */
- (NSArray *)crossFrom:(NSArray *)population;
@end


/**
 *  Defines the mutation algorithm of the process
 */
@protocol MutationAlgorithm<NSObject>
/**
 *  Makes the mutation of some individuals if necessary
 *
 *  @param population The population to be muted
 */
- (void)mutate:(NSArray *)population;
@end

/**
 *  Each individual of the poblation should implement this protocol
 */
@protocol Chromosome <NSObject>
/**
 *  Ask the individual to mutate. Each class has to ensure the integrity of the new mutated data
 */
- (void)mutate;
+ (NSArray *)cross:(id)individualA with:(id)individualB;
@end


typedef void (^GAFinishBlock)(NSArray *finalPopulation,id bestIndividual);

@interface GAManager : NSObject

@property(nonatomic,strong)id<SelectionAlgorithm>   selectionAlgorithm;
@property(nonatomic,strong)id<CrossAlgorithm>       crossAlgorithm;
@property(nonatomic,strong)id<MutationAlgorithm>    mutationAlgorithm;
@property(nonatomic,copy)GAFinishBlock              finishBlock;

@property(nonatomic,strong)NSArray                  *population;
@property(nonatomic,assign)CGFloat                  maxNumberOfIterations;
@property(nonatomic,assign)CGFloat                  aptitudeThreshold;

- (void)start;

@end
