//
//  DetailViewController.h
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookDetailViewController : UIViewController

@property (strong, nonatomic) Book *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@end

