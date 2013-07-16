//
//  Card.h
//  CardGame
//
//  Created by Ashton Wilson on 18/05/2013.
//  Copyright (c) 2013 Ashton Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int) match:(NSArray *)otherCards;


@end
