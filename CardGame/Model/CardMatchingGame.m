//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Ashton Wilson on 27/08/2013.
//  Copyright (c) 2013 Ashton Wilson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards; // of Cards
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *matchMessage;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
	if (!_cards) _cards = [[NSMutableArray alloc] init];
	return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
	self = [super init];
	
	if (self) {
		for (int i = 0; i < count; i++) {
			Card *card = [deck drawRandomCard];
			if (!card) {
				self = nil;
			} else {
				self.cards[i] = card;
			}
		}
	}
	
	return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
	return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	
	if (!card.isUnplayable) {
		if (!card.isFaceUp) {
			// flipping card creates a match?
			self.matchMessage = [NSString stringWithFormat: @"Flipped up %@", card.contents];
			NSLog(@"%@", self.matchMessage);
			for (Card *otherCard in self.cards) {
				if (otherCard.isFaceUp && !otherCard.isUnplayable) {
					int matchScore = [card match:@[otherCard]];
				
					if (matchScore) {
						// output the contents of cards
						self.matchMessage = [NSString stringWithFormat: @"Matched %@ and %@ for %d points", card.contents, otherCard.contents, matchScore*MATCH_BONUS];
						otherCard.unplayable = YES;
						card.unplayable = YES;
						self.score += matchScore * MATCH_BONUS;
						NSLog(@"%@", self.matchMessage);
					} else {
						self.matchMessage = [NSString stringWithFormat: @"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
						otherCard.faceUp = NO;
						self.score -= MISMATCH_PENALTY;
						NSLog(@"%@", self.matchMessage);
					}
					break;
				}
			}
			self.score -= FLIP_COST;
		}
		card.faceUp = !card.isFaceUp;
	}
}

@end
