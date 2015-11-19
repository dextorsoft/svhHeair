//
//  JoinViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 1..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForToolClass.h"
#import "StatusHideViewController.h"
#import "SQLiteConnect.h"

@interface IntroViewController : StatusHideViewController {

    ForToolClass *GetHtmlParsing;
    
    NSString *IntroURL;     //배경화면 URL
    
    NSString *userId;       //Login 시 user 가 입력하는 Id
    NSString *userPass;     //Login 시 user 가 입력하는 Pass
    
}

@property (nonatomic, retain) IBOutlet UIWebView *WVIntroView;   //기본 화면 롤링 웹뷰

- (IBAction)BtnLogin:(UIButton *)sender;

#pragma mark - Navigation Setting
-(void)NavigationSetting;

- (BOOL)prefersStatusBarHidden;

@end
