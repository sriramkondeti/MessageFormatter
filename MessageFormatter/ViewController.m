//
//  ViewController.m
//  MessageFormatter
//
//  Created by Sri Ram on 18/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Formatter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"You can find the listing at https://www.carlisttt.my/used-cars/3300445/2011-toyota-vios-1-5-trd-sportivo-33-000km-full-toyota-serviced-record-like-new-11/  or another one at https://www.carlisttt.my/used-cars/3300445/2011-toyota-vios-1-5-trd-sportivo-33-000km-full-toyota-serviced-record-like-new-11/ calll me at +60175570098 calll me at +60175570098 calll me at +60175570098 ";
    NSLog(@"%@", [NSString formatString:str] );}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
