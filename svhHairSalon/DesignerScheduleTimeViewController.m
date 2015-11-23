//
//  DesignerScheduleTimeViewController.m
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//  디자이너 타임 테이블

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

- (void) TimeListSelectedIndex:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"cutSegue" sender:nil];
}


@end
