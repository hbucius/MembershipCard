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
#import "ShareDriver.h"

#ifndef CGGEOMETRY_LXSUPPORT_H_
CG_INLINE CGPoint
LXS_CGPointAdd(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}
#endif

static NSString * const kLXCollectionViewKeyPath = @"collectionView";

@interface UICollectionViewCell (LXReorderableCollectionViewFlowLayout)

- (UIImage *)LX_rasterizedImage;

@end


@implementation UICollectionViewCell (LXReorderableCollectionViewFlowLayout)

- (UIImage *)LX_rasterizedImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end




@interface MyPageViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *membercardTitle;
@property (weak,nonatomic) UIPageControl * pageControl;
@property (assign, nonatomic) CGPoint panTranslationInCollectionView;
@property (assign, nonatomic) CGFloat scrollingSpeed;
@property (assign, nonatomic) UIEdgeInsets scrollingTriggerEdgeInsets;
@property (strong, nonatomic, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (strong, nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UIView *currentView;
@property (strong, nonatomic) NSIndexPath *selectedItemIndexPath;
@property (assign, nonatomic) CGPoint currentViewCenter;
@property  NSInteger lastLocation;
@property  BOOL NavigateFromOther;
@property  CGPoint lastViewCenter ;  //used to navigation to current pages.
@property (weak,nonatomic) UICollectionView *collectionView;
@end

 
@implementation MyPageViewController

#pragma mark lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.indexOnScreen=0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPageNumber];
    [self initPageControl];
    [self setContent];
    [self initLeftTopItems];
    [self initTitle];
    [ShareDriver shareInstances].myPageViewcontroller=self;
   // [self initKVO];
    self.delegate=self;

}

-(void) setContent{
    MembershipCardViewController2 *MembershipCardCollectionStartingPage=[self memberCardViewCotrollerAtIndex:_indexOnScreen];
    if (MembershipCardCollectionStartingPage != nil)
    {
        self.dataSource = self;
        [self setViewControllers:@[MembershipCardCollectionStartingPage]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:NULL];
        _collectionView=MembershipCardCollectionStartingPage.collectionView;
        
    }
    self.view.backgroundColor=[UIColor whiteColor];
    
}

-(void) initGestureObserver{
    [self setDefaults];
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    _longPressGestureRecognizer.delegate = self;
    for (UIGestureRecognizer *gestureRecognizer in self.collectionView.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [gestureRecognizer requireGestureRecognizerToFail:_longPressGestureRecognizer];
        }
    }
    
    [self.view addGestureRecognizer:_longPressGestureRecognizer];
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handlePanGesture:)];
     _panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:_panGestureRecognizer];
    // Useful in multiple scenarios: one common scenario being when the Notification Center drawer is pulled down
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActive:) name: UIApplicationWillResignActiveNotification object:nil];
    
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initGestureObserver];
    
}

-(void) initKVO{
    
    [self addObserver:self forKeyPath:@"viewControllers" options:NSKeyValueObservingOptionPrior  context:nil];
    
}

-(void) initPageNumber{
    NSInteger badgesCount=[[BadgeInfos shareInstance]badgesCount];
    self.maxIndex=(NSInteger)((badgesCount+badgesCountInOnePage-1)/badgesCountInOnePage)-1;
}
-(void)initLeftTopItems{
    
    UIBarButtonItem  *leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@""
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(doNothing)];
    [leftBarButtonItem  setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman"  size:16.0],NSForegroundColorAttributeName:[UIColor darkGrayColor],  NSBackgroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];

}

-(void) initPageControl{
    [self initPageNumber];
    self.pageControl=[UIPageControl appearanceWhenContainedIn:[MyPageViewController class], nil];
    self. pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor darkGrayColor];
    self.pageControl.backgroundColor=[UIColor whiteColor];
    if(self.maxIndex==0)     self.pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
}

-(void) initTitle{
 
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                     }];
  
    UIBarButtonItem  *rightBarButtonItem1=[[UIBarButtonItem alloc] initWithTitle:@"≣"
                                                                         style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                         action:@selector(rightTopButtonSettings)];
    [rightBarButtonItem1 setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman"  size:20.0],NSForegroundColorAttributeName:[UIColor darkGrayColor],  NSBackgroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
   
    UIBarButtonItem  *rightBarButtonItem2=[[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(rightTopButtonAdd)];
    [rightBarButtonItem2 setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman"  size:26.0], NSForegroundColorAttributeName:[UIColor darkGrayColor ],
                                                  NSBackgroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    
   [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:rightBarButtonItem1,rightBarButtonItem2, nil]];

}

-(void) doNothing{
    NSLog(@"I do nothing");
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) rightTopButtonSettings{
    if (DebugIng) {
        NSLog(@"rightTopButtonSettings is clicked");
    }
    UIViewController *settings=[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [self.navigationController pushViewController:settings animated:YES];
}

-(void) rightTopButtonAdd{
    if (DebugIng) {
        NSLog(@"rightTopButtonAdd is clicked");
    }
    
    UIViewController *addCard=[self.storyboard instantiateViewControllerWithIdentifier:@"addCard"];
    [self.navigationController pushViewController:addCard animated:YES];

    
}
#pragma  mark MyLayout delete 


-(BOOL) shouldHideAtIndexPath:(NSIndexPath *) indexPath{
    BOOL value=NO;
    if([self.selectedItemIndexPath isEqual:indexPath]) {
        value=YES;
        NSLog(@"self.selectedItemIndexPath isEqual:indexPath:%ld",indexPath.row);
        
    }
     return value;
    
 }



#pragma pageView delegate

- (MembershipCardViewController2 *)memberCardViewCotrollerAtIndex: (NSInteger) index{
    NSLog(@"parameter: self.maxIndex=%ld,index=%ld",(long)self.maxIndex,(long)index);
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
   {
       
       NSLog(@"MembershipCardCollectionPage is not nil");
      _indexOnScreen=index;
       NSLog(@"_indexOnScreen become %ld",(long)_indexOnScreen);
      MembershipCardCollectionPage.index=_indexOnScreen;
   }
   else NSLog(@"MembershipCardCollectionPage is  nil");

    //set delegate to pageview
    [MembershipCardCollectionPage setDelegate:self];
    return    MembershipCardCollectionPage;
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
        NSLog(@"didFinishAnimating for page controller ");
        if([self.viewControllers[0] isKindOfClass:[MembershipCardViewController2 class]]){
            MembershipCardViewController2 *mscv2=(MembershipCardViewController2*) (self.viewControllers[0]);
            self.collectionView=mscv2.collectionView;
        }
       
    }
    

}



#pragma mark gestureRecognizer


- (void)setDefaults {
    _scrollingSpeed = 30.0f;
    _scrollingTriggerEdgeInsets = UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f);
}

-(void) setCurrentView:(UIView *)currentView {
    _currentView=currentView;
    self.currentViewCenter=_currentView.center;
    
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:kLXCollectionViewKeyPath];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    if ([layoutAttributes.indexPath isEqual:self.selectedItemIndexPath]) {
        layoutAttributes.hidden = YES;
        NSLog(@"I am hidden in applyLayoutAttributes");
    }
}

- (void)invalidateLayoutIfNecessary {
    NSLog(@"begin invalidateIfNecessay");
    if(!self.NavigateFromOther){
        NSIndexPath *newIndexPath = [self.collectionView indexPathForItemAtPoint:self.currentView.center];
        NSIndexPath *previousIndexPath = self.selectedItemIndexPath;
        if(self.selectedItemIndexPath==nil || (newIndexPath == nil) || [newIndexPath isEqual:previousIndexPath]) return;
        self.selectedItemIndexPath = newIndexPath;
        __weak typeof(self) weakSelf = self;
        [self.collectionView performBatchUpdates:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                NSInteger index=((MembershipCardViewController2*)self.viewControllers[0]).index ;
                NSUInteger newLocation=newIndexPath.row+index*badgesCountInOnePage;
                NSUInteger oldLocation=previousIndexPath.row+index*badgesCountInOnePage;
                [[BadgeInfos shareInstance] deleteBadgeAtIndex:oldLocation reAddBadgeAtIndex:newLocation];
                [strongSelf.collectionView insertItemsAtIndexPaths:@[ newIndexPath ]];
                [strongSelf.collectionView deleteItemsAtIndexPaths:@[ previousIndexPath ]];
                [self.collectionView.collectionViewLayout invalidateLayout];
                
            }
        } completion:^(BOOL finished) {
           
        }];
  
    }
    else {
        NSIndexPath *newIndexPath = [self.collectionView indexPathForItemAtPoint:self.currentView.center];
        if( newIndexPath == nil ) return;
        self.selectedItemIndexPath = newIndexPath;
        __block typeof(self) weakSelf = self;
        NSIndexPath *path=[NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView performBatchUpdates:^{
            if (weakSelf) {
                NSInteger index=((MembershipCardViewController2*)self.viewControllers[0]).index ;
                NSUInteger newLocation=newIndexPath.row+index*badgesCountInOnePage;
                NSLog(@"last location is %ld",self.lastLocation);
                [[BadgeInfos shareInstance] deleteBadgeAtIndex:self.lastLocation reAddBadgeAtIndex:newLocation];
                [weakSelf.collectionView insertItemsAtIndexPaths:@[ newIndexPath ]];
                [weakSelf.collectionView deleteItemsAtIndexPaths:@[path]];
                [self.collectionView.collectionViewLayout invalidateLayout];
                //refresh data in other pages.
                self.dataSource=nil;
                self.dataSource=self;
            }
        } completion:^(BOOL finished) {
            
        }];
        
        self.NavigateFromOther=NO;
    }
   
    NSLog(@"end invalidateLayoutIfNecessary");
}



#pragma mark - Target/Action methods


-(void) currentViewTouchDown {
    
    NSLog(@" touching down");
}


- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch(gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"Long press begin");
            NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            NSLog(@"currentPath is %ld",currentIndexPath.row);
            self.selectedItemIndexPath=currentIndexPath;
            UICollectionViewCell *collectionViewCell = [self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
            
            if(collectionViewCell==nil)
            {
                NSLog(@"collectionViewcell is nil now");
                return;
                
            }
            
            self.currentView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
            
            collectionViewCell.highlighted = YES;
            UIImageView *highlightedImageView = [[UIImageView alloc] initWithImage:[collectionViewCell LX_rasterizedImage]];
            highlightedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            highlightedImageView.alpha = 1.0f;
            
            
            collectionViewCell.highlighted = NO;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[collectionViewCell LX_rasterizedImage]];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView.alpha = 0.0f;
            
            [self.currentView addSubview:imageView];
            [self.currentView addSubview:highlightedImageView];
            [self.collectionView addSubview:self.currentView];
            self.currentViewCenter = self.currentView.center;
            [UIView
             animateWithDuration:0.1
             delay:0.0
             options:UIViewAnimationOptionBeginFromCurrentState
             animations:^{
                     self.currentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                     highlightedImageView.alpha = 0.0f;
                     imageView.alpha = 1.0f;
             }
             completion:^(BOOL finished) {
                 if (highlightedImageView) {
                     [highlightedImageView removeFromSuperview];
                 }
             }];
            //invalidate the data in the selected item
            UICollectionViewCell *cell=[self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
            cell.hidden=true;
            NSLog(@"I am hidden in long press ,indexpath=%ld" ,self.selectedItemIndexPath.row);
            [self.collectionView.collectionViewLayout invalidateLayout];
            
        } break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            NSLog(@"long press ended");
            NSIndexPath *currentIndexPath = self.selectedItemIndexPath;
            if(self.NavigateFromOther && self.currentView){
                 //mean never validate the layout before.
                self.selectedItemIndexPath=nil;
                [self.currentView removeFromSuperview];
                self.currentViewCenter = CGPointZero;
                self.dataSource=nil;
                self.dataSource=self;
                self.NavigateFromOther=NO;
                return;
            }
            if (currentIndexPath) {
                
                self.selectedItemIndexPath = nil;
                self.currentViewCenter = CGPointZero;
                
                UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:currentIndexPath];
                
                __weak typeof(self) weakSelf = self;
                [UIView
                 animateWithDuration:0.1
                 delay:0.0
                 options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         strongSelf.currentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         strongSelf.currentView.center = layoutAttributes.center;
                     }
                 }
                 completion:^(BOOL finished) {
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         [strongSelf.currentView removeFromSuperview];
                         strongSelf.currentView = nil;
                         UICollectionViewCell *cell=[self.collectionView cellForItemAtIndexPath:currentIndexPath];
                         cell.hidden=false;
                        [strongSelf.collectionView.collectionViewLayout invalidateLayout];
                         NSLog(@"I am not hidden any more indexpath=%ld",(long)currentIndexPath.row);

                     }
                 }];
            }
        } break;
            
        default: break;
    }
}



- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"handle pan Gesture begin");
        case UIGestureRecognizerStateChanged: {
            NSLog(@"handle pan Gesture changed");
            self.panTranslationInCollectionView = [gestureRecognizer translationInView:self.view];
            CGPoint viewCenter = self.currentView.center = LXS_CGPointAdd(self.currentViewCenter, self.panTranslationInCollectionView);
            [self performSelectorOnMainThread:@selector(invalidateLayoutIfNecessary) withObject:nil waitUntilDone:YES];
            if (viewCenter.x < (CGRectGetMinX(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.left)) {
                NSLog(@"Wait for navigating to left page");
                self.lastViewCenter=viewCenter;
                 [self performSelector:@selector(navigateToLeftPage:) withObject:@"LEFT" afterDelay:1.0];
            }
            else if(viewCenter.x> (CGRectGetMaxX(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.right)) {
                NSLog(@"Wait for navigating to right page");
                self.lastViewCenter=viewCenter;
                [self performSelector:@selector(navigateToRightPage:) withObject:[NSValue valueWithCGPoint:viewCenter] afterDelay:1.0];

            }
            
        } break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            NSLog(@"@pan gesture ended;");
        } break;
        default: {
        } break;
    }
}




-(void) navigateToRightPage:(id) value{
    NSLog(@" I want to right page, waiting");
    if(self.currentView==nil || self.collectionView==nil ) return;
    CGPoint priorViewCenter=[value CGPointValue];
    if(priorViewCenter.x!=self.currentView.center.x || priorViewCenter.y!=self.currentView.center.y) return;
     if([self.viewControllers[0] isKindOfClass:[MembershipCardViewController2 class]]){
        NSInteger index=((MembershipCardViewController2*)self.viewControllers[0]).index ;
        MembershipCardViewController2 *mscvc=[self memberCardViewCotrollerAtIndex:index+1];
        self.lastLocation=[self.selectedItemIndexPath indexAtPosition:1]+index*badgesCountInOnePage;
        self.selectedItemIndexPath=nil;
         __block MyPageViewController *weakSelf=self;
        [self setViewControllers:[NSArray arrayWithObject:mscvc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            if(finished)
            {
                //change collection view
                UIViewController *vc=weakSelf.viewControllers[0];
                if([vc isKindOfClass:[MembershipCardViewController2 class]]) {
                    MembershipCardViewController2 *mvc2=(MembershipCardViewController2*) vc;
                    weakSelf.collectionView=mvc2.collectionView;
                    [weakSelf.collectionView addSubview:weakSelf.currentView];
                    //other change
                    weakSelf.NavigateFromOther=YES;

                }
                NSLog(@"collectionView are:%@",weakSelf.collectionView);
            }
        }];

 
    }

}

-(void) navigateToLeftPage:(id) value{
    NSLog(@" I want to right page, waiting");
    if(self.currentView==nil || self.collectionView==nil ) return;
    CGPoint priorViewCenter=[value CGPointValue];
    if(priorViewCenter.x!=self.currentView.center.x || priorViewCenter.y!=self.currentView.center.y) return;
    if([self.viewControllers[0] isKindOfClass:[MembershipCardViewController2 class]]){
        NSInteger index=((MembershipCardViewController2*)self.viewControllers[0]).index ;
        MembershipCardViewController2 *mscvc=[self memberCardViewCotrollerAtIndex:index+1];
        self.lastLocation=[self.selectedItemIndexPath indexAtPosition:1]+index*badgesCountInOnePage;
        self.selectedItemIndexPath=nil;
        __block MyPageViewController *weakSelf=self;
        [self setViewControllers:[NSArray arrayWithObject:mscvc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            if(finished)
            {
                //change collection view
                UIViewController *vc=weakSelf.viewControllers[0];
                if([vc isKindOfClass:[MembershipCardViewController2 class]]) {
                    MembershipCardViewController2 *mvc2=(MembershipCardViewController2*) vc;
                    weakSelf.collectionView=mvc2.collectionView;
                    [weakSelf.collectionView addSubview:weakSelf.currentView];
                    //other change
                    weakSelf.NavigateFromOther=YES;
                    
                }
                NSLog(@"collectionView are:%@",weakSelf.collectionView);
            }
        }];
        
        
    }
    
}

#pragma mark - UICollectionViewLayout overridden methods ,NEED TO ADD TO CATEGORY



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    
    switch (layoutAttributes.representedElementCategory) {
        case UICollectionElementCategoryCell: {
            [self applyLayoutAttributes:layoutAttributes];
        } break;
        default: {
            // Do nothing...
        } break;
    }
    
    return layoutAttributes;
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return (self.selectedItemIndexPath != nil);
        
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.longPressGestureRecognizer isEqual:gestureRecognizer]) {
        return [self.panGestureRecognizer isEqual:otherGestureRecognizer];
    }
    
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return [self.longPressGestureRecognizer isEqual:otherGestureRecognizer];
    }
    
    return NO;
}

-(void)  observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  //  NSLog(@"what happened?");
    if([keyPath isEqualToString:@"viewControllers"]){
        
        NSLog(@"what happened?");
    }
    
}


#pragma mark - Notifications

- (void)handleApplicationWillResignActive:(NSNotification *)notification {
    self.panGestureRecognizer.enabled = NO;
    self.panGestureRecognizer.enabled = YES;
}


@end
