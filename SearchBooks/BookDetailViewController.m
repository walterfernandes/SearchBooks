//
//  DetailViewController.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

@import MBProgressHUD;
@import AFNetworking;

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleLabel.text = self.detailItem.title;
        self.authorLabel.text = [NSString stringWithFormat:@"by %@", self.detailItem.author];

        if (self.detailItem.rating > 4.5f) {
            self.ratingLabel.text = @"⭐︎⭐︎⭐︎⭐︎⭐︎";
        }
        if (self.detailItem.rating > 3.5f) {
            self.ratingLabel.text = @"⭐︎⭐︎⭐︎⭐︎☆";
        }
        else if (self.detailItem.rating >= 2.5f) {
            self.ratingLabel.text = @"⭐︎⭐︎⭐︎☆☆";
        }
        else if (self.detailItem.rating >= 1.5f) {
            self.ratingLabel.text = @"⭐︎⭐︎☆☆☆";
        }
        else if (self.detailItem.rating >= 1.0f) {
            self.ratingLabel.text = @"⭐︎☆☆☆☆";
        }
        else {
            self.ratingLabel.text = @"☆☆☆☆☆";
        }
        
        [self.bookImageView setImageWithURL:self.detailItem.imageURL];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
