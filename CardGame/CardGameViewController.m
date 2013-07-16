//
//  CardGameViewController.m
//  CardGame
//
//  Created by Ashton Wilson on 18/05/2013.
//  Copyright (c) 2013 Ashton Wilson. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

- (PlayingCardDeck *) deck
{
	if (!_deck) _deck = [[PlayingCardDeck alloc] init];
	return _deck;
}

- (void) setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
	NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
	// get a new random card
//	self.deck = [[PlayingCardDeck alloc] init];
	Card *newCard = [self.deck drawRandomCard];
	
	// set the button title to the new card contents
	[sender setTitle:newCard.contents forState:sender.selected];

	sender.selected = !sender.isSelected;
	self.flipCount++;
}

@end
