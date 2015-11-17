//
//  HairCollectionViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 16..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackTableView.h"

@interface HairCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    NSString *HairData;
}

/////////////////////
@property (strong, nonatomic) IBOutlet StackTableView *tableView;
/////////////////////
@property (nonatomic, strong) NSArray *images;

@end
