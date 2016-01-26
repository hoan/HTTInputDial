//
//  HTTInputDial.h
//  Pods
//
//  Created by Hoan Ton-That on 1/26/16.
//
//

#import <UIKit/UIKit.h>

@class HTTInputDial;

@protocol HTTInputDialDelegate <NSObject>

- (void)inputDial:(nonnull HTTInputDial *)inputDial didUpdateValue:(int)value;

@end

@interface HTTInputDial : UIView <UIGestureRecognizerDelegate>

- (nonnull id)initWithFrame:(CGRect)frame
                 usingImage:(nonnull UIImage *)image
                   minValue:(int)minValue
                   maxValue:(int)maxValue
          fullRotationValue:(int)fullRotationValue;

- (void)setValue:(int)value;
- (int)getValue;

@property (nonatomic, nullable, weak) id <HTTInputDialDelegate> delegate;

@end

