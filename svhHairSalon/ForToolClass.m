//
//  WebParsingClass.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 13..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ForToolClass.h"

@implementation ForToolClass

////////////
int kn_connecterror;
////////////

////////////////////////////////////////////////////////////////
//Keyboard Animation
#pragma mark - Keyboard Boolean

-(void) keyboardWillShow:(NSNotification *)note moveView:(UIView*)moveView{
    NSLog(@"keyboardWillShow");
    if (setMoveCnt <= 0) {
        [self setViewMoveUP:YES moveView:moveView];
    }
}

-(void) keyboardWillHide:(NSNotification *)note moveView:(UIView*)moveView{
    NSLog(@"keyboardWillHide");
    [self setViewMoveUP:setMoveChk moveView:moveView];
}

#pragma mark - setViewMove Animation method

-(void)setViewMoveUP:(BOOL)movedUp moveView:(UIView*)moveView{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = moveView.frame;
    
    if (movedUp) {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        setMoveChk = NO;
        setMoveCnt += 1;
    }else{
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        setMoveChk = YES;
        setMoveCnt = 0;
    }
    moveView.frame = rect;
    
    [UIView commitAnimations];
}
////////////////////////////////////////////////////////////////

#pragma mark - NSDate <-> NSString
-(NSDate *)getDateFromSting:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH Z"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

-(NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy MM dd HH"];
    NSString *string = [dateFormatter stringFromDate:date];
    return string;
}

//////////////////
#pragma mark - Html Parsing
//html Get Type parsing method...
- (NSString *)GetHTMLString:(NSString *)urlStr encoding:(int)enc
{
    NSLog(@"urlStr == %@", urlStr);
    //NSString *make_url = [NSString stringWithFormat:urlStr];
    NSError *error=nil;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:enc];
    NSLog(@"urlStr22222 == %@", urlStr);
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"%20" withString:@""];
    NSLog(@"urlStr33333 == %@", urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"url== %@", url);
    NSMutableURLRequest *loginRequest = [NSMutableURLRequest requestWithURL:url];
    NSLog(@"loginRequest == %@", loginRequest);
    NSHTTPURLResponse *response = nil;//NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:loginRequest returningResponse:&response error:&error];
    NSString *strHtml = [[NSString alloc] initWithData:responseData encoding:enc];
    if (!error) kn_connecterror=0;
    else kn_connecterror=1;
    NSLog(@"error=%d",errno);
    return strHtml;
}
#pragma mark - For Vibrator
////////////////////////진동 메소드
- (void)Vibrator{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

@end
