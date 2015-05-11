//
//  EUExIndexBar.m
//  EUExIndexBar
//
//  Created by AppCan on 13-4-25.
//  Copyright (c) 2013年 AppCan. All rights reserved.
//

#import "EUExIndexBar.h"
#import "CMIndexBar_IB.h"
#import "EUtility.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@implementation EUExIndexBar
@synthesize m_indexBar;

-(void)open:(NSMutableArray *)inArguments{
    if (inArguments!=nil && [inArguments count]==4) {
        int inX = [[inArguments objectAtIndex:0] intValue];
        int inY = [[inArguments objectAtIndex:1] intValue];
        int inWidth = [[inArguments objectAtIndex:2] intValue];
        int inHeight = [[inArguments objectAtIndex:3] intValue];
        
        CMIndexBar_IB *temp_indexBar = [[CMIndexBar_IB alloc] initWithFrame:CGRectMake(inX, inY, inWidth, inHeight)];
        self.m_indexBar = temp_indexBar;
        [temp_indexBar release];
        [m_indexBar setBackgroundColor:[UIColor clearColor]];
        [m_indexBar setTextColor:RGBCOLOR(0, 127, 248)];
        [m_indexBar setHighlightedBackgroundColor:[UIColor clearColor]];
        m_indexBar.layer.cornerRadius = 24/2;
        m_indexBar.layer.masksToBounds = YES;
        NSArray *array = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",
                          @"G",@"H",@"I",@"J",@"K",
                          @"L",@"M",@"N",@"O",@"P",
                          @"Q",@"R",@"S",@"T",@"U",
                          @"V",@"W",@"X",@"Y",@"Z",nil];
        [m_indexBar setIndexes:array];
        [m_indexBar setDelegate:self];
        [EUtility brwView:meBrwView addSubview:m_indexBar];
    }
}

- (void)indexSelectionEndChange:(CMIndexBar_IB *)IndexBar{
   
}

-(void)onTouchResult:(NSString *)jsonData{
        jsonData = [jsonData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSString *jsString = [NSString stringWithFormat:@"uexIndexBar.onTouchResult(\"%@\");",jsonData];
    [self jsSuccessWithName:@"uexIndexBar.onTouchResult" opId:0 dataType:1 strData:jsonData];
}

- (void)indexSelectionDidChange:(CMIndexBar_IB *)IndexBar index:(int)index title:(NSString*)title{
    if ([title isKindOfClass:[NSString class]] && title.length>0) {
        [self onTouchResult:title];
    }
}

-(void)clean{
    if (m_indexBar) {
        [self.m_indexBar removeFromSuperview];
        self.m_indexBar = nil;
    }
}

-(void)close:(NSMutableArray *)inArguments{
    if (m_indexBar) {
        [self.m_indexBar removeFromSuperview];
        self.m_indexBar = nil;
    }
}

-(void)dealloc{
    if (m_indexBar) {
        [self.m_indexBar removeFromSuperview];
        self.m_indexBar = nil;
    }
    [super dealloc];
}

@end
