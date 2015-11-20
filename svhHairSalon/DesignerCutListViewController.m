//
//  DesignerCutListViewController.m
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 20..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "DesignerCutListViewController.h"

@interface DesignerCutListViewController ()

@end

@implementation DesignerCutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _forTooClass = [[ForToolClass alloc] init];
    _designerCutListViewDataSource = [[DesignerCutListViewDataSource alloc] init];
    _designerCutListViewDataSource.cutArray = [NSArray arrayWithArray:[self bindCutList]];
    _tableView.dataSource = _designerCutListViewDataSource;
    _tableView.delegate = _designerCutListViewDataSource;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.    
    
}

#pragma 헤어 시술 리스트
- (NSArray *) bindCutList {
    
    NSString *url = [NSString stringWithFormat:@"http://%s/heir_style_list.php", KN_HOST_NAME];
    NSString *tableData = [_forTooClass GetHTMLString:url encoding:KN_SERVER_LANG];
    tableData = [tableData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *tableArray = [tableData componentsSeparatedByString:@"<br>"];
    NSMutableArray *cutArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < tableArray.count - 1; i++) {
        
        NSArray *tableObject = [[tableArray objectAtIndex:i] componentsSeparatedByString:@"|"];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[tableObject objectAtIndex:3] forKey:@"cutKind"];
        
        [cutArray addObject:dic];
    }
    
    return cutArray;
}

@end
