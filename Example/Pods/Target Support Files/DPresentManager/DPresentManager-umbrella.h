#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DAnimationModalAnimatedTransitioning.h"
#import "DAnimationModalConfiguration.h"
#import "DAnimationModalPercentDrivenInteractiveTransition.h"
#import "DAnimationModalPresentationController.h"
#import "DAnimationModalTransitioningDelegate.h"
#import "UIViewController+DAnimation.h"
#import "DPresentManager.h"

FOUNDATION_EXPORT double DPresentManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char DPresentManagerVersionString[];

