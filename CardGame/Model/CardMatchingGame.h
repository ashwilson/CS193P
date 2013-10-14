//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Ashton Wilson on 27/08/2013.
//  Copyright (c) 2013 Ashton Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id) initWithCardCount: (NSUInteger)count
			   usingDeck: (Deck *)deck;


- (void) flipCardAtIndex: (NSUInteger)index;

- (Card *) cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *matchMessage;

@end
