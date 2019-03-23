//
//  WNAActivityIndicator.m
//  Wordpress News App
//

#import "WNAActivityIndicator.h"
@import QuartzCore;

#define BACKGROUND_WIDTH 80.0f
#define BACKGROUND_HEIGHT 80.0f

@interface WNAActivityIndicator()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation WNAActivityIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create background view and center it
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2-BACKGROUND_WIDTH/2, frame.size.height/2-BACKGROUND_HEIGHT/2, BACKGROUND_WIDTH, BACKGROUND_HEIGHT)];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
        self.backgroundView.layer.cornerRadius = 10.0f;
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect activityFrame = self.activityIndicator.frame;
        // Center activity indicator
        activityFrame.origin.x = BACKGROUND_WIDTH / 2 - activityFrame.size.width / 2;
        activityFrame.origin.y = BACKGROUND_HEIGHT / 2 - activityFrame.size.height / 2;
        self.activityIndicator.frame = activityFrame;
        
        [self.activityIndicator startAnimating];
        
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.activityIndicator];
    }
    return self;
}

@end
