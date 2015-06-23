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
    if (inArguments!=nil && [inArguments count]>3) {
        int inX = [[inArguments objectAtIndex:0] intValue];
        int inY = [[inArguments objectAtIndex:1] intValue];
        int inWidth = [[inArguments objectAtIndex:2] intValue];
        int inHeight = [[inArguments objectAtIndex:3] intValue];
        
        CMIndexBar_IB *temp_indexBar = [[CMIndexBar_IB alloc] initWithFrame:CGRectMake(inX, inY, inWidth, inHeight)];
        self.m_indexBar = temp_indexBar;
        [temp_indexBar release];


     

        NSArray *array = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",
                     @"G",@"H",@"I",@"J",@"K",
                     @"L",@"M",@"N",@"O",@"P",
                     @"Q",@"R",@"S",@"T",@"U",
                     @"V",@"W",@"X",@"Y",@"Z",nil];
        UIColor *textColor =RGBCOLOR(0, 127, 248);
        
        
        if([inArguments count]>4 &&[[inArguments objectAtIndex:4] isKindOfClass:[NSString class]]){
            NSError *error = nil;
            NSData *jsonData= [[inArguments objectAtIndex:4] dataUsingEncoding:NSUTF8StringEncoding];
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&error];
            if([jsonObject isKindOfClass:[NSDictionary class]]){
                if([jsonObject objectForKey:@"indices"]){
                    array =[jsonObject objectForKey:@"indices"];
                }
                if([jsonObject objectForKey:@"textColor"]){
                    textColor=[self returnUIColorFromHTMLStr:[jsonObject objectForKey:@"textColor"]];
                }
            }
        }
        [m_indexBar setBackgroundColor:[UIColor clearColor]];
        
        
        [m_indexBar setHighlightedBackgroundColor:[UIColor clearColor]];
        m_indexBar.layer.cornerRadius = 24/2;
        m_indexBar.layer.masksToBounds = YES;
        [m_indexBar setTextColor:textColor];
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




#define END return [UIColor blackColor]

-(UIColor *)returnUIColorFromHTMLStr:(NSString *)colorString{
    colorString=[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([colorString hasPrefix:@"#"]){
        
        unsigned int r,g,b,a;
        
        NSRange range;
        NSMutableArray *colorArray=[NSMutableArray arrayWithCapacity:4];
        switch ([colorString length]) {
            case 4://"#123"型字符串
                [colorArray addObject:@"ff"];
                for(int k=0;k<3;k++){
                    range.location=k+1;
                    range.length=1;
                    NSMutableString *tmp=[[colorString substringWithRange:range] mutableCopy];
                    [tmp  appendString:tmp];
                    [colorArray addObject:tmp];
                    
                }
                break;
            case 7://"#112233"型字符串
                [colorArray addObject:@"ff"];
                for(int k=0;k<3;k++){
                    range.location=2*k+1;
                    range.length=2;
                    [colorArray addObject:[colorString substringWithRange:range]];
                    
                }
                break;
            case 9://"#11223344"型字符串
                for(int k=0;k<4;k++){
                    range.location=2*k+1;
                    range.length=2;
                    [colorArray addObject:[colorString substringWithRange:range]];
                }
                break;
                
            default:
                END;
                break;
        }
        [[NSScanner scannerWithString:colorArray[0]] scanHexInt:&a];
        [[NSScanner scannerWithString:colorArray[1]] scanHexInt:&r];
        [[NSScanner scannerWithString:colorArray[2]] scanHexInt:&g];
        [[NSScanner scannerWithString:colorArray[3]] scanHexInt:&b];
        
        return [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:(float)a/255.0];
    }
    if (([colorString hasPrefix:@"RGB("]||[colorString hasPrefix:@"rgb("])&&[colorString hasSuffix:@")"]){
        colorString=[colorString substringWithRange:NSMakeRange(4, [colorString length] -5)];
        return [self returnColorWithRGBAArray:[colorString componentsSeparatedByString:@","]];
    }
    if (([colorString hasPrefix:@"RGBA("]||[colorString hasPrefix:@"rgba("])&&[colorString hasSuffix:@")"]){
        colorString=[colorString substringWithRange:NSMakeRange(5, [colorString length] -6)];
        return [self returnColorWithRGBAArray:[colorString componentsSeparatedByString:@","]];
    }
    END;
    
    
}

-(UIColor*) returnColorWithRGBAArray:(NSArray *)rgbaStr{
    if([rgbaStr count]<3) END;
    NSMutableArray *rgb=[NSMutableArray array];
    NSString *alpha=@"1";
    if([rgbaStr count]>3 && [rgbaStr[3] isKindOfClass:[NSString class]]){
        alpha=[rgbaStr[3] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    for(int i=0;i<3;i++) {
        if(![rgbaStr[i] isKindOfClass:[NSString class]]) END;
        NSString *str=rgbaStr[i];
        str=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if([str hasSuffix:@"%"]){
            str=[str substringWithRange:NSMakeRange(0, [str length] - 1)];
            [rgb addObject:[NSNumber numberWithFloat:([str floatValue]*255.0f/100.0f)]];
        }else{
            [rgb addObject:[NSNumber numberWithFloat:[str floatValue]]];
        }
    }
    return [UIColor colorWithRed:[rgb[0] floatValue] green:[rgb[1] floatValue] blue:[rgb[2] floatValue] alpha:[alpha floatValue]];
    
    
}

@end
