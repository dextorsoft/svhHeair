//
//  CommunityTableViewCell.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 15..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *WriterLabel;      //작성자
@property (weak, nonatomic) IBOutlet UILabel *ContentLabel;     //작성내용
@property (weak, nonatomic) IBOutlet UIImageView *WriterImage;  //작성자 사진 이미지
@property (weak, nonatomic) IBOutlet UIImageView *FileImage;    //작성 파일 및 사진 이미지

@end
