//
//  DesignerScheduleTimeViewController.h
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerScheduleTimeViewDataSource.h"
#import "DesignerCutListViewController.h"


@interface DesignerScheduleTimeViewController : UIViewController<DesignerScheduleTimeViewDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *designerCutList;

@property (strong, nonatomic) NSString *designerCode;

@property (strong, nonatomic) NSString *designerName;

@property (strong, nonatomic) NSString *reserveDate;

@property (strong, nonatomic) DesignerScheduleTimeViewDataSource *designerScheduleTimeViewDataSource;

@end
