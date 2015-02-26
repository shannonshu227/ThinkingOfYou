//
//  DetailedMessageController.m
//  ThinkOfYou
//
//  Created by Xu He on 2/25/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "DetailedMessageController.h"
#import "MainViewController.h"

@interface DetailedMessageController ()
@property (strong, nonatomic) UIImageView *emojiView;
@property (strong, nonatomic) NSMutableArray *emojiViews;

@end

@implementation DetailedMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    
    NSString *fromUser = [NSString stringWithFormat:@"From: %@", self.reminder[@"from"]];
    self.userName.text = fromUser;
    self.message.text = self.reminder[@"content"];
    self.timeStamp.text = self.reminder[@"createdAt"];
    
    NSString *picName;
    NSString *lcContent = [self.reminder[@"content"] lowercaseString];
    if ([lcContent containsString:@"birthday"] || [lcContent containsString:@"bday"] || [lcContent containsString:@"hbd"]) {
        picName = @"cake.png";
    } else if ([lcContent containsString:@"love you"]) {
        picName = @"love.png";
    } else if ([lcContent containsString:@"miss you"] || [lcContent containsString:@"kiss"]) {
        picName = @"kiss.png";
    }
    
    if (picName != nil) {
        self.emojiViews = [[NSMutableArray alloc] init];
        int count = 6;
        while (count > 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(count*50, count*10, 30, 30)];
            
            imageView.image = [UIImage imageNamed:picName];
            [self.emojiViews addObject:imageView];
            [self.view addSubview:imageView];
            
            count--;
        }
        
        [self runAnimation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:[[MainViewController alloc] init] animated:YES completion:nil];

}


- (void) runAnimation {
    

    [UIView animateWithDuration:5 animations:^{

        NSUInteger count = self.emojiViews.count;
        while (count > 0) {
            UIImageView *emojiView = self.emojiViews[count-1];
            if (count == 5) {
                emojiView.center = CGPointMake(self.emojiView.center.x+20, self.emojiView.center.y + 300 + count*50);
            } else if (count == 4) {
                emojiView.center = CGPointMake(self.emojiView.center.x + 50, self.emojiView.center.y + 300 + count*50);
            } else {
                emojiView.center = CGPointMake(self.emojiView.center.x+100*count, self.emojiView.center.y + 300 + count*50);
            }
            emojiView.alpha = 0;
            emojiView.transform = CGAffineTransformMakeScale(3, 3);
            count --;
        }
        
    }];
}
@end
