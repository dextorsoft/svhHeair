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
    
    ////////////////sqlite setting
    

    
    ////////////////
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
