//
//  BookCell.h
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 08/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
