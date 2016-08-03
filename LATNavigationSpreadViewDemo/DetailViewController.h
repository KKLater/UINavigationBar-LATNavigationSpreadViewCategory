//
//  DetailViewController.h
//  LATNavigationSpreadViewDemo
//
//  Created by Later on 16/8/3.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

