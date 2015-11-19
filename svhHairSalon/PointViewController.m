//
//  PointViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "PointViewController.h"

@interface PointViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *pointData;
    NSArray *pointArr;
}

@end

@implementation PointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Point";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self pointCallData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pointCallData{
    ForToolClass *forToolClass = [[ForToolClass alloc] init];
    pointData = [[NSMutableArray alloc] init];
    
    /****
     myNum, myDevice 는 sqlite 와 환경변수에서 가져와야함... 차후 수정
     ****/
    
    NSString *myNum = @"1";
    NSString *myDevice = @"12";
    
    NSString *pointURL = [NSString stringWithFormat:@"http://%s/m_point_list.php?my_num=%@&my_device=%@", KN_HOST_NAME, myNum ,myDevice];
    NSString *pointParse = [forToolClass GetHTMLString:pointURL encoding:KN_SERVER_LANG];
    pointParse = [pointParse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pointArr = [pointParse componentsSeparatedByString:@"<br>"];
    NSLog(@"pointArr == %@", pointArr);
    
    //for()
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
