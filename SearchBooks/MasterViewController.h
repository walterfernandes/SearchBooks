//
//  MasterViewController.h
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookDetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) BookDetailViewController *detailViewController;


@end

