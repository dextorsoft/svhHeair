//
//  ScheduleDetailViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForToolClass.h"

@interface ScheduleDetailViewController : UIViewController{
    
}

@property NSString *testString;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) ForToolClass *forTooClass;

@end
