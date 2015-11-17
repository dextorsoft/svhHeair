//
//  ProfileViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController (){
    
}

/*
btnMyImg;            //유저 사진
nameImg;          //유저 이름 아이콘
greetingImg;      //유저 인사말 아이콘
goodImg;          //유저 좋아요 아이콘
pointImg;         //유저 포인트 아이콘
nameLabel;            //유저 이름 라벨
greetingLabel;        //유저 인사말 라벨
goodLabel;            //유저 좋아요 라벨
pointLabel;           //유저 포인트 라벨
*/

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    forToolClass = [[ForToolClass alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - hidden status bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)chageMyImg:(UIButton *)sender {
}
@end
