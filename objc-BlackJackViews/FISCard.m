//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Stacy Johnson on 11/21/15.
//  Copyright © 2015 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard()

@property (strong, nonatomic, readwrite) NSString *suit;
@property (strong, nonatomic, readwrite) NSString *rank;
@property (strong, nonatomic, readwrite) NSString *cardLabel;
@property (nonatomic, readwrite) NSUInteger cardValue;

@end

@implementation FISCard

- (instancetype)init
{
    return [self initWithSuit:@"!" rank:@"N"];
}

-(instancetype) initWithSuit:(NSString *)suit rank:(NSString *)rank
{
    self = [super init];
    
    if (self) {
        _suit = suit;
        _rank = rank;
        [self setCardLabel];
        [self setCardValue];
    }
    
    return self;
}


-(void) setCardValue
{
    if ([self.rank isEqualToString:@"A"]) {
        self.cardValue = 1;
    } else if ([self.rank isEqualToString:@"J"]) {
        self.cardValue = 10;
    } else if ([self.rank isEqualToString:@"Q"]) {
        self.cardValue = 10;
    } else if ([self.rank isEqualToString:@"K"]) {
        self.cardValue = 10;
    } else {
        self.cardValue = [self.rank intValue];
    }
}

-(void) setCardLabel
{
    self.cardLabel = [self.suit stringByAppendingString:self.rank];
}

-(NSString *) description
{
    return self.cardLabel;
}

+(NSArray *) validSuits
{
    NSString *spade = @"♠";
    NSString *heart = @"♥";
    NSString *club = @"♣";
    NSString *diamond = @"♦";
    
    return @[spade, heart, club, diamond];
}

+(NSArray *) validRanks
{
    return @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}


@end
