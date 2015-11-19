//
//  JoinViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 1..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController () <UITextFieldDelegate>

// Maintains a reference to the alert action that should be toggled when the text field changes (for the secure text entry alert).
@property (nonatomic, weak) UIAlertAction *loginTextAlertAction;

@end

@implementation IntroViewController

- (void)viewDidLoad {

    GetHtmlParsing = [[ForToolClass alloc] init];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self NavigationSetting];
    
    IntroURL = [NSString stringWithFormat:@"http://%s/top_bg.html",KN_HOST_NAME];
    [_WVIntroView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:IntroURL]]];

}

-(void)viewDidAppear:(BOOL)animated{
    //////////
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];      //환경변수 open
    
    NSString *userCheck = [prefs objectForKey:@"userCheck"];            //user 가 로그인 했는 지 체크하는 환경변수
    
    [prefs synchronize];
    
    //////////
    //[self performSegueWithIdentifier:@"AutoSignIn" sender:self];    //작동 확인 sqlite 에서 로그인 여부 확인 하고 넘기는 method 로 활용 20151104
}

-(void)viewWillAppear:(BOOL)animated{

    GetHtmlParsing = [[ForToolClass alloc] init];

    [self NavigationSetting];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)JoinVibrator:(UIButton *)sender {
    [GetHtmlParsing Vibrator];
}

-(void)NavigationSetting{
    self.navigationController.navigationBarHidden = YES;
    UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:navBarItem];
    
}

- (IBAction)BtnLogin:(UIButton *)sender {

    [self showLoginTextEntryAlert];
}

#pragma mark - UIAlertControllerStyleAlert Style Alerts

-(void)showLoginTextEntryAlert {
    
    NSString *title = NSLocalizedString(@"Sign In", nil);
    NSString *message = NSLocalizedString(@"Please Input your ID, Password", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"Submit", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //텍스트 필드
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
       //If you need to customized the text field, you can do so here.
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        
        textField.placeholder = @"ID";
        textField.keyboardType = UIKeyboardTypeAlphabet;
        
    }];
    
    //암호 텍스트 필드
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *passField){
        //If you need to customized the text field, you can do so here.
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:passField];
        
        passField.placeholder = @"password";
        passField.secureTextEntry = YES;    //TextFiled secure set
        
    }];
    
    //Action part!
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"Cancel Action!!");
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        userId = alertController.textFields.firstObject.text;    //Id textField 텍스트 가져오기
        userPass = alertController.textFields.lastObject.text;  //Pass passField 텍스트 가져오기
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *userToken = [prefs objectForKey:@"m_Device"];
        [prefs synchronize];
        NSLog(@"Submit Action!! == %@ ,,, %@",userId,userPass);
        /////////if 문 web 에서 id, pw 유무 확인 및 체크
        
        NSString *login = [NSString stringWithFormat:@"http://%s/m_login_check.php?m_Id=%@&m_st_pass=%@&m_device=%@", KN_HOST_NAME, userId, userPass, userToken];
        
        NSString *loginCheck = [GetHtmlParsing GetHTMLString:login encoding:KN_SERVER_LANG];  //아이디가 없을 경우 = nosearch, 비밀번호가 없을 경우 = nopass, 이외 = error
        
        if(([loginCheck isEqualToString:@"error"] || [loginCheck isEqualToString:@"null"] || [loginCheck isEqualToString:@""])){
            
            UIAlertController *loginWarn = [UIAlertController alertControllerWithTitle:@"접속이 올바르지 않습니다. 확인 후 다시 시도 하세요"
                                                                                    message:nil
                                                                             preferredStyle:UIAlertControllerStyleAlert];
            [loginWarn addAction:({
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"check"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action) {
                                                                   //action nil;
                                                               }];
                action;
            })];
            
            [self presentViewController:loginWarn animated:YES completion:nil];
        }else if([[loginCheck stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"nosearch"]){
            
            UIAlertController *warnAlert = [UIAlertController alertControllerWithTitle:@"존재하지 않는 아이디 입니다."
                                                                               message:nil
                                                                        preferredStyle:UIAlertControllerStyleActionSheet];
            
            
        }
        
        [self performSegueWithIdentifier:@"SignIn" sender:nil];
    }];
    
    // The text field initially has no text in the text field, so we'll disable it.
    otherAction.enabled = NO;
    
    // Hold onto the secure text alert action to toggle the enabled/disabled state when the text changed.
    self.loginTextAlertAction = otherAction;
    
    //Add Action!!
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITextFieldTextDidChangeNotification

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
    
    // Enforce a minimum length of >= 5 characters for secure text alerts.
    self.loginTextAlertAction.enabled = textField.text.length >= 2;
}

@end