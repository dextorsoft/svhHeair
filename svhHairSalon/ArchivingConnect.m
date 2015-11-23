//
//  ArchavingConnect.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 20..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "ArchivingConnect.h"

@implementation ArchivingConnect

//아카이브 파일 경로 설정
-(void)MyProfileFile{
    NSLog(@"MyProfileFile");
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    _dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"myProfile.archive"]];
}

//아카이브 파일 설계부터 하자
//아카이브 파일에 저장하기
-(void)MyProfileWrite:(NSString *)MyCode name:(NSString *)MyName PH:(NSString *)myPH Department:(NSString *)myDepartment Grade:(NSString *)myGrade UserLevel:(NSString *)myUserLevel Gender:(NSString *)myGender Bdate:(NSString *)myBdate ID:(NSString *)myID Pass:(NSString *)myPass Boss:(NSString *)myBoss Best:(NSString *)myBest Nick:(NSString *)myNick Item:(NSString *)myItem PN:(NSString *)myPN{
    NSLog(@"MyProfileWrite");
    NSMutableDictionary *dataDictionary;
    
    dataDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                      MyCode,@"myCode",             //코드
                      MyName,@"myName",             //이름
                      myPH,@"myPH",                 //전화번호
                      myDepartment,@"myDepartment", //지점
                      myGrade,@"myGrade",           //회원등급
                      myUserLevel,@"myUserLevel",   //등급코드
                      myGender,@"myGender",         //성별
                      myBdate,@"myBdate",           //생년월일
                      myID,@"myID",                 //아이디
                      myPass,@"myPass",             //비밀번호
                      myBoss,@"myBoss",             //추천인아이디
                      myBest,@"myBest",             //좋아요 수
                      myNick,@"myNick",             //별명
                      myItem,@"myItem",             //사용제품
                      myPN,@"myPN",                 //지정디자이너
                      nil];
    [NSKeyedArchiver archiveRootObject:dataDictionary toFile:_dataFilePath];
}

//아카이브 텍스트 호출하기
-(NSString *)MyProfileCall:(NSString *)callForKey{
    NSLog(@"MyProfileCall");
    NSString *archiveCall;
    _fileManager = [NSFileManager defaultManager];
    if ([_fileManager fileExistsAtPath:_dataFilePath]) {
        _dataDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:_dataFilePath];
        archiveCall = [_dataDictionary objectForKey:callForKey];
        
    }
    return archiveCall;
}

//아카이브 파일 삭제하기 myProfile.archive
-(BOOL)MyProfileRemove{
    NSLog(@"MyProfileRemove");
    _fileManager = [NSFileManager defaultManager];
    if ([_fileManager removeItemAtPath:_dataFilePath error:NULL] == NO) {
        NSLog(@"file remove failed...");
    }
    return YES;     //나중 수정
    
    /*
    if ([_fileManager fileExistsAtPath:_dataFilePath]) {
        return NO;
    }else{
        return YES;
    }
    */
}

@end
