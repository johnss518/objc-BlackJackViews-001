//
//  FISBlackjackPlayer.h
//  BlackJack
//
//  Created by Stacy Johnson on 11/23/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISCard.h"

@interface FISBlackjackPlayer : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *cardsInHand;
@property (nonatomic) BOOL aceInHand, blackjack, busted, stayed;
@property (nonatomic) NSUInteger handscore, wins, losses;


-(instancetype) initWithName:(NSString *)name;
-(void) resetForNewGame;
-(void) acceptCard:(FISCard *)card;
-(BOOL) shouldHit;

@end
