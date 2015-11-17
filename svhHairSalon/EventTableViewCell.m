//
//  EventTableViewCell.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
