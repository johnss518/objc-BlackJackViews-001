//
//  FISCard.h
//  OOP-Cards-Model
//
//  Created by Stacy Johnson on 11/21/15.
//  Copyright © 2015 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISCard : NSObject

@property (strong, nonatomic, readonly) NSString *suit;
@property (strong, nonatomic, readonly) NSString *rank;
@property (strong, nonatomic, readonly) NSString *cardLabel;
@property (nonatomic, readonly) NSUInteger cardValue;


+(NSArray *) validSuits;
+(NSArray *) validRanks;

-(instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;

@end
