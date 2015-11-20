//
//  ScheduleDetailTableViewCell.h
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 18..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *designerImage;

@property (weak, nonatomic) IBOutlet UILabel *lbl_designerName;

@property (weak, nonatomic) IBOutlet UILabel *lbl_reserveYN;

@property (weak, nonatomic) IBOutlet UIView *roundView;

@end
