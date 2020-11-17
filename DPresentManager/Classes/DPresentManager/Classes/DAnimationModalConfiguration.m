//
//  DAnimationModalConfiguration.m
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import "DAnimationModalConfiguration.h"

@implementation DAnimationModalConfiguration
+ (instancetype)defaultConfiguration {
    return [[DAnimationModalConfiguration alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _direction = DAnimationModalConfigurationBottom;
        _contentSize= CGSizeMake(CGFLOAT_MAX, 200);
        _animationDuration = 0.5;
        _autoDismissModal = YES;
        _backgroundOpacity = 0.3;
        
        _enableShadow = YES;
        _shadowColor = [UIColor blackColor];
        _shadowWidth = 3.0;
        _shadowOpacity = 0.8;
        _shadowRadius = 5.0;
        
        _enableBackgroundAnimation = YES;
        _backgroundColor = [UIColor blackColor];
        _backgroundImage = nil;
        
        _enableInteractiveTransitioning = YES;
    }
    return self;
}

@end
