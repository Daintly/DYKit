//
//  UILabel+DY_Extension.m
//  HSQ
//
//  Created by Dainty on 17/3/13.
//  Copyright © 2017年 DAINTY. All rights reserved.
//

#import "UILabel+DY_Extension.h"
#import "UIColor+DY_Extension.h"
@implementation UILabel (DY_Extension)

+ (instancetype)initWithFontSize: (CGFloat)fontSize numberOfLines: (NSInteger)numberOfLines{
    
    UILabel *lb = [[UILabel alloc] init];
    
   
        lb.font = [UIFont systemFontOfSize:FontSize(fontSize)];

      lb.numberOfLines = numberOfLines;
    return lb;
}

+ (instancetype)initWithFontSize:(CGFloat)fontSize numberOfLines:(NSInteger)numberOfLines textColor:(NSString *)hex{
    
    UILabel *lb = [[UILabel alloc] init];
    lb.font = [UIFont systemFontOfSize:FontSize(fontSize)];
    lb.numberOfLines = numberOfLines;
    lb.textColor = [UIColor colorWithHexString:hex];
    return lb;
    
}

+ (instancetype)paraStyleWithFontSize:(CGFloat)fontSize numberOfLines: (NSInteger)numberOfLines textColor:(NSString *)hexY paraStyleSize:(CGFloat)paraStyleSize {
    UILabel *lb = [[UILabel alloc] init];
    lb.font = [UIFont systemFontOfSize:FontSize(fontSize)];
    lb.numberOfLines = numberOfLines;
    lb.textColor = [UIColor colorWithHexString:hexY];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;
    //        CGFloat p = 12 * 2;
    CGFloat p = 12 * 2;
    paraStyle.firstLineHeadIndent = p;
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:lb.text attributes:@{NSParagraphStyleAttributeName: paraStyle}];
    lb.attributedText = string;
    return lb;

}


//
//- (void)setLineBreakByTruncatingLastLineMiddle{
//    
//    if ( self.numberOfLines <= 0 ) {
//        return;
//    }
//    NSArray *separatedLines = [self getSeparatedLinesFromLabel];
//    
//    NSMutableString *limitedText = [NSMutableString string];
//    if ( separatedLines.count >= self.numberOfLines ) {
//        
//        for (int i = 0 ; i < self.numberOfLines; i++) {
//            if ( i == self.numberOfLines - 1) {
//                UILabel *lastLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, MAXFLOAT)];
//                lastLineLabel.text = separatedLines[self.numberOfLines - 1];
//                
//                NSArray *subSeparatedLines = [lastLineLabel getSeparatedLinesFromLabel];
//                NSString *lastLineText = [subSeparatedLines firstObject];
//                NSInteger lastLineTextCount = lastLineText.length;
//                [limitedText appendString:[NSString stringWithFormat:@"%@......",[lastLineText substringToIndex:lastLineTextCount]]];
//            }else{
//                [limitedText appendString:separatedLines[i]];
//            }
//        }
//        
//        
//    }else{
//        [limitedText appendString:self.text];
//    }
//    
//    self.text = limitedText;
//    
//}
- (void)setLineBreakByTruncatingLastLineMiddle{
    if ( self.numberOfLines <= 0 ) {
        return;
    }
    
    DYLog(@"%ld",(long)self.numberOfLines);
    NSArray *separatedLines = [self getSeparatedLinesArray];
    
    NSMutableString *limitedText = [NSMutableString string];
    if ( separatedLines.count >= self.numberOfLines ) {
        
        for (int i = 0 ; i < self.numberOfLines; i++) {
            if ( i == self.numberOfLines - 1) {
                UILabel *lastLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, MAXFLOAT)];
                lastLineLabel.text = separatedLines[self.numberOfLines - 1];
                
                NSArray *subSeparatedLines = [lastLineLabel getSeparatedLinesArray];
                NSString *lastLineText = [subSeparatedLines firstObject];
                NSInteger lastLineTextCount = lastLineText.length;
                [limitedText appendString:[NSString stringWithFormat:@"%@...",[lastLineText substringToIndex:lastLineTextCount]]];
            }else{
                [limitedText appendString:separatedLines[i]];
            }
        }
        
        
    }else{
        [limitedText appendString:self.text];
    }
    
    self.text = limitedText;
    
}

//获取每行的字符串.，改为UIlabel分类
//+(NSArray)getSeparatedLinesFromLabel:(UILabel *)lable;
- (NSArray *)getSeparatedLinesFromLabel
{
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    
    NSLog( @" %@",linesArray);
    return (NSArray *)linesArray;
    
    
}


- (NSArray *)getSeparatedLinesArray
{
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    //rect.size.width
    CGPathAddRect(path, NULL, CGRectMake(0,0,KScreenW - 80,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    
    NSLog(@"%@",linesArray);
    return (NSArray *)linesArray;
}

/**
 为UILabel首部设置图片标签
 
 @param text 文本
 @param images 标签数组
 @param span 标签间距
 */
-(void)setText:(NSString *)text frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span
{
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    //设置显示文本
    [textAttrStr appendAttributedString:[[NSAttributedString alloc]initWithString:text]];
    
     [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"   "]];
    for (UIImage *img in images) {//遍历添加标签
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        //计算图片大小，与文字同高，按比例设置宽度
        CGFloat imgH = self.font.pointSize;
        // DYLog( @"%f",img.size.width);
        CGFloat imgW = (img.size.width / img.size.height) * imgH;
        
        
        attach.bounds = CGRectMake(0, -2 ,imgW  , imgH);
        
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        [textAttrStr appendAttributedString:imgStr];
        //标签后添加空格
        [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
    }
    
 
    //设置间距
    if (span != 0) {
//        [textAttrStr addAttribute:NSKernAttributeName value:@(span)
//                            range:NSMakeRange(10, images.count * 2/*由于图片也会占用一个单位长度,所以带上空格数量，需要 *2 */)];
        
        [textAttrStr addAttribute:NSKernAttributeName value:@(span) range:NSMakeRange(0, images.count * 2)];
    }
    
    self.attributedText = textAttrStr;

  
    
   
}


- (void)setText:(NSString *)text
      imageSize:(CGFloat)imageSize frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span{
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    //设置显示文本
    [textAttrStr appendAttributedString:[[NSAttributedString alloc]initWithString:text]];
    
    [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    for (UIImage *img in images) {//遍历添加标签
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        //计算图片大小，与文字同高，按比例设置宽度
        if (!imageSize) {
            imageSize = 1;
        }
        CGFloat imgH = self.font.pointSize * imageSize;
        // DYLog( @"%f",img.size.width);
        CGFloat imgW = (img.size.width / img.size.height) * imgH;
        
        
        attach.bounds = CGRectMake(0, 0 ,imgW  , imgH);
        
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        [textAttrStr appendAttributedString:imgStr];
        //标签后添加空格
        [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"    "]];
    }
    
    
    //设置间距
    if (span != 0) {
        //        [textAttrStr addAttribute:NSKernAttributeName value:@(span)
        //                            range:NSMakeRange(10, images.count * 2/*由于图片也会占用一个单位长度,所以带上空格数量，需要 *2 */)];
        
        [textAttrStr addAttribute:NSKernAttributeName value:@(span) range:NSMakeRange(0, images.count * 2)];
    }
    
    self.attributedText = textAttrStr;
    
    
}
- (void)leftPicSetText:(NSString *)text frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span{
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    //设置显示文本
      for (UIImage *img in images) {//遍历添加标签
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        //计算图片大小，与文字同高，按比例设置宽度
        CGFloat imgH = self.font.pointSize;
        // DYLog( @"%f",img.size.width);
        CGFloat imgW = (img.size.width / img.size.height) * imgH;
        attach.bounds = CGRectMake(0, -2 ,imgW  , imgH);
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        [textAttrStr appendAttributedString:imgStr];
        //标签后添加空格
        [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    
   
    [textAttrStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:text]];

 
    //设置间距
    if (span != 0) {
        [textAttrStr addAttribute:NSKernAttributeName value:@(span)
                            range:NSMakeRange(0, images.count * 2/*由于图片也会占用一个单位长度,所以带上空格数量，需要 *2 */)];
    }
    
    self.attributedText = textAttrStr;
}

- (void)leftPicWithText:(NSString *)text imageSize:(CGFloat)imageSize frontImages:(NSArray<UIImage *> *)images imageSpan:(CGFloat)span{
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    //设置显示文本
    for (UIImage *img in images) {//遍历添加标签
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        //计算图片大小，与文字同高，按比例设置宽度
        CGFloat imgH = self.font.pointSize *imageSize;
        // DYLog( @"%f",img.size.width);
        CGFloat imgW = (img.size.width / img.size.height) * imgH;
        attach.bounds = CGRectMake(0, -2 ,imgW  , imgH);
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        [textAttrStr appendAttributedString:imgStr];
        //标签后添加空格
        [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    
    
    [textAttrStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:text]];
    
    
    //设置间距
    if (span != 0) {
        [textAttrStr addAttribute:NSKernAttributeName value:@(span)
                            range:NSMakeRange(0, images.count * 2/*由于图片也会占用一个单位长度,所以带上空格数量，需要 *2 */)];
    }
    
    self.attributedText = textAttrStr;
}

@end
