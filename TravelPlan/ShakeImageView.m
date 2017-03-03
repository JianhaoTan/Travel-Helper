//
//  ShakeImageView.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "ShakeImageView.h"
#import "DetailModel.h"
#import "CardView.h"

@interface ShakeImageView()
@property(nonatomic,weak)CardView *cardView;

@end
@implementation ShakeImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.layer setCornerRadius:100.0f];
    
    // border
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:1.5f];
    
    // drop shadow
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:3.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}*/

-(void)setResponseArray:(NSArray *)responseArray
{
    
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype==UIEventSubtypeMotionShake) {
        //NSLog(@"%d",self.animationDuration);
        //[self performSelector:@selector(animationDidFinish) withObject:nil afterDelay:self.animationDuration];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animationDidFinish) userInfo:nil repeats:NO];
    }
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype==UIEventSubtypeMotionShake) {
        self.hidden=NO;
        [self startAnimating];
        [self.cardView removeFromSuperview];
        
    }
    if ( [super respondsToSelector:@selector(motionBegan:withEvent:)] )
        [super motionBegan:motion withEvent:event];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(CardView *)cardView{
    if (!_cardView) {
        _cardView=[CardView theCardView];
    }
    return _cardView;
}
-(void)animationDidFinish
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //screenRect.size.width/2-cardView.frame.size.width/2;

    
    NSInteger randomID = arc4random() % 9+1;
    NSInteger randomType = arc4random() % 3+1;
    [[JTHTTPManager manager] GET : [NSString stringWithFormat:@"http://104.236.117.77/GetRandom.php?type=%ld&id=%ld",(long)randomType,(long)randomID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray* responseObject) {
        self.cardView.model=[DetailModel detailWithDict: responseObject[0]];
        [self.superview addSubview:self.cardView];
        self.hidden=YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.cardView.frame=CGRectMake(screenRect.size.width/2-150,screenRect.size.height/2-150,300,300);
        } completion:^(BOOL finished) {
            self.cardView.frame=CGRectMake(screenRect.size.width/2-150,screenRect.size.height/2-150,300,300);
        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
@end
