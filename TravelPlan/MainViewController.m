//
//  MainViewController.m
//  TravelPlan
//
//  Created by Jeremy on 2016/12/7.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "MainViewController.h"
#import "DetailListPage.h"
#import "JTTitleLabel.h"

@interface MainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property(nonatomic,strong)DetailListPage *needScrollToTopPage;
@property(nonatomic,assign) CGFloat beginOffsetX;

@property(nonatomic,strong) NSArray *arrayLists;
@end

@implementation MainViewController

-(NSArray *)arrayLists
{
    if(_arrayLists==nil)
    {
        _arrayLists=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DestinationURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.smallScrollView.showsVerticalScrollIndicator=NO;
    self.smallScrollView.showsHorizontalScrollIndicator=NO;
    self.smallScrollView.scrollsToTop=NO;

    self.bigScrollView.scrollsToTop = NO;
    self.bigScrollView.delegate = self;
    [self addController];
    
    [self addLabel];
    
    CGFloat contentX=self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize=CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled=YES;
    
    UIViewController *vc=[self.childViewControllers firstObject];
    vc.view.frame=self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    
    JTTitleLabel *label=[self.smallScrollView.subviews firstObject];
    label.scale=1.0;
    self.bigScrollView.showsHorizontalScrollIndicator=YES;
    
    self.needScrollToTopPage = self.childViewControllers[0];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];

}
-(void)addLabel
{
    for(int i=0;i<3;i++)
    {
        CGFloat lablW=[[UIScreen mainScreen] bounds].size.width/3.0f;
        CGFloat lablH=40;
        CGFloat lablY=0;
        CGFloat lablX=i*lablW;
        JTTitleLabel *lbl1=[[JTTitleLabel alloc]init];
        UIViewController *vc=self.childViewControllers[i];
        lbl1.text = vc.title;
        lbl1.frame=CGRectMake(lablX, lablY, lablW, lablH);
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag=i;
        lbl1.userInteractionEnabled=YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
        
    }
    self.smallScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 0);
    
}
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    JTTitleLabel *titlelabel=(JTTitleLabel *)recognizer.view;
    
    CGFloat offsetX=titlelabel.tag*self.bigScrollView.frame.size.width;
    CGFloat offsetY=self.bigScrollView.contentOffset.y;
    CGPoint offset=CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    [self setScrollToTopWithTableViewIndex:titlelabel.tag];
    
}
- (void)setScrollToTopWithTableViewIndex:(NSInteger)index
{
    self.needScrollToTopPage.tableView.scrollsToTop=NO;
    self.needScrollToTopPage=self.childViewControllers[index];
    self.needScrollToTopPage.tableView.scrollsToTop= YES;
}
-(void)addController
{
    for (int i=0; i<self.arrayLists.count; i++) {
        DetailListPage *vc1 = [[UIStoryboard storyboardWithName:@"DetailPage" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        vc1.title = self.arrayLists[i][@"title"];
        vc1.urlString = self.arrayLists[i][@"urlString"];
        
        [self addChildViewController:vc1];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSUInteger index=scrollView.contentOffset.x/self.bigScrollView.frame.size.width;
    
    JTTitleLabel *titlelabel=(JTTitleLabel *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx=titlelabel.center.x-self.smallScrollView.frame.size.width*0.5;
    
    CGFloat offsetMax=self.smallScrollView.contentSize.width-self.smallScrollView.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset=CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    
    //add controller
    DetailListPage *resVc=self.childViewControllers[index];
    resVc.index=index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            JTTitleLabel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    [self setScrollToTopWithTableViewIndex:index];
    if (resVc.view.superview) {
        return;
    }
    resVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:resVc.view];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = ABS(scrollView.contentOffset.x/scrollView.frame.size.width);
    NSUInteger leftIndex=(int)value;
    NSUInteger rightIndex=leftIndex+1;
    CGFloat scaleRight=value - leftIndex;
    CGFloat scaleLeft=1-scaleRight;
    
    JTTitleLabel *labelLeft=self.smallScrollView.subviews[leftIndex];
    labelLeft.scale=scaleLeft;
    if (rightIndex < self.smallScrollView.subviews.count) {
        JTTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
