//
//  SwipeINteractionController.m
//  ILoveCatz
//
//  Created by Colin Eberhardt on 22/08/2013.
//  Copyright (c) 2013 com.razeware. All rights reserved.
//

#import "CEHorizontalSwipeInteractionController.h"

@implementation CEHorizontalSwipeInteractionController {
    BOOL _shouldCompleteTransition;
    UIViewController *_viewController;
    UIPanGestureRecognizer *_gesture;
    CEInteractionOperation _operation;
}

-(void)dealloc {
    NSLog(@"dealloc");
    [_gesture.view removeGestureRecognizer:_gesture];
}

- (void)wireToViewController:(UIViewController *)viewController forOperation:(CEInteractionOperation)operation{
    NSLog(@"wireToViewController");
    self.popOnRightToLeft = YES;
    _operation = operation;
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
    NSLog(@"prepareGestureRecognizserInView");
    _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:_gesture];
}

- (CGFloat)completionSpeed{
    NSLog(@"completionSpeed");
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    NSLog(@"handleGesture");
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    NSLog(@"vel == %f /// == %f", vel.x,vel.y);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"AAA");
            BOOL rightToLeftSwipe = vel.x < 0;
            
            // perform the required navigation operation ...
            
            if (_operation == CEInteractionOperationPop) {
                // for pop operation, fire on right-to-left
                NSLog(@"aaa");
                if ((self.popOnRightToLeft && rightToLeftSwipe) ||
                    (!self.popOnRightToLeft && !rightToLeftSwipe)) {
                    NSLog(@"bbb");
                    self.interactionInProgress = YES;
                    [_viewController.navigationController popViewControllerAnimated:YES];
                }
            } else if (_operation == CEInteractionOperationTab) {
                // for tab controllers, we need to determine which direction to transition
                if (rightToLeftSwipe) {
                    if (_viewController.tabBarController.selectedIndex < _viewController.tabBarController.viewControllers.count - 1) {
                        NSLog(@"_viewController == %@",_viewController);
                        self.interactionInProgress = YES;
                        _viewController.tabBarController.selectedIndex++;
                    }
                    
                } else {
                    if (_viewController.tabBarController.selectedIndex > 0) {
                        NSLog(@"eee");
                        self.interactionInProgress = YES;
                        _viewController.tabBarController.selectedIndex--;
                    }
                }
            } else {
                // for dismiss, fire regardless of the translation direction
                self.interactionInProgress = YES;
                [_viewController dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSLog(@"BBB");
            if (self.interactionInProgress) {
                // compute the current position
                CGFloat fraction = fabs(translation.x / 200.0);
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                _shouldCompleteTransition = (fraction > 0.5);
                
                // if an interactive transitions is 100% completed via the user interaction, for some reason
                // the animation completion block is not called, and hence the transition is not completed.
                // This glorious hack makes sure that this doesn't happen.
                // see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
                if (fraction >= 1.0)
                    fraction = 0.99;
                
                [self updateInteractiveTransition:fraction];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            NSLog(@"CCC");
            if (self.interactionInProgress) {
                NSLog(@"Check");
                
                self.interactionInProgress = NO;
                if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    NSLog(@"Check_aaa");
                    [self cancelInteractiveTransition];
                }
                else {
                    NSLog(@"Check_bbb");
                    [self finishInteractiveTransition];
                }
            }
            break;
        default:
            NSLog(@"DDD");
            break;
    }
}


@end
