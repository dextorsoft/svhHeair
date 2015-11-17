//
//  CommunityViewControllerTableViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AsyncAndCache.h"
#import "ForToolClass.h"
#import "CommunityTableViewCell.h"
#import "CommunityDetailViewController.h"

@interface CommunityTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>{
    
    CommunityTableViewCell *communityTableViewCell;
    
    NSString *URL;          //htmlparsing NSString
    NSString *TableData;    //parsing data NSString
    NSArray *TableArray;     //TableData Seperating
    NSArray *TableArrayObject;
    //NSString *TableIndexNo;
    NSArray *TableIndexNoArray;
}

- (IBAction)RefreshView:(UIRefreshControl *)sender;

@end
