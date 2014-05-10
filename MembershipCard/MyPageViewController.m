//
//  MyPageViewController.m
//  MembershipCard
//
//  Created by mstr on 5/1/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "MyPageViewController.h"
#import "MembershipCardViewController2.h"
#import "Constants.h"
#import "BadgeInfos.h"
@interface MyPageViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *membercardTitle;
@property (weak,nonatomic) UIPageControl * pageControl;
@end

@implementation MyPageViewController

#pragma mark lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     _indexOnScreen=0;
     [self initPageNumber];
    [self initPageControl];
    MembershipCardViewController2 *MembershipCardCollectionStartingPage=[self memberCardViewCotrollerAtIndex:_indexOnScreen];
    NSLog(@"viewDidload happened2");
    if (MembershipCardCollectionStartingPage != nil)
    {
        NSLog(@"MembershipCardCollectionStartingPage is not nil");
        self.dataSource = self;
        [self setViewControllers:@[MembershipCardCollectionStartingPage]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:NULL];
      
    }
    self.view.backgroundColor=[UIColor whiteColor];
    [self initTitle];
    
    
  
    
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) initPageNumber{
    int badgesCount=[[BadgeInfos shareInstance]badgesCount];
    self.maxIndex=(NSInteger)((badgesCount+badgesCountInOnePage-1)/badgesCountInOnePage)-1;
}

-(void) initPageControl{
    [self initPageNumber];
    self.pageControl=[UIPageControl appearanceWhenContainedIn:[MyPageViewController class], nil];
    self. pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor darkGrayColor];
    self.pageControl.backgroundColor=[UIColor whiteColor];
    //    if(self.maxIndex==0) ;//
    //[pageControl setHidesForSinglePage:NO];
    if(self.maxIndex==0)     self.pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
}

-(void) initTitle{
    /**
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.text = mainScreenTitle;
    [label sizeToFit];
    self.navigationItem.titleView = label;
     **/
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                     }];
    UIBarButtonItem  *rightBarButtonItem1=[[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:nil
                                                                           action:nil];
    [rightBarButtonItem1 setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman"  size:26.0],       NSForegroundColorAttributeName:[UIColor darkGrayColor ],
                                                  NSBackgroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem1;

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma pageView delegate

- (MembershipCardViewController2 *)memberCardViewCotrollerAtIndex: (NSInteger) index{
    NSLog(@"parameter: self.maxIndex=%d,index=%d",self.maxIndex,index);
    //if the page number ==1 ,don't permit cycle from the last page to the first page or reverse.
    if (self.maxIndex==0 && index!=0)  return nil;
    if (index<0 || index>self.maxIndex) {
        NSLog(@"memberCardViewController return nil");
        if (index<0) {
            index+=self.maxIndex+1;
        }
        else{
            index-=self.maxIndex+1;

            
        }
      //  return nil;
    }
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MembershipCardViewController2* MembershipCardCollectionPage = [sb instantiateViewControllerWithIdentifier:@"MembershipCardViewController2"];
   if(MembershipCardCollectionPage)
   {;
       NSLog(@"MembershipCardCollectionPage is not nil");
      _indexOnScreen=index;
       NSLog(@"_indexOnScreen become %d",_indexOnScreen);
      MembershipCardCollectionPage.index=_indexOnScreen;
   }
   else NSLog(@"MembershipCardCollectionPage is  nil");

    return MembershipCardCollectionPage;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(MembershipCardViewController2 *)vc
{
    NSLog(@"before is called");
    self.indexOnScreen=vc.index;
    return [self memberCardViewCotrollerAtIndex:self.indexOnScreen-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(MembershipCardViewController2 *)vc
{
    NSLog(@"after is called");
    self.indexOnScreen=vc.index;
    return [self memberCardViewCotrollerAtIndex:self.indexOnScreen+1];

}


-(NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.maxIndex+1;
}

-(NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return self.indexOnScreen;
}

-(void) pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        
    
    }
}

@end
