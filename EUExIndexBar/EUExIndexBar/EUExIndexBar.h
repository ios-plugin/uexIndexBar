//
//  EUExIndexBar.h
//  EUExIndexBar
//
//  Created by AppCan on 13-4-25.
//  Copyright (c) 2013年 AppCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EUExBase.h"
#import "CMIndexBar_IB.h"

@interface EUExIndexBar : EUExBase<CMIndexBarDelegate>{
    CMIndexBar_IB *m_indexBar;
}

@property (nonatomic, retain)CMIndexBar_IB *m_indexBar;
@end
