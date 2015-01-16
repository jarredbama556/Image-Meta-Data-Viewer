//
//  ViewController.m
//  Image Meta Data Viewer
//
//  Created by Jarred Alldredge on 1/14/15.
//  Copyright (c) 2015 Vision Research. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/CGImageSource.h>
#import <ImageIO/CGImageProperties.h>

@interface ViewController ()
{
    NSDictionary *exifDic;
    NSDictionary *tiffDic;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goBtn:(id)sender {
    
    NSURL * imageURL = [NSURL URLWithString:_txtField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    [NSURLConnection connectionWithRequest:request delegate:self];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"/downlaodImage.jpg"];
    [imageData writeToFile:imagePath atomically:YES];

    UIImage * image = [UIImage imageWithData:imageData];
    _imageView.image = image;
    
    CGImageSourceRef mySourceRef = CGImageSourceCreateWithURL((CFURLRef)imageURL, NULL);
    NSDictionary *myMetadata = (NSDictionary *) CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(mySourceRef,0,NULL));
    exifDic = [myMetadata objectForKey:(NSString *)kCGImagePropertyExifDictionary];
    tiffDic = [myMetadata objectForKey:(NSString *)kCGImagePropertyTIFFDictionary];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger exif = [exifDic count];
    NSInteger tiff = [tiffDic count];
    NSInteger total = exif+tiff;
    
    // Return the number of rows in the section.
    return total;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load each job as a cell and set title lable in cell to Job name.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:100];
    UILabel *lbl2 = (UILabel *)[cell viewWithTag:101];

    NSArray *keyVals = [tiffDic allKeys];
    NSArray *allVals = [tiffDic allValues];

    [lbl setText:[keyVals objectAtIndex:indexPath.row]];
    NSString *value = [NSString stringWithFormat:@"%@", [allVals objectAtIndex:indexPath.row]];
    [lbl2 setText:value];

    return cell;
}


@end
