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
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
		cardButton.alpha = card.isMatched ? 0.3 : 1.0;
	}
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.messageLabel.text = [NSString stringWithFormat:@"%@", self.game.matchMessage];
}

- (NSString *)titleForCard:(Card *)card
{
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
	return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)flipCard:(UIButton *)sender
{
	[self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
	[self updateUI];
}

- (IBAction)redealCards:(id)sender {
	self.game = [self.game initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
	[self updateUI];

}
- (IBAction)gameMode:(id)sender {
}
@end
