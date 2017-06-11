//
//  Test.c
//  Algorithm&DataStructure
//
//  Created by He yang on 2017/6/5.
//  Copyright © 2017年 He yang. All rights reserved.
//

#include "Test.h"
int sum(int x,int y) {
    return x+y;
}

int test(int x,int y) {
    int b = 1;
    int a = b + sum(1, 2);
    return a;
}
