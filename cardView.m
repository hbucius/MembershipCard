//
//  cardView.m
//  MembershipCard
//
//  Created by mstr on 5/10/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "cardView.h"

@implementation cardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CALayer *layer=[self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5];
    
}

@end
