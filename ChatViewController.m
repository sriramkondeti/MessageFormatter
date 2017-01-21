//
//  ChatViewController.m
//  MessageFormatter
//
//  Created by Sri Ram on 21/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageComposerView = [[MessageComposerView alloc] init];
    self.messageComposerView.delegate = self;
    self.messageComposerView.messagePlaceholder = @"Send a Text with PH.No/URL or Both..";
    self.tableview.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.messageComposerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   ChatTableViewCell *cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil)
        cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.lblMessage.text = @"How is that bubble component of yours coming along?How is that bubble component of yours coming along?How is that bubble component of yours coming along?";
    cell.backgroundColor = [UIColor clearColor];
   UIImage *img = [UIImage imageNamed:@"bubble_right"];
    cell.imbView.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(15, 30, 15, 30) resizingMode:UIImageResizingModeStretch];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)messageComposerSendMessageClickedWithMessage:(NSString*)message
{
    [self.messageComposerView finishEditing];
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
