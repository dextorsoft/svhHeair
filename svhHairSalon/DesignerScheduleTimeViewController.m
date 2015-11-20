//
//  DesignerScheduleTimeViewController.m
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "DesignerScheduleTimeViewController.h"

@interface DesignerScheduleTimeViewController ()

@end

@implementation DesignerScheduleTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindTime];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) bindTime {
    
    _designerScheduleTimeViewDataSource = [[DesignerScheduleTimeViewDataSource alloc] init];
    _designerScheduleTimeViewDataSource.delegate = self;
    _designerScheduleTimeViewDataSource.designerCutList = [NSArray arrayWithArray:_designerCutList];
    _tableView.dataSource = _designerScheduleTimeViewDataSource;
    _tableView.delegate = _designerScheduleTimeViewDataSource;
    [_tableView reloadData];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) TimeListSelectedIndex:(NSString *)selectedTime {
    
    
    [self performSegueWithIdentifier:@"cutSegue" sender:selectedTime];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"cutSegue"]) {
        DesignerCutListViewController *controller = (DesignerCutListViewController *)segue.destinationViewController;
        controller.designerCode = _designerCode;
        controller.reserveDate = _reserveDate;
        controller.reserveTime = sender;
    }
}

@end
