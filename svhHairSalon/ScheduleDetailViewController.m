//
//  ScheduleDetailViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ScheduleDetailViewController.h"

@interface ScheduleDetailViewController (){

}

@end

@implementation ScheduleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _forTooClass = [[ForToolClass alloc] init];
    [self bindDesigner];
    
    ////////////////sqlite setting
    
    
    
    ////////////////
    
//    UIImage *navBack = [UIImage imageNamed:@"nav_back.png"];
    
    
//    [self.navigationController.navigationBar setBackgroundImage:navBack forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
    
    [self TitleSubSet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationBar Title Set
-(void)TitleSubSet{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *dateString = [[prefs stringForKey:@"SelectDateString"] substringToIndex:[[prefs stringForKey:@"SelectDateString"] length] - 3];
    
    //NSRange rangeY = {0, 4};
    NSRange rangeM = {5, 2};
    NSRange rangeD = {8, 2};
    
    dateString = [NSString stringWithFormat:@"%@월%@일", [dateString substringWithRange:rangeM],[dateString substringWithRange:rangeD]];
    self.navigationItem.title = dateString;;
    self.title = dateString;
    
    [prefs synchronize];
    ////////////
    //NSString *queryInsert = [NSString stringWithFormat:@"insert into sk_access(ki_Jdate) values(%@%@%@)", [dateString substringWithRange:rangeY],[dateString substringWithRange:rangeM],[dateString substringWithRange:rangeD]];
    
    /*if (sqlite3_exec(db, [queryInsert UTF8String], NULL, NULL, nil) != SQLITE_OK) {
        NSLog(@"Error insert Value : %@", queryInsert);
    }*/
    //[SQLiteConnect.self getDB];
    ////////////
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma 디자이너 바인딩
- (void) bindDesigner {
    
    NSString *url = [NSString stringWithFormat:@"http://%s/m_list.php?m_Mode=4",KN_HOST_NAME];
    NSString *tableData = [_forTooClass GetHTMLString:url encoding:KN_SERVER_LANG];
    tableData = [tableData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *tableArray = [tableData componentsSeparatedByString:@"<br>"];
    
    NSLog(@"로그");
//    if (tableArray.count > 0) {
//        
//    }
}

@end
