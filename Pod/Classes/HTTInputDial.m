//
//  HTTInputDial.m
//  Pods
//
//  Created by Hoan Ton-That on 1/26/16.
//
//

#import "HTTInputDial.h"

#define distanceBetween(p1,p2) sqrt(pow((p2.x-p1.x),2) + pow((p2.y-p1.y),2))
#define kDefClearMiddle 45

@interface HTTInputDial ()

@property (strong, nonatomic) UIImageView *sliderImageView;

@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) NSString *objectValue;
@property (nonatomic) NSArray *avaliableValues;

@property (nonatomic) int currentValue;
@property (nonatomic) int maxValue;
@property (nonatomic) int minValue;
@property (nonatomic) int fullRotationValue;

@property (nonatomic) BOOL isOutOfScope;
@property (nonatomic) CGPoint _lastPosition;
@property (nonatomic) CGFloat _lastChangedAngle;
@property (nonatomic) CGFloat _distanceForIcons;

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation HTTInputDial

- (id)initWithFrame:(CGRect)frame usingImage:(UIImage *)image minValue:(int)minValue maxValue:(int)maxValue fullRotationValue:(int)fullRotationValue {
    self = [super initWithFrame:frame];
    if (self) {
        [self setMaxValue:maxValue];
        [self setMinValue:minValue];
        [self setFullRotationValue:fullRotationValue];
        [self setCenterPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        
        self.sliderImageView = [[UIImageView alloc] initWithImage:image];
        [self.sliderImageView setFrame:[self frame]];
        self.sliderImageView.center =self.centerPoint;
        [self addSubview:self.sliderImageView];
        
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
        self.panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:self.panGestureRecognizer];
        [self setValue:minValue];
    }
    
    return self;
}

- (void)onPan:(UIPanGestureRecognizer *) sender{
    CGPoint location = [sender locationInView:self];
    
    int perInterval = -1;
    CGFloat angleInterval = 10*M_PI/180;
    
    CGFloat distanceToMiddle = distanceBetween(self.centerPoint, location);
    self.isOutOfScope = (distanceToMiddle < kDefClearMiddle);
    
    if(sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateBegan) {
        if(!self.isOutOfScope) {
            CGPoint sliderStartPoint = self._lastPosition;
            if(CGPointEqualToPoint(self._lastPosition, CGPointZero)) sliderStartPoint = location;
            CGFloat angle = [self angleBetweenCenterPoint:self.centerPoint point1:sliderStartPoint point2:location];
            self._lastChangedAngle = self._lastChangedAngle + angle;
            self._lastPosition = location;
            int numberOfIntervals = round(self._lastChangedAngle/angleInterval);
            
            if(numberOfIntervals != 0) {
                int newVal = self.currentValue + (perInterval*numberOfIntervals);
                [self setValue:newVal];
                
                self._lastChangedAngle = 0;
            }
        } else {
            self._lastPosition = CGPointZero;
            self._lastChangedAngle = 0;
            
        }
    }
    
    if(sender.state == UIGestureRecognizerStateEnded) {
        self._lastPosition = CGPointZero;
        self._lastChangedAngle = 0;
    }
}

- (CGFloat)angleBetweenCenterPoint:(CGPoint)centerPoint point1:(CGPoint)p1 point2:(CGPoint)p2 {
    CGPoint v1 = CGPointMake(p1.x - centerPoint.x, p1.y - centerPoint.y);
    CGPoint v2 = CGPointMake(p2.x - centerPoint.x, p2.y - centerPoint.y);
    
    CGFloat angle = atan2f(v2.x*v1.y - v1.x*v2.y, v1.x*v2.x + v1.y*v2.y);
    
    return angle;
}

- (void)setValue:(int)value {
    if (value <= [self minValue]) {
        self.currentValue = [self minValue];
    } else if(value >= [self maxValue]) {
        self.currentValue = [self maxValue];
    } else {
        self.currentValue = value;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputDial:didUpdateValue:)]) {
        [self.delegate inputDial:self didUpdateValue:self.currentValue];
    }
    
    [self updateDialRotation];
}

- (int)getValue {
    return self.currentValue;
}

- (void)updateDialRotation {
    self.sliderImageView.transform = CGAffineTransformMakeRotation((self.currentValue * M_PI) / (30.0f/(60.0f/self.fullRotationValue)));
}

@end
