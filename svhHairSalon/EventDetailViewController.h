//
//  EventDetailViewController.h
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 14..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "UIImageView+AsyncAndCache.h"

@interface EventDetailViewController : UIViewController{

    ////////
    IntroViewController *IntorViewRef;      //IntroViewController.h
    ////////
    
    NSString *ImgUrl;       //ImageConnecting Url;
}

@property int indexPathRow;     //Table Cell No.
@property NSString *CellPathRow;        //Table DB Row No.

@property (weak, nonatomic) IBOutlet UIImageView *ImgEventDetail;       //Detail ImageView;

@end
