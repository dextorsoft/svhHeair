//
//  DesignerCutListViewDataSource.h
//  svhHairSalon
//
//  Created by OGGU on 2015. 11. 20..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DesignerCutListViewDataSourceDelegate;

@interface DesignerCutListViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cutArray;

@property (strong, nonatomic) id<DesignerCutListViewDataSourceDelegate> delegate;

@end

@protocol DesignerCutListViewDataSourceDelegate <NSObject>

@required

- (void) CutSelectedIndex : (NSIndexPath *) indexPath;

@end