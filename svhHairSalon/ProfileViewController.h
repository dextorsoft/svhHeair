//
//  ProfileViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ViewController.h"
#import "ForToolClass.h"

@interface ProfileViewController : ViewController{
    
    ForToolClass *forToolClass;
    
}

@property (weak, nonatomic) IBOutlet UIButton *btnMyImg;            //유저 사진
@property (weak, nonatomic) IBOutlet UIImageView *nameImg;          //유저 이름 아이콘
@property (weak, nonatomic) IBOutlet UIImageView *greetingImg;      //유저 인사말 아이콘
@property (weak, nonatomic) IBOutlet UIImageView *goodImg;          //유저 좋아요 아이콘
@property (weak, nonatomic) IBOutlet UIImageView *pointImg;         //유저 포인트 아이콘
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;            //유저 이름 라벨
@property (weak, nonatomic) IBOutlet UILabel *greetingLabel;        //유저 인사말 라벨
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;            //유저 좋아요 라벨
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;           //유저 포인트 라벨


- (IBAction)chageMyImg:(UIButton *)sender;


@end