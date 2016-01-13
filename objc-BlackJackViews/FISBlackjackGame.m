//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Stacy Johnson on 11/23/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _deck = [[FISCardDeck alloc] init];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
    }
    return self;
}

-(void) playBlackjack
{

    [self.deck resetDeck];
    [self.player resetForNewGame];
    [self.house resetForNewGame];
    
    [self dealNewRound];
    
    for (NSUInteger i=0; i < 3; i++) {
        [self processPlayerTurn];
        if (self.player.busted) break;
    
        [self processHouseTurn];
        if (self.house.busted) break;
    }
    
    BOOL houseWins = self.houseWins;
    [self incrementWinsAndLossesForHouseWins:houseWins];
    
    NSLog(@"Player: \n%@", self.player);
    NSLog(@"House: \n%@", self.house);
}

-(void) dealNewRound
{
    [self dealCardToPlayer];
    [self dealCardToHouse];
    [self dealCardToPlayer];
    [self dealCardToHouse];
}

-(void) dealCardToPlayer
{
    FISCard *card = [self.deck drawNextCard];
    [self.player acceptCard:card];
}

-(void) dealCardToHouse
{
    FISCard *card = [self.deck drawNextCard];
    [self.house acceptCard:card];
    
}

-(void) processPlayerTurn
{
    if ([self.player shouldHit]) {
        [self dealCardToPlayer];
    }
}

-(void) processHouseTurn
{
    if ([self.house shouldHit]) {
        [self dealCardToHouse];
    }
    
}

-(BOOL) houseWins
{
    if ([self.player blackjack] && [self.house blackjack]) {
        return NO;
    }
    
    if ([self.house busted]) {
        return NO;
    }
    
    if ([self.player busted]) {
        return YES;
    }
    
    if (self.house.handscore >= self.player.handscore ) {
        return YES;
    }
    
    return NO;
}

-(void) incrementWinsAndLossesForHouseWins:(BOOL)houseWins
{
    if (houseWins) {
        self.house.wins++;
        self.player.losses++;
        NSLog(@"The house wins");
    } else {
        self.house.losses++;
        self.player.wins++;
        NSLog(@"The player wins");
    }
}

@end
