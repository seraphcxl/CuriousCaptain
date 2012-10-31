//
//  DCThumbnailViewCtrl.m
//  CuriousCaptain
//
//  Created by Chen XiaoLiang on 12-10-30.
//  Copyright (c) 2012年 Chen XiaoLiang. All rights reserved.
//

#import "DCThumbnailViewCtrl.h"

@interface DCThumbnailViewCtrl () {
    DCScribbleManager *_scribbleManager;
}

@end

@implementation DCThumbnailViewCtrl

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
    // Do any additional setup after loading the view from its nib.
    do {
        // set the table view's background
        // with a dark cloth texture image
        UIColor *backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background_texture"]];
        [[self view] setBackgroundColor:backgroundColor];
        
        // initialize the scribble manager
        _scribbleManager = [[DCScribbleManager alloc] init];
        
        // show number of scribbles available
        NSInteger numberOfScribbles = [_scribbleManager numberOfScribbles];
        [self.titleItem setTitle:[NSString stringWithFormat: numberOfScribbles > 1 ? @"%d items" : @"%d item", numberOfScribbles]];
    } while (NO);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_titleItem release];
    [_scribbleManager release];
    [super dealloc];
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    CGFloat numberOfPlaceholders = [DCScribbleThumbnailCell numberOfPlaceHolders];
    NSInteger numberOfScribbles = [_scribbleManager numberOfScribbles];
    NSInteger numberOfRows = ceil(numberOfScribbles / numberOfPlaceholders);
    return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DCScribbleThumbnailCell";
    
    DCScribbleThumbnailCell *cell = (DCScribbleThumbnailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DCScribbleThumbnailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    // Configure the cell...
    
    // populate  thumbnails in each cell
    
    // get max number of thumbnail a thumbnail
    // cell can support
    NSInteger numberOfSupportedThumbnails = [DCScribbleThumbnailCell numberOfPlaceHolders];
    
    // we can only add max numberOfSupportedThumbnails
    // at a time in each cell
    // e.g. numberOfSupportedThumbnails = 3
    // thumbnail index in the scribble manager is (row index *3) +0, +1, +2
    NSUInteger rowIndex = [indexPath row];
    NSInteger thumbnailIndex = rowIndex *numberOfSupportedThumbnails;
    NSInteger numberOfScribbles = [_scribbleManager numberOfScribbles];
    for (NSInteger i = 0; i < numberOfSupportedThumbnails && (thumbnailIndex + i) < numberOfScribbles; ++i) {
        UIView *scribbleThumbnail = [_scribbleManager scribbleThumbnailViewAtIndex:thumbnailIndex + i];
        [cell addThumbnailView:scribbleThumbnail atIndex:i];
    }
    
    return cell;
}

#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end
