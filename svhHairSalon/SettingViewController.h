//
//  SettingViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 12..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "ForToolClass.h"
#import "ArchivingConnect.h"

@interface SettingViewController : UITableViewController

- (IBAction)dropOutAction:(UIButton *)sender;       //계정 삭제

-(IBAction)dev_qna:(id)sender;      //개발자 문의하기

@end
