//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Stacy Johnson on 11/23/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@interface FISBlackjackPlayer()

-(void) checkIfBlackjack;
-(void) checkIfBusted;

@end

@implementation FISBlackjackPlayer

- (instancetype)init
{
    return [self initWithName:@""];
}

-(instancetype) initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _name = name;
        
        _cardsInHand = [[NSMutableArray alloc] init];
        
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        
        _handscore = 0;
        _wins = 0;
        _losses = 0;
    }
    
    return self;
    
}

-(void) resetForNewGame
{
    if ([self.cardsInHand count] > 0) {
        [self.cardsInHand removeAllObjects];
        self.handscore = 0;
    }

    self.aceInHand = NO;
    self.stayed= NO;
    self.blackjack = NO;
    self.busted = NO;
}

-(void) acceptCard:(FISCard *)card
{
    if (card != nil) {
        [self.cardsInHand addObject:card];
        [self updateScore];
        [self checkIfBlackjack];
        [self checkIfBusted];
    }
}

-(BOOL) shouldHit
{
    if (self.busted) {
        return NO;
    }
    
    if (self.stayed) {
        return NO;
    }
    
    if (self.blackjack) {
        return NO;
    }
    
    if (self.handscore > 16) {
        self.stayed = YES;
        return NO;
    }
    
    return YES;
}

-(void) updateScore
{
    self.handscore = 0;
    
    for (FISCard *card in self.cardsInHand) {
        self.handscore += card.cardValue;
        
        if (card.cardValue == 1) {
            self.aceInHand = YES;
            
            if (self.handscore <= 11) {
                self.handscore += 10;
            }
        }
    }
}

-(void) checkIfBlackjack
{
    if (self.handscore == 21) {
        self.blackjack = YES;
    }
    
}

-(void) checkIfBusted
{
    if (self.handscore > 21) {
        self.busted = YES;
    }
}

-(NSString *)description
{

    NSMutableString *description = [[NSMutableString alloc] init];
    [description appendFormat:@"name: %@\n", self.name];
    
    [description appendFormat:@"cards: "];
    for (FISCard *card in self.cardsInHand) {
        [description appendFormat:@"%@ ", card.description];
    }
    
    [description appendFormat:@"\n"];
    [description appendFormat:@"handscore: %lu\n", self.handscore];
    [description appendFormat:@"ace in hand: %d\n", self.aceInHand];
    [description appendFormat:@"stayed: %d\n", self.stayed];
    [description appendFormat:@"blackjack: %d\n", self.blackjack];
    [description appendFormat:@"busted: %d\n", self.busted];
    [description appendFormat:@"wins: %lu\n", self.wins];
    [description appendFormat:@"losses: %lu\n", self.losses];
   
    return description; 
}

@end
