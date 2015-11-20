//
//  DesignerScheduleTimeViewDataSource.h
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 19..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DesignerScheduleTimeViewDataSourceDelegate;

@interface DesignerScheduleTimeViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *designerCutList;

@property (strong, nonatomic) id<DesignerScheduleTimeViewDataSourceDelegate> delegate;

@end

@protocol DesignerScheduleTimeViewDataSourceDelegate <NSObject>

@required

- (void) TimeListSelectedIndex : (NSIndexPath *) indexPath;

@end