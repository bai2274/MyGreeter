//
//  AutoRunLabe.h
//  TimeTest
//
//  Created by bgy on 2022/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AutoRunLabel;
 
typedef NS_ENUM(NSInteger, RunDirectionType) {
 LeftType = 0,
 RightType = 1,
};
 
@protocol AutoRunLabelDelegate <NSObject>
 
@optional
- (void)operateLabel: (AutoRunLabel *)autoLabel animationDidStopFinished: (BOOL)finished;
 
@end
@interface AutoRunLabel : UIView
@property (nonatomic, weak) id <AutoRunLabelDelegate> delegate;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) RunDirectionType directionType;
 
- (void)addContentView: (UIView *)view;
- (void)startAnimation;
- (void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
