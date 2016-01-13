//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Stacy Johnson on 11/21/15.
//  Copyright © 2015 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@interface FISCardDeck()

-(void) generateCardDeck;

@end

@implementation FISCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        _remainingCards = [[NSMutableArray alloc] init];
        _dealtCards = [[NSMutableArray alloc] init];
        
        [self generateCardDeck];
    }
    return self;
}

-(void) generateCardDeck
{
    for (NSString *suit in [FISCard validSuits])
    {
        for (NSString *rank in [FISCard validRanks])
        {
            FISCard *card = [[FISCard alloc] initWithSuit:suit rank:rank];
            [self.remainingCards addObject:card];
        }
        
    }
}

-(FISCard *) drawNextCard
{
    NSUInteger length = [self.remainingCards count];
    if (length == 0) {
        NSLog(@"The deck is empty");
        return nil;
    } else {
        FISCard *card = self.remainingCards[length - 1];
        [self.dealtCards addObject:card];
        [self.remainingCards removeLastObject];
        
        return card;
    }
    
}

-(void ) resetDeck
{
    [self gatherDealtCards];
    [self shuffleRemainingCards];
}

-(void ) gatherDealtCards
{
    if (self.dealtCards != nil && [self.dealtCards count] > 0) {
        [self.remainingCards addObjectsFromArray:self.dealtCards];
        [self.dealtCards removeAllObjects];
    }
}

-(void ) shuffleRemainingCards
{
    if ([self.remainingCards count] > 0) {
        NSMutableArray *remainingCardsCopy = [self.remainingCards mutableCopy];
        NSUInteger count = [self.remainingCards count];
        [self.remainingCards removeAllObjects];
        
        NSUInteger i=0;
        while (i < count) {
            int randIndex = arc4random_uniform((unsigned int)remainingCardsCopy.count - 1);
            [self.remainingCards addObject:remainingCardsCopy[randIndex]];
            [remainingCardsCopy removeObjectAtIndex:randIndex];
            
            i++;
        }
    }
}

-(NSString *) description
{
    NSMutableString *description = [[NSMutableString alloc] init];
    [self shuffleRemainingCards];
    
    [description appendFormat:@"count: %lu\ncards: ", [self.remainingCards count]];
    
    for (FISCard *card in self.remainingCards) {
        [description appendFormat:@"%@ ", card.description];
    }

    return description;
}

@end
