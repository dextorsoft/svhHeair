//
//  DesignerCutListViewController.h
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 20..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForToolClass.h"
#import "DesignerCutListViewDataSource.h"

@interface DesignerCutListViewController : UIViewController

@property (strong, nonatomic) ForToolClass *forTooClass;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) DesignerCutListViewDataSource *designerCutListViewDataSource;

@end
