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
			for (Card *otherCard in self.cards) {
				if (otherCard.isFaceUp && !otherCard.isUnplayable) {
					int matchScore = [card match:@[otherCard]];
					if (matchScore) {
						otherCard.unplayable = YES;
						card.unplayable = YES;
						self.score += matchScore * MATCH_BONUS;
					} else {
						otherCard.faceUp = NO;
						self.score -= MISMATCH_PENALTY;
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
