//
//  AppDelegate.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 1..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSDictionary *aps =[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (aps != nil) {
        
        [self application:application didReceiveRemoteNotification:aps];
        
    }else{

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:
                                                                                 (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            
        }else{
            
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
            
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - apple push delegate method
///////////////////
//push : APNS 에 장치 등록 성공시 자동실행
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *device_token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"deviceToken : %@", device_token);
    
    //Token 환경변수에 넣기
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //환경변수 시작
    [prefs setObject:device_token forKey:@"m_Device"];              //Token 저장
    [prefs synchronize];                                            //환경변수 끝
    
    
    
    //토큰을 읽어서 디비에 집어 넣는다.
    //[self initDB];
    //[self openDataBase];
    //회원가입후 결과값저장
    //char *error=NULL;
    //NSString *query = [NSString stringWithFormat:@"insert into my_token (ul_token) values('%@')",device_token];
    //NSLog(@"%@",query);
    //if (sqlite3_exec(database, [query UTF8String], NULL, 0, &error)!=SQLITE_OK){
        
        //NSLog(@"TABLE token insert ERROR: %s", error);
    //    sqlite3_free(error);
        
        //저장후 되돌아기기 로직
        //   sqlite3_finalize(statement);
    
    //}
    // sqlite3_close(database);
    //[self closeDataBase];
    
}

//push : APNS 에 장치 등록 오류시 자동실행
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"deviceToken error : %@", error);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
/*
    application.applicationIconBadgeNumber=0;
    
    UIApplicationState state = [application applicationState];
    
    // NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSDictionary *aps_id=[userInfo valueForKey:@"sid"];
    [self insertPushData:[aps_id valueForKey:@"sendId"]];
    
    //이부분에 친구추가여부 확인후 쪽지뿌려주기작업하기
    
    UIView *check_view =[[[[UIApplication sharedApplication] keyWindow] subviews]objectAtIndex:0];
    
    //aaa 이면 어플 실행 상태  bbb 이면 꺼진상태에서 호출된 상태
    if (state==UIApplicationStateActive) {
        //어플실행중 푸시가 왔을때.... 처리 탭바에 배지만 달아준다//
        //[self DisplayAlert:@"aaaa" cancelText:@"닫기"];
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
        
        //Get the filename of the sound file:
        NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/memo_on.wav"];
        
        //declare a system sound
        SystemSoundID soundID;
        
        //Get a URL for the sound file
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        
        //Use audio sevices to create the sound
        // AudioServicesCreateSystemSoundID((CFURLRef) [NSURL fileURLWithPath:filePath], &soundID);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
        //Use audio services to play the sound
        AudioServicesPlaySystemSound(soundID);
        
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        
        NSLog(@"켜진상태에서 쪽지가 도착 : %@", [aps objectForKey:@"no"]);
        
        if ([[aps objectForKey:@"alert"] isEqualToString:@"게시판소식"])
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"새글이 달렸습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
            
        }else   if ([[aps objectForKey:@"alert"] isEqualToString:@"게시판수정"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"게시글이 수정되었습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
            
        }else if ([[aps objectForKey:@"alert"] isEqualToString:@"권한인증완료!"]){
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            registerCode = [[defaults stringForKey:@"ka_Code"] intValue];
            [defaults synchronize];
            
            NSLog(@"KN_HOST_NAME===%s",KN_HOST_NAME);
            [self DisplayAlert:@"권한인증완료!" cancelText:@"확인"];
            NSString *url=[NSString stringWithFormat:@"http://%s/m_kid_check.php?m_Code=%d",KN_HOST_NAME, registerCode];
            NSLog(@"url====%@",url);
            
            NSString *html_data = [self GetHTMLString:url encoding:KN_SERVER_LANG];
            html_data = [html_data stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            html_data = [html_data stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // trim
            char *error=NULL;
            NSString *tmp_query=[NSString stringWithFormat:@"update kn_access set ka_Level='%@'",html_data];
            
            //  //NSLog(@"%@",tmp_query);
            if (sqlite3_exec(database, [tmp_query UTF8String], NULL, 0, &error)!=SQLITE_OK){
                
                //NSLog(@"kn_list TABLE insert ERROR: %s", error);
                sqlite3_free(error);
                
                [self closeDataBase];
                
            }
            NSLog(@"html_data====%@",html_data);
            [defaults setObject:html_data forKey:@"user_level"];
            [defaults synchronize];
            
            
        }else{
            //            //NSLog(@"tabbar badgevalue=%@",[[self.mainTab.tabBar.items objectAtIndex:2] badgeValue]);
            //            int tabsBadgeNumber=[[[self.mainTab.tabBar.items objectAtIndex:2] badgeValue] intValue];
            //            tabsBadgeNumber=tabsBadgeNumber+1;
            //[[self.mainTab.tabBar.items  objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%d",tabsBadgeNumber]];
            
            [[self.mainTab.tabBar.items  objectAtIndex:2] setBadgeValue:@"N"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"messageList" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
        }
        
    }else {
        //꺼진상태에서 푸시가 왔을때...처리
        
        //  [self DisplayAlert:@"bbbb" cancelText:@"ok"]; //debuging alert
        //1.디비에 쪽지 내용을 넣는다.
        
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        
        NSLog(@"꺼진상태에서 쪽지가 도착 : %@", [aps objectForKey:@"no"]);
        
        if ([[aps objectForKey:@"alert"] isEqualToString:@"게시판소식"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"새글이 등록되었습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
            
        }else  if ([[aps objectForKey:@"alert"] isEqualToString:@"게시판수정"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"게시글이 수정되었습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
            
        }else  if ([[aps objectForKey:@"alert"] isEqualToString:@"댓글소식"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"댓글이 등록되었습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
            
        }else if ([[aps objectForKey:@"alert"] isEqualToString:@"권한인증완료!"]){
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            registerCode = [[defaults stringForKey:@"ka_Code"] intValue];
            [defaults synchronize];
            
            NSLog(@"KN_HOST_NAME===%s",KN_HOST_NAME);
            NSString *url=[NSString stringWithFormat:@"http://%s/m_kid_check.php?m_Code=%d",KN_HOST_NAME, registerCode];
            
            NSLog(@"url=%@",url);
            NSString *html_data = [self GetHTMLString:url encoding:KN_SERVER_LANG];
            html_data = [html_data stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            html_data = [html_data stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // trim
            char *error=NULL;
            NSString *tmp_query=[NSString stringWithFormat:@"update kn_access set ka_Level='%@'",html_data];
            
            //NSLog(@"%@",tmp_query);
            if (sqlite3_exec(database, [tmp_query UTF8String], NULL, 0, &error)!=SQLITE_OK){
                
                //NSLog(@"kn_list TABLE insert ERROR: %s", error);
                sqlite3_free(error);
                
                [self closeDataBase];
                
            }
            
            [defaults setObject:html_data forKey:@"user_level"];
            [defaults synchronize];
            
        }else{
            
            ////NSLog(@"tabbar badgevalue=%@",[[self.mainTab.tabBar.items objectAtIndex:2] badgeValue]);
            [[self.mainTab.tabBar.items  objectAtIndex:2] setBadgeValue:@"N"];
            
            self.mainTab.selectedIndex=2;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"messageList" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendReMessage" object:self];
        }
        
    }
    */
}
@end
