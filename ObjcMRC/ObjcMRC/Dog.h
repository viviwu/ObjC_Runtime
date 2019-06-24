//
//  Dog.h
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "Animal.h"


typedef void(^CallBack)(NSString *_Nullable);

NS_ASSUME_NONNULL_BEGIN

@interface Dog : Animal
//block一般使用copy关键之进行修饰，block使用copy是从MRC遗留下来的“传统”，在MRC中，方法内容的block是在栈区的，使用copy可以把它放到堆区。但在ARC中写不写都行：编译器自动对block进行了copy操作。
@property (nonatomic, copy) CallBack aBlock;


@end

NS_ASSUME_NONNULL_END
