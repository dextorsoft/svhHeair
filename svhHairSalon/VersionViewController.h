//
//  VersionViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ViewController.h"
#import "ForToolClass.h"

@interface VersionViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *presentVersion;       //현재버전
@property (weak, nonatomic) IBOutlet UILabel *RecentVersion;        //최신버전

- (IBAction)provisionShow:(UIButton *)sender;                       //이용약관보기 btn

@end
