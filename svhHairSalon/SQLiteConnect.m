//
//  SQLiteConnect.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 11. 3..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "SQLiteConnect.h"

@implementation SQLiteConnect

///////////////////////////
/*
-(void)checkAndCopyDB{
    NSFileManager *fileM = [NSFileManager defaultManager];
    if ([fileM fileExistsAtPath:[self filePath]]) return;
    
    NSString *pathSrc = [[NSBundle mainBundle] pathForResource:@"svhHair_BU" ofType:@"sqlite"];
    
    [fileM copyItemAtPath:pathSrc toPath:[self filePath] error:nil];
    //[fileM release];
    
    NSLog(@"filePath == %@\npathSrc == %@", [self filePath], pathSrc);
}

-(void)openDB{
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open.");
    }
}

-(NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"svhHair_BU.sqlite"];
}

-(void)getDB{
    NSString *query = @"select * from sk_access";
    [self openDB];
    arrayStr = [NSMutableArray arrayWithCapacity:0];
    
    if(sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, NULL) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSString *str = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            [arrayStr addObject:str];
            //[str release];
        }
        for (int a = 0; a < [arrayStr count]; a++) {
            NSLog(@"VALUE : %@", [arrayStr objectAtIndex:a]);
        }
    }else{
        NSString *errmsg = [[NSString alloc] initWithFormat:@"%s", sqlite3_errmsg(db) ];
        NSLog(@"FAIL to open the database %@", errmsg);
    }
    sqlite3_finalize(statement);
}
*/
///////////////////////////

-(void)initDB{
    //First
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"svhHair_BU.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if(success) return;
    //the writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"svhHair_Bu.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        //
    }
}

-(void)openDataBase{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"svhHair_Bu.sqlite"];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        return;
    }
}

-(void)closeDataBase{
    sqlite3_close(db);
    return;
}

@end
