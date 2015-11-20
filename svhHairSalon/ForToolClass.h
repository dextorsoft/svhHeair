//
//  WebParsingClass.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 13..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#define kOFFSET_FOR_KEYBOARD 215.0      //키보드 크기

@interface ForToolClass : NSObject{
    
    BOOL setMoveChk;    //softkeyboard animarion chk;
    int setMoveCnt;     //softKeyboard animation cnt;
    
}

- (NSDate *)getDateFromSting:(NSString *)string;
- (NSString *)getStringFromDate:(NSDate *)date;
- (NSString *)GetHTMLString:(NSString *)urlStr encoding:(int)enc;
- (void)Vibrator;

@end
