//
//  EventTableViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForToolClass.h"
#import "UIImageView+AsyncAndCache.h"
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"

@interface EventTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{

    EventTableViewCell *eventTableViewCell;
    
    NSString *URL;              //htmlparsing NSString
    NSString *TableData;        //parsing data NSString
    NSArray *TableArray;        //TableData Seperating
    NSArray *TableIndexNoArray;
}

- (IBAction)RefreshView:(UIRefreshControl *)sender;     //Referesh Action;

@end
