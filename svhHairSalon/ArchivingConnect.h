//
//  ArchavingConnect.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 20..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchivingConnect : NSObject{

}

@property (nonatomic, strong) NSString *dataFilePath;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@property (nonatomic, strong) NSFileManager *fileManager;

-(void)MyProfileFile;       //아카이브 파일 경로 설정
-(void)MyProfileWrite:(NSString *)MyCode name:(NSString *)MyName PH:(NSString *)myPH Department:(NSString *)myDepartment Grade:(NSString *)myGrade UserLevel:(NSString *)myUserLevel Gender:(NSString *)myGender Bdate:(NSString *)myBdate ID:(NSString *)myID Pass:(NSString *)myPass Boss:(NSString *)myBoss Best:(NSString *)myBest Nick:(NSString *)myNick Item:(NSString *)myItem PN:(NSString *)myPN;       //아카이브 파일에 저장하기
-(NSString *)MyProfileCall:(NSString *)callForKey;      //아카이브 텍스트 호출하기
-(BOOL)MyProfileRemove;     //myProfile 경로의 모든 파일 삭제 !! 계정삭제의 경우에만 이용하길

@end
