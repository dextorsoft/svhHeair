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
    
//    self.navigationController.navigationBar.translucent = YES;
//    self.tabBarController.tabBar.translucent = NO;
    
    _forTooClass = [[ForToolClass alloc] init];
    [self TitleSubSet];
    
    // 테이블뷰
    [self bindDesignSchedule];
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

#pragma 디자인 스케쥴 리스트 테이블 바인딩
- (void) bindDesignSchedule {
    
    _scheduleDetailTableViewDataSource = [[ScheduleDetailTableViewDataSource alloc] init];
    _scheduleDetailTableViewDataSource.delegate = self;
    _scheduleDetailTableViewDataSource.designList = [NSArray arrayWithArray:[self bindDesignerList]];
    _scheduleDetailTableViewDataSource.designDate  = [NSArray arrayWithArray:[self bindDesignerDate]];
    
    _tableView.dataSource = _scheduleDetailTableViewDataSource;
    _tableView.delegate = _scheduleDetailTableViewDataSource;
    [_tableView reloadData];
}

#pragma 디자이너 리스트 데이터
- (NSArray *) bindDesignerList {
    
    NSString *url = [NSString stringWithFormat:@"http://%s/m_list.php?m_Mode=4", KN_HOST_NAME];
    NSString *tableData = [_forTooClass GetHTMLString:url encoding:KN_SERVER_LANG];
    tableData = [tableData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableArray *designerArray = [[NSMutableArray alloc] init];
    
    if ([tableData isEqualToString:@"no"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"디자이너가 없습니다." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles: nil];
        [alertView show];
        return designerArray;
    }
    
    NSArray *tableArray = [tableData componentsSeparatedByString:@"<br>"];
    
    
    for (int i = 0; i < tableArray.count - 1; i++) {
        
        NSArray *tableObject = [[tableArray objectAtIndex:i] componentsSeparatedByString:@","];
        
        // 딕셔너리
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[tableObject objectAtIndex:0] forKey:@"code"];
        [dic setValue:[tableObject objectAtIndex:1] forKey:@"name"];
        [dic setValue:[tableObject objectAtIndex:5] forKey:@"part"];
        
        [designerArray addObject:dic];
    }
    
    return designerArray;
}

#pragma 디자이너 휴무일 / 예약시간 데이터
- (NSArray *) bindDesignerDate {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *dateString = [[prefs stringForKey:@"SelectDateString"] substringToIndex:[[prefs stringForKey:@"SelectDateString"] length] - 3];
    
    NSRange rangeY = {0, 4};
    NSRange rangeM = {5, 2};
    NSRange rangeD = {8, 2};
    
    dateString = [NSString stringWithFormat:@"%@-%@-%@", [dateString substringWithRange:rangeY], [dateString substringWithRange:rangeM],[dateString substringWithRange:rangeD]];
    
    NSString *url = [NSString stringWithFormat:@"http://%s/month_list.php?month=%@&type=3", KN_HOST_NAME, dateString];
    NSString *tableData = [_forTooClass GetHTMLString:url encoding:KN_SERVER_LANG];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    // 데이터 없음
    // 정상처리
    if ([tableData isEqualToString:@""]) {
        return dataArray;
    }
    
    // 데이터 있음 예외처리
    NSArray *tableArray = [tableData componentsSeparatedByString:@"<br>"];
    
    
    for (int i = 0; i < tableArray.count - 1; i++) {
        NSArray *tableObject = [[tableArray objectAtIndex:i] componentsSeparatedByString:@","];
        // 딕셔너리
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[tableObject objectAtIndex:0] forKey:@"code"];
        [dic setValue:[tableObject objectAtIndex:1] forKey:@"customerCode"];
        [dic setValue:[tableObject objectAtIndex:2] forKey:@"customerName"];
        [dic setValue:[tableObject objectAtIndex:3] forKey:@"designerCode"];
        [dic setValue:[tableObject objectAtIndex:4] forKey:@"designerName"];
        [dic setValue:[tableObject objectAtIndex:5] forKey:@"productName"];
        [dic setValue:[tableObject objectAtIndex:6] forKey:@"reserveDate"];
        
        [dataArray addObject:dic];
    }
    
    return dataArray;
}

#pragma 선택된 디자이너
- (void) DesignerListSelectedIndex:(NSString *) designerCode{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *dateString = [[prefs stringForKey:@"SelectDateString"] substringToIndex:[[prefs stringForKey:@"SelectDateString"] length] - 3];
    
    NSRange rangeY = {0, 4};
    NSRange rangeM = {5, 2};
    NSRange rangeD = {8, 2};
    
    dateString = [NSString stringWithFormat:@"%@-%@-%@", [dateString substringWithRange:rangeY], [dateString substringWithRange:rangeM],[dateString substringWithRange:rangeD]];
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:designerCode, @"designerCode", dateString, @"reserveDate", nil];
    
    [self performSegueWithIdentifier:@"designerSegue" sender:info];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // 디자이너 선택시
    if ([segue.identifier isEqualToString:@"designerSegue"]) {
        
        // 넘겨줄 Array
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        // 디자이너 스케쥴표 들고오기
        NSArray *designerCutList = [self bindDesignerDate];
        
        for (NSDictionary *dic in designerCutList) {
            
            if ([dic[@"designerCode"] isEqualToString:sender]) {
                NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
                [dataDic setValue:[dic objectForKey:@"reserveDate"] forKey:@"reserveDate"];
                [dataArray addObject:dataDic];
            }
        }
        
        DesignerScheduleTimeViewController *controller = (DesignerScheduleTimeViewController *)segue.destinationViewController;
        
        NSDictionary *dic = (NSDictionary *)sender;
        controller.designerCode = dic[@"designerCode"];
        controller.designerName = dic[@"designerName"];
        controller.reserveDate = dic[@"reserveDate"];
        controller.designerCutList = [NSArray arrayWithArray:dataArray];
    }
}

@end
