//
//  ScheduleViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 12..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "ScheduleDetailViewController.h"
#import "ForToolClass.h"
#import "StatusHideViewController.h"



@interface ScheduleViewController : UIViewController <UIGestureRecognizerDelegate, CalendarDataSource, CalendarDelegate>{
 
    ForToolClass *forToolClass;
    ScheduleDetailViewController *scheduleDetail;
    
}

@end
