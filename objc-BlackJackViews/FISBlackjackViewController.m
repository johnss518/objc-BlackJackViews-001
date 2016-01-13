//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Stacy Johnson on 12/5/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController()

@property (weak, nonatomic) IBOutlet UILabel *gameResultTxt;

@property (weak, nonatomic) IBOutlet UILabel *houseStayed;
@property (weak, nonatomic) IBOutlet UILabel *houseBusted;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackjack;
@property (weak, nonatomic) IBOutlet UILabel *houseScore;
@property (weak, nonatomic) IBOutlet UILabel *houseWins;
@property (weak, nonatomic) IBOutlet UILabel *houseLosses;

@property (weak, nonatomic) IBOutlet UILabel *houseCard1;
@property (weak, nonatomic) IBOutlet UILabel *houseCard2;
@property (weak, nonatomic) IBOutlet UILabel *houseCard3;
@property (weak, nonatomic) IBOutlet UILabel *houseCard4;
@property (weak, nonatomic) IBOutlet UILabel *houseCard5;

@property (weak, nonatomic) IBOutlet UILabel *playerStayed;
@property (weak, nonatomic) IBOutlet UILabel *playerBusted;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackjack;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *playerWins;
@property (weak, nonatomic) IBOutlet UILabel *playerLosses;

@property (weak, nonatomic) IBOutlet UILabel *playerCard1;
@property (weak, nonatomic) IBOutlet UILabel *playerCard2;
@property (weak, nonatomic) IBOutlet UILabel *playerCard3;
@property (weak, nonatomic) IBOutlet UILabel *playerCard4;
@property (weak, nonatomic) IBOutlet UILabel *playerCard5;

@property (weak, nonatomic) IBOutlet UIButton *btnDeal;
@property (weak, nonatomic) IBOutlet UIButton *btnHit;
@property (weak, nonatomic) IBOutlet UIButton *btnStay;

- (IBAction)dealNewGame:(id)sender;
- (IBAction)playerHit:(id)sender;
- (IBAction)playerStay:(id)sender;

@end


@implementation FISBlackjackViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    _game = [[FISBlackjackGame alloc] init];
    
    _btnDeal.enabled = YES;
    _btnHit.enabled = NO;
    _btnStay.enabled = NO;
    
    [_gameResultTxt setHidden:YES];
    [self updateView];
}

- (void)updateView {
 
    [self updatePlayerCards];
    [self updateHouseCards];
    [self updateLabels];
    [self updateScore];
    
}

- (void)updatePlayerCards {
    
    NSArray *playerCards = self.game.player.cardsInHand;
    
    if (playerCards.count == 0) {
        [_playerCard1 setHidden:YES];
        [_playerCard2 setHidden:YES];
        [_playerCard3 setHidden:YES];
        [_playerCard4 setHidden:YES];
        [_playerCard5 setHidden:YES];
    }
    
    for (NSUInteger i = 0; i < playerCards.count; i++) {
        if (i == 0) {
            [_playerCard1 setHidden:NO];
            _playerCard1.text = [playerCards[i] cardLabel];
        } else if (i == 1) {
            [_playerCard2 setHidden:NO];
            _playerCard2.text = [playerCards[i] cardLabel];
        } else if (i == 2) {
            [_playerCard3 setHidden:NO];
            _playerCard3.text = [playerCards[i] cardLabel];
        } else if (i == 3) {
            [_playerCard4 setHidden:NO];
            _playerCard4.text = [playerCards[i] cardLabel];
        } else if (i == 4) {
            [_playerCard5 setHidden:NO];
            _playerCard5.text = [playerCards[i] cardLabel];
        }
    }
    
}
- (void)updateHouseCards {
    NSArray *houseCards = self.game.house.cardsInHand;
    
    if (houseCards.count == 0) {
        [_houseCard1 setHidden:YES];
        [_houseCard2 setHidden:YES];
        [_houseCard3 setHidden:YES];
        [_houseCard4 setHidden:YES];
        [_houseCard5 setHidden:YES];
    }
    
    for (NSUInteger i = 0; i < houseCards.count; i++) {
        if (i == 0) {
            _houseCard1.text = [houseCards[i] cardLabel];
            [_houseCard1 setHidden:NO];
        } else if (i == 1) {
            _houseCard2.text = [houseCards[i] cardLabel];
            [_houseCard2 setHidden:NO];
        } else if (i == 2) {
            _houseCard3.text = [houseCards[i] cardLabel];
            [_houseCard3 setHidden:NO];
        } else if (i == 3) {
            _houseCard4.text = [houseCards[i] cardLabel];
            [_houseCard4 setHidden:NO];
        } else if (i == 4) {
            _houseCard5.text = [houseCards[i] cardLabel];
            [_houseCard5 setHidden:NO];
        }
    }
    
}

- (void)updateLabels {
    
    _houseBlackjack.hidden = !self.game.house.blackjack;
    _houseBusted.hidden = !self.game.house.busted;
    _houseStayed.hidden = !self.game.house.stayed;
    
    _playerBlackjack.hidden = !self.game.player.blackjack;
    _playerBusted.hidden = !self.game.player.busted;
    _playerStayed.hidden = !self.game.player.stayed;
}

- (void)updateScore {
    _playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", self.game.player.handscore ];
    _houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", self.game.house.handscore ];
}


- (IBAction)dealNewGame:(id)sender {
    
    [self.game.deck resetDeck];
    [self.game.player resetForNewGame];
    [self.game.house resetForNewGame];
    
    [_gameResultTxt setHidden:YES];
    [self updatePlayerCards];
    [self updateHouseCards];
    
    [self.game dealNewRound];
    
    _btnHit.enabled = YES;
    _btnStay.enabled = YES;
    
    [self updateView];
    
    if (![self.game.player shouldHit] || self.game.house.blackjack) {
        [self finishRound];
    }
    
    [self updateView];
}

- (IBAction)playerHit:(id)sender {
    
    [self.game processPlayerTurn];
    
    if (!self.game.player.busted) {
        [self.game processHouseTurn];
    }
    
    if (self.game.player.stayed || self.game.player.busted || self.game.house.busted)  {
        [self finishRound];
    }
    
    [self updateView];
}

- (IBAction)playerStay:(id)sender {
    
    self.game.player.stayed = YES;
    self.btnHit.enabled = NO;
    self.btnStay.enabled = NO;
    
    [self finishRound];
    [self updateView];
}


- (void) finishRound {
    
    _btnHit.enabled = NO;
    _btnStay.enabled = NO;
    
    if (!self.game.player.blackjack && !self.game.player.busted) {
        for (NSUInteger i= self.game.house.cardsInHand.count; i < 5; i++) {
            if (!self.game.house.busted) {
                [self.game processHouseTurn];
            } else break;
        }
    }
    
    [self updateWins];
}

- (void)updateWins {
  
    BOOL houseWon = self.game.houseWins;
    [self.game incrementWinsAndLossesForHouseWins:houseWon];
    
    [_gameResultTxt setHidden:NO];
    if (!houseWon) {
        _gameResultTxt.text = @"You Won!";
    } else {
        _gameResultTxt.text = @"You Lost!";
    }
    
    _playerWins.text = [[NSString alloc] initWithFormat: @"Wins: %lu", self.game.player.wins];
    _playerLosses.text = [[NSString alloc] initWithFormat: @"Losses: %lu", self.game.player.losses];
    
    _houseWins.text = [[NSString alloc] initWithFormat: @"Wins: %lu", self.game.house.wins];
    _houseLosses.text = [[NSString alloc] initWithFormat: @"Losses: %lu", self.game.house.losses];
}

@end
