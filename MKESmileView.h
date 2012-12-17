//
//  MKESmileView.h
//  SmileViewTester
//
//  Created by John McKerrell on 17/12/2012.
//  Copyright (c) 2012 John McKerrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKESmileView : UIView

@property (nonatomic,retain) UIColor *mainColor;
@property (nonatomic,retain) UIColor *smileColor;
@property (nonatomic,assign) CGFloat value;
@property (nonatomic,assign) CGFloat mainStrokeWidth;
@property (nonatomic,assign) CGFloat smileStrokeWidth;

@end
