//
//  indexBar.h
//
//  Created by Craig Merchant on 07/04/2011.
//  Copyright 2011 RaptorApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCore/QuartzCore.h"

@protocol CMIndexBarDelegate;

@interface CMIndexBar_IB : UIView {
	NSObject<CMIndexBarDelegate> *delegate;
	
	UIColor *highlightedBackgroundColor;
	UIColor *textColor;
}

- (id)init;
- (id)initWithFrame:(CGRect)frame;
- (void) setIndexes:(NSArray*)indexes;
- (void) clearIndex;

@property (nonatomic, assign) NSObject<CMIndexBarDelegate> *delegate;
@property (nonatomic, retain) UIColor *highlightedBackgroundColor;
@property (nonatomic, retain) UIColor *textColor;

@end

@protocol CMIndexBarDelegate<NSObject>
@optional
- (void)indexSelectionDidChange:(CMIndexBar_IB *)IndexBar index:(int)index title:(NSString*)title;
- (void)indexSelectionEndChange:(CMIndexBar_IB *)IndexBar;
@end