//
//  ViewController.m
//  MyGreeter
/* 如果是早上6点之后到中午12点之前，“早上好”
   如果是在中午12点之后和下午6点之前，“下午好”
   如果是在下午6点之后和早上6点之前，“晚上好”
   跑马灯效果播放
 */
//  Created by bgy on 2022/6/20.
//

#import "ViewController.h"
#import "AutoRunLabel.h"
@interface ViewController ()<AutoRunLabelDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AutoRunLabel *runLabel = [[AutoRunLabel alloc] initWithFrame:CGRectMake(0, 150, [[UIScreen mainScreen] bounds].size.width, 50)];
     runLabel.delegate = self;
     runLabel.directionType = LeftType;
     [self.view addSubview:runLabel];
     [runLabel addContentView:[self createLabelWithText:[self greetWithDateFormatter] textColor:[UIColor blackColor] labelFont:[UIFont boldSystemFontOfSize:30]]];
     [runLabel startAnimation];
}
 
- (UILabel *)createLabelWithText: (NSString *)text textColor:(UIColor *)textColor labelFont:(UIFont *)font {
     NSString *string = [NSString stringWithFormat:@"%@", text];
     UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 50)];
     label.font = font;
     label.text = string;
     label.textColor = textColor;
     return label;
}

- (NSString *)greetWithDateFormatter
{
    if ([self isBetweenFromHour:06 toHour:12]) {
        return @"早上好!";
    }
    else if ([self isBetweenFromHour:12 toHour:18]){
        return @"下午好!";
    }
    else{
        return @"晚上好!";
    }
}
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending){
        return YES;
    }
    else{
        return NO;
    }

}
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

@end
