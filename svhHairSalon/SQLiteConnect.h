//
//  SQLiteConnect.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 3..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteConnect : NSObject {
    //////////////////////
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSMutableArray *arrayStr;
    //////////////////////
}

/////////////////////
-(void)checkAndCopyDB;
-(void)openDB;
-(NSString *)filePath;
-(void)getDB;

-(void)initDB;
-(void)openDataBase;
-(void)closeDataBase;
/////////////////////

@end
