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
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    _forTooClass = [[ForToolClass alloc] init];
    _designerCutListViewDataSource = [[DesignerCutListViewDataSource alloc] init];
    _designerCutListViewDataSource.delegate = self;
    _designerCutListViewDataSource.cutArray = [NSArray arrayWithArray:[self bindCutList]];
    _tableView.dataSource = _designerCutListViewDataSource;
    _tableView.delegate = _designerCutListViewDataSource;
    [_tableView reloadData];
    
    self.navigationItem.title = @"스타일 선택";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.    
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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

- (void) CutSelectedIndex:(NSIndexPath *)indexPath {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"몇월 몇시 예약등록" delegate:self cancelButtonTitle:nil otherButtonTitles:@"예약", @"취소", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.placeholder = @"요청사항을 입력하세요.";
    [alertView show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            
            // 예약
            // 프로토콜 호출
            
            break;
        
        case 1:
            // 취소
            
            break;
            
        default:
            
            break;
    }
}

- (IBAction)ac_btn_closeModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
