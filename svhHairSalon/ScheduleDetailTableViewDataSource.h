//
//  ScheduleDetailTableViewDataSource.h
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 18..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ScheduleDetailTableViewDataSourceDelegate;

@interface ScheduleDetailTableViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *designList;

@property (strong, nonatomic) NSArray *designDate;

@property (strong, nonatomic) NSMutableDictionary *designerCachedImages;

@property (strong, nonatomic) id<ScheduleDetailTableViewDataSourceDelegate> delegate;

@end

@protocol ScheduleDetailTableViewDataSourceDelegate <NSObject>

@required

- (void) DesignerListSelectedIndex : (NSString *) designerCode;

@end