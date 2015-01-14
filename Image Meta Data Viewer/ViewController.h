//
//  ViewController.h
//  Image Meta Data Viewer
//
//  Created by Jarred Alldredge on 1/14/15.
//  Copyright (c) 2015 Vision Research. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)goBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

