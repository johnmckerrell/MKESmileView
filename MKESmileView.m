//
//  MKESmileView.m
//  SmileViewTester
//
//  Created by John McKerrell on 17/12/2012.
//  Copyright (c) 2012 John McKerrell. All rights reserved.
//

#import "MKESmileView.h"

@implementation MKESmileView

- (id)initWithFrame:(CGRect)frame mainColor:(UIColor*)mainColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.mainColor = mainColor;
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupObject];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupObject];
    }
    return self;
}

- (void)setupObject {
    [self addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"mainColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"smileColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"mainStrokeWidth" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"smileStrokeWidth" options:NSKeyValueObservingOptionNew context:nil];
    self.mainStrokeWidth = 1.0;
    self.smileStrokeWidth = 1.0;
}

- (void)dealloc {
    self.mainColor = nil;
    [self removeObserver:self forKeyPath:@"value"];
    [self removeObserver:self forKeyPath:@"mainColor"];
    
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect frame = self.frame;
    if (frame.size.width > frame.size.height) {
        frame.origin.x = (frame.size.width - frame.size.height) / 2;
        frame.size.width = frame.size.height;
    } else {
        frame.origin.y = (frame.size.height - frame.size.width) / 2;
        frame.size.height = frame.size.width;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetStrokeColorWithColor(context, self.mainColor.CGColor);
    CGContextSetLineWidth(context, self.mainStrokeWidth);
    
    CGRect rectangle = frame;
    
    CGContextAddEllipseInRect(context, rectangle);
    
    CGContextStrokePath(context);
    
    CGRect eyeFrame = CGRectMake(frame.origin.x+(0.2*frame.size.width), frame.origin.y+(0.3*frame.size.height), frame.size.width*0.1, frame.size.height*0.1);
    
    CGContextAddEllipseInRect(context, eyeFrame);

    CGContextStrokePath(context);
    
    eyeFrame.origin.x = frame.origin.x+(0.7*frame.size.width);
    
    CGContextAddEllipseInRect(context, eyeFrame);
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, frame.origin.x+(0.2*frame.size.width), frame.origin.y+(0.7*frame.size.height));
    
    CGContextAddQuadCurveToPoint(context, frame.origin.x+(0.5*frame.size.width), frame.origin.y+((0.4+(0.6*self.value))*frame.size.height),frame.origin.x+(0.8*frame.size.width), frame.origin.y+(0.7*frame.size.height));
    
    CGContextSetLineCap(context, kCGLineCapRound);

    CGContextSetStrokeColorWithColor(context, self.smileColor.CGColor);

    CGContextSetLineWidth(context, self.smileStrokeWidth);
    CGContextStrokePath(context);

    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

@end
