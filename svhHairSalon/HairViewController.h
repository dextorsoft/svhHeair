//
//  HairViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 22..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForToolClass.h"
#import "UIImageView+AsyncAndCache.h"
#import "StackTableView.h"
#import "StatusHideViewController.h"
#import "HairDetailViewController.h"

@interface HairViewController : StatusHideViewController{
    
    NSString *indexRowCode;
    int indexRow;
    
}

@property (strong, nonatomic) IBOutlet StackTableView *tableView;

@end
