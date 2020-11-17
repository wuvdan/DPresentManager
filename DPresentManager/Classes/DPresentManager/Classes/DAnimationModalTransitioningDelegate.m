//
//  DAnimationModalTransitioningDelegate.m
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import "DAnimationModalTransitioningDelegate.h"
#import "DAnimationModalConfiguration.h"
#import "DAnimationModalAnimatedTransitioning.h"
#import "DAnimationModalPresentationController.h"
#import "DAnimationModalPercentDrivenInteractiveTransition.h"


@implementation DAnimationModalTransitioningDelegate
{
    DAnimationModalConfiguration *_configuration;
}

+ (instancetype)transitioningDelegateWithConfiguration:(DAnimationModalConfiguration *)configuration {
    DAnimationModalTransitioningDelegate *delegate = [[DAnimationModalTransitioningDelegate alloc] init];
    delegate->_configuration = configuration;
    return delegate;
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [DAnimationModalAnimatedTransitioning transitioningWithConfiguration:_configuration
                                                         isPresentation:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [DAnimationModalAnimatedTransitioning transitioningWithConfiguration:_configuration
                                                         isPresentation:NO];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (_configuration.enableInteractiveTransitioning & _configuration.isStartedInteractiveTransitioning) {
        return [DAnimationModalPercentDrivenInteractiveTransition interactiveTransitionWithConfiguration:_configuration];
    }
    return nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    DAnimationModalPresentationController *presentationController = [[DAnimationModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationController.configuration = _configuration;
    return presentationController;
}

@end
