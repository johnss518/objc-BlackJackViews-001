//
//  FISCardDeck.h
//  OOP-Cards-Model
//
//  Created by Stacy Johnson on 11/21/15.
//  Copyright © 2015 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISCard.h"

@interface FISCardDeck : NSObject

@property (strong, nonatomic) NSMutableArray *remainingCards;
@property (strong, nonatomic) NSMutableArray *dealtCards;

-(FISCard *) drawNextCard;
-(void ) resetDeck;
-(void ) gatherDealtCards;
-(void ) shuffleRemainingCards;

@end
