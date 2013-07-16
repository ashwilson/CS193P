//
//  Deck.h
//  CardGame
//
//  Created by Ashton Wilson on 18/05/2013.
//  Copyright (c) 2013 Ashton Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *) drawRandomCard;

@end
