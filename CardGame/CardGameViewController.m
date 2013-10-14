//
//  CardGameViewController.m
//  CardGame
//
//  Created by Ashton Wilson on 18/05/2013.
//  Copyright (c) 2013 Ashton Wilson. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation CardGameViewController


- (CardMatchingGame *) game
{
	if (!_game) _game = [[CardMatchingGame alloc]
						 initWithCardCount:self.cardButtons.count
						 usingDeck:[[PlayingCardDeck alloc] init]];
	return _game;
}


- (void) setCardButtons:(NSArray *)cardButtons
{
	_cardButtons = cardButtons;
	[self updateUI];
}

- (void)updateUI
{
	for (UIButton *cardButton in self.cardButtons) {
		Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
		[cardButton setTitle:card.contents forState:UIControlStateSelected];
		[cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
		cardButton.selected = card.isFaceUp;
		cardButton.enabled = !card.isUnplayable;
		cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
	}
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.messageLabel.text = [NSString stringWithFormat:@"%@", self.game.matchMessage];
}

- (void) setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
	NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
	[self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
	self.flipCount++;
	[self updateUI];
}

@end
