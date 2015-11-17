//
//  TabBarViewController.m
//  svhHairSalon
//
//  Created by jinsu lee on 2015. 10. 12..
//  Copyright © 2015년 kr.co.knsoft.svhHair. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController () <UITabBarControllerDelegate>

@end

@implementation TabBarViewController {
    CETurnAnimationController *_animationController;
    CEHorizontalSwipeInteractionController *_swipeInteractionController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        self.delegate = self;
        
        // create the interaction / animation controllers
        //_swipeInteractionController = [CEHorizontalSwipeInteractionController new];       //탭 터치로 탭 위치 변경
        [CEHorizontalSwipeInteractionController new];       //탭 터치 없이 애니메이션만 사용
        _animationController = [CETurnAnimationController new];
        //_animationController.folds = 1;       //fold setting
        
        // observe changes in the currently presented view controller
        [self addObserver:self
               forKeyPath:@"selectedViewController"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    if ([keyPath isEqualToString:@"selectedViewController"] )
    {
        // wire the interaction controller to the view controller
        [_swipeInteractionController wireToViewController:self.selectedViewController
                                             forOperation:CEInteractionOperationTab];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    _animationController.reverse = fromVCIndex < toVCIndex;
    return _animationController;
}

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    return _swipeInteractionController.interactionInProgress ? _swipeInteractionController : nil;
}


#pragma mark - UIStatusBar Hidden
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end