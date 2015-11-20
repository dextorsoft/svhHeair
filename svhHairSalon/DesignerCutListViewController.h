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



@interface DesignerCutListViewController : UIViewController<DesignerCutListViewDataSourceDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) ForToolClass *forTooClass;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)ac_btn_closeModal:(id)sender;

@property (strong, nonatomic) DesignerCutListViewDataSource *designerCutListViewDataSource;

@property (strong, nonatomic) NSString *designerCode;

@property (strong, nonatomic) NSString *reserveDate;

@property (strong, nonatomic) NSString *reserveTime;

@end
