//
//  VersionViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 17..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "VersionViewController.h"

@interface VersionViewController (){
    ForToolClass *getHtml;
    NSString *recentVerString;
}

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //NSString *appDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];       //plist 에서 버전 정보 가져오기
    //NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    [_presentVersion setText:[NSString stringWithFormat:@"현재 버전   %@", majorVersion]];      //현재 버전 settext
    
    getHtml = [[ForToolClass alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://%s/m_setup_check.php?m_Code=1",KN_HOST_NAME];
    NSString *parseString = [getHtml GetHTMLString:url encoding:KN_SERVER_LANG];
    NSLog(@"parseString == %@", parseString);
    if ([parseString isEqualToString:@""] || parseString == nil || parseString.length == 0 || [parseString isEqualToString:@"error"]) {
        [self TextLengthWarning:@"통신상태가 좋지 않습니다. 확인 후 다시 시도 하세요."];
    }else{
        NSMutableArray *webVersion = [[NSMutableArray alloc] initWithArray:[parseString componentsSeparatedByString:@"|"]];
        recentVerString = [webVersion objectAtIndex:8];
    }
    
    [_RecentVersion setText:[NSString stringWithFormat:@"최신 버전   %@",recentVerString]];       //최신 버전settext
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)provisionShow:(UIButton *)sender {
    NSString *title = NSLocalizedString(@"이용약관", nil);
    NSString *message = NSLocalizedString(@"본 어플리케이션은 \n제공하는 쪽지 시스템은 APNS 서비스를 이용합니다. \n\n- 가입 및 입력된 모든 데이터는 (주)케이엠소프트 서버에 저장되며 SVH 를 위한 수단 이외에는 사용하지 않습니다. \n\n- 무선인터넷(Wi-Fi)을 이용한 전송은 무료이며, 3G/4G를 이용한 전송의 경우 요금제에 따라 별도의 데이터 요금이 발생할 수 있습니다.", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"확인", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //////nothing
    }];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - hidden status bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

////////////////////////
#pragma mark - AlertController Part
//AlertController TextLengthWarning;
-(void)TextLengthWarning:(NSString *)where{
    UIAlertController *textLengthWarn = [UIAlertController alertControllerWithTitle:where
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
    [textLengthWarn addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"check"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           //action nil;
                                                       }];
        action;
    })];
    [self presentViewController:textLengthWarn animated:YES completion:nil];
}
////////////////////

@end
