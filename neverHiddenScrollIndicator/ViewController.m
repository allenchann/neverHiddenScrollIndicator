//
//  ViewController.m
//  neverHiddenScrollIndicator
//
//  Created by allen_Chan on 2017/6/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ViewController.h"
#import "CWLScrollView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CWLScrollView *scrollview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollview.contentSize = CGSizeMake(500, 500);
    
}

- (IBAction)range:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES)
        self.scrollview.contentSize = CGSizeMake(500, 500);
    else
        self.scrollview.contentSize = CGSizeMake(100, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
