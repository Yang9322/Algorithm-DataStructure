//
//  ViewController.m
//  Algorithm&DataStructure
//
//  Created by He yang on 2017/4/8.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "ViewController.h"
struct ListNode {
    int value;
    struct ListNode *next;
};

struct BinaryTreeNode {
    int value;
    struct BinaryTreeNode *pleft;
    struct BinaryTreeNode *pright;
};

struct ComplexListNode {
    int value;
    struct ComplexListNode *next;
    struct ComplexListNode *pSibing;
};

@interface ViewController ()

@end

@implementation ViewController {
    struct BinaryTreeNode *root;
    NSMutableArray * _values;
    int _sumValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _values = @[].mutableCopy;
//    int a[] = {100,50,25,10,30,65,70,55,120,110,130};
//    int b[] = {5,7,6,9,11,10,8};
//    bool result = verifySequenceOfTree(a, 11);
//    bool result2 = verifySequenceOfBST(b, 7);
//    
//    [self generateBinaryTree];
//    
//    printBinaryTreeFromTopToBottom(root);
//    
//    [self findPath:root goal:8];
    char str[] = "abc";
    
    permutate(str);
    
    NSArray *array  = @[@(7),@(3),@(11),@(1),@(5), @(9),@(13)];
    NSArray *a = [self findMinNumbers:array limit:5];
    
}

- (NSUInteger)binarySearch:(NSArray *)numbers baseLine:(int)baseline {
    NSInteger min = 0;
    NSInteger max = numbers.count - 1;
    NSInteger mid = ceilf((min + max) / 2.f);
    while (mid > min && mid < max) {
        NSNumber *midNum = numbers[mid];
        if (midNum.integerValue <= baseline) {
            NSNumber *nextnumber = numbers[mid+1];
            if (nextnumber.integerValue > baseline) {
                mid++;
                break;
            }
            min = mid;
        }else{
            max = mid;
        }
        mid = ceilf((CGFloat)(min + max) / 2.f);
    }
    return mid;
}


//
//void testStackWithParam1(int a, int b) {
//    printf("%p\n",a);
//    printf("%p",b);
//}


- (void)generateBinaryTree {
    struct BinaryTreeNode *node6 = calloc(1, sizeof(struct BinaryTreeNode));
    node6->value = 6;
    node6->pleft = NULL;
    node6->pright = NULL;
    
    struct BinaryTreeNode *node5 = calloc(1, sizeof(struct BinaryTreeNode));
    node5->value = 5;
    node5->pleft = NULL;
    node5->pright = NULL;
    
    struct BinaryTreeNode *node4 = calloc(1, sizeof(struct BinaryTreeNode));
    node4->value = 4;
    node4->pleft = NULL;
    node4->pright = NULL;
    
    struct BinaryTreeNode *node3 = calloc(1, sizeof(struct BinaryTreeNode));
    node3->value = 3;
    node3->pleft = NULL;
    node3->pright = NULL;
    
    struct BinaryTreeNode *node2 = calloc(1, sizeof(struct BinaryTreeNode));
    node2->value = 2;
    node2->pleft = node5;
    node2->pright = node6;
    
    struct BinaryTreeNode *node1 = calloc(1, sizeof(struct BinaryTreeNode));
    node1->value = 1;
    node1->pleft = node3;
    node1->pright = node4;
    
    root = calloc(1, sizeof(struct BinaryTreeNode));
    root->value = 0;
    root->pleft = node1;
    root->pright = node2;
}

void DeleteNode (struct ListNode **headNode,struct ListNode *toBeDeletedNode) {
    if (!headNode || !toBeDeletedNode) {
        return;
    }
    // condition 1 : middle node
    if (toBeDeletedNode->next != NULL) {
        
        struct ListNode *next = toBeDeletedNode -> next;
        toBeDeletedNode -> value = next->value;
        toBeDeletedNode -> next = next ->next;
        free(next);
        next = NULL;
        
    }//condition 2 : headNode
    else if(*headNode == toBeDeletedNode){
        free(toBeDeletedNode);
        toBeDeletedNode = NULL;
        *headNode = NULL;
    }
    //condition 3 : tailNode
    else{
        struct ListNode *node = *headNode;
        while (node->next != toBeDeletedNode) {
            node = node -> next;
        }
        node->next = NULL;
        free(toBeDeletedNode);
        toBeDeletedNode = NULL;
    }
}

void recorderOddEven (int *pData,int length,bool (*func) (int)) {
    if (pData == NULL || length == 0) {
        return;
    }
    
    int *pBegin = pData;
    int *pEnd = pData + length - 1;
    while (pBegin < pEnd) {
        while (pBegin < pEnd && !func(*pBegin)) {
            pBegin ++;
        }
        while (pBegin < pEnd && func(*pEnd)) {
            pEnd --;
        }
        
        if (pBegin < pEnd) {
            int tmp = *pBegin;
            *pBegin = *pEnd;
            *pEnd = tmp;
        }
    }
}

bool isEven(int n){
    return (n&1) ==0;
}

//发现倒数第N个链表
struct ListNode * findNthTotail (struct ListNode * plistHead,unsigned int k) {
    
    if (plistHead == NULL || k <= 0 ) {
        return NULL;
    }
    
    struct ListNode *pAhead = plistHead;
    struct ListNode *pBehind = NULL;
    
    for (unsigned int i = 0; i < k-1; ++i) {
        if (pAhead -> next != NULL) {
            pAhead = pAhead -> next;
            
        }else{
            return NULL;
        }
    }
    
    pBehind = plistHead;
    
    while (pAhead -> next != NULL) {
        pAhead = pAhead -> next;
        pBehind = pBehind -> next;
    }
    return pBehind;
}

//反转链表
struct ListNode * reverseList (struct ListNode *phead) {
    if (phead == NULL) {
        return NULL;
    }
    
    struct ListNode *pReverseHead = NULL;
    struct ListNode *pPrev = NULL;
    struct ListNode *pNode = phead;
    
    while (pNode != NULL) {
        if (pNode -> next ==NULL) {
            pReverseHead = phead;
            return pReverseHead;
        }
        struct ListNode *pNext = pNode -> next;
        if (pNext == NULL) {
            pReverseHead = pNode;
        }
        pNode -> next = pPrev;
        pPrev = pNode;
        pNode = pNext;
        
    }
    return pReverseHead;
    
}

//合并顺序排列的链表
struct ListNode *merge (struct ListNode *phead1,struct ListNode *phead2) {
    if (phead1 == NULL) {
        return phead2;
    }
    else if (phead2 == NULL) {
        return phead1;
    }
    
    struct ListNode *pMergeHead = NULL;
    if (phead1 -> value < phead2 -> value) {
        pMergeHead = phead1;
        pMergeHead -> next = merge(phead1 -> next, phead2);
    }
    else {
        pMergeHead = phead2;
        pMergeHead ->next = merge(phead1, phead2 -> next);
    }
    return pMergeHead;
}

//是否有子树
bool hasSubtree (struct BinaryTreeNode *pRoot1,struct BinaryTreeNode *pRoot2) {
    bool result = false;
    if (pRoot1 != NULL && pRoot2 != NULL) {
        if (pRoot1 -> value == pRoot2 -> value) {
            result = doesTree1HaveTree2(pRoot1, pRoot2);
        }
        if (!result) {
            result = hasSubtree(pRoot1->pleft, pRoot2);
        }
        if (!result) {
            result = hasSubtree(pRoot1->pright, pRoot2);
        }
    }
    return result;
}

bool doesTree1HaveTree2 (struct BinaryTreeNode *pRoot1,struct BinaryTreeNode *pRoot2) {
    if (pRoot2 == NULL) {
        return true;
    }
    if (pRoot1 == NULL) {
        return false;
    }
    if (pRoot1->value != pRoot2->value) {
        return false;
    }
    return doesTree1HaveTree2(pRoot1->pleft, pRoot2->pleft) && doesTree1HaveTree2(pRoot1->pright, pRoot2->pright);
}

//镜像二叉树
void mirrorRecursively (struct BinaryTreeNode *pRoot) {
    if (pRoot == NULL) {
        return;
    }
    if (pRoot->pleft == NULL && pRoot->pright == NULL) {
        return;
    }
    
    struct BinaryTreeNode *tmpNode = pRoot->pleft;
    pRoot->pleft = pRoot->pright;
    pRoot->pright = tmpNode;
    if (pRoot->pleft) {
        mirrorRecursively(pRoot->pleft);
    }
    if (pRoot->pright) {
        mirrorRecursively(pRoot->pright);
    }
}

// 打印矩阵
void printMatrixClockWisely (int **numbers,int columns,int rows) {
    if (numbers == NULL || columns <= 0 || rows <= 0) {
        return;
    }
    
    int start = 0;
    while (columns > start * 2 && rows > start * 2) {
        
        printMatrixInCircle (numbers, columns, rows,start);
        ++start;
    }
    
    
}

void printMatrixInCircle (int **numbers,int columns,int rows,int start) {
   
    int endX = columns - start - 1;
    int endY = rows - start - 1;
    
    for (int i = start; i <= endX; i++) {
        int number = numbers[start][i];
        printf("%d", number);
    }
    
    if (start < endY)
    {
        for (int i = start + 1; i <= endY; i++) {
            int number = numbers[i][endX];
            printf("%d", number);
        }
        
        if (start < endX)
        {
            for (int i = endX - 1; i >= start; i--) {
                int number = numbers[i][endX];
                printf("%d",number);
            }
            
            if (start < endX - 1)
            {
                
                for (int i = endY - 1; i >= start + 1; i--) {
                    int number = numbers[i][start];
                    printf("%d",number);
                }
            }
        }
    }
    
}

void printBinaryTreeFromTopToBottom (struct BinaryTreeNode *pRoot) {
    if (!pRoot) {
        return;
    }
    
    NSMutableArray *queue = @[].mutableCopy;
    [queue addObject:[NSValue valueWithPointer:pRoot]];
    
    while (queue.count) {
        NSValue *pointer = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        struct BinaryTreeNode *node = pointer.pointerValue;
//        printf("%d\n",node->value);
        
        if (node->pleft) {
            [queue addObject:[NSValue valueWithPointer:node->pleft]];
        }
        if (node->pright) {
            [queue addObject:[NSValue valueWithPointer:node->pright]];
        }
    }
}

//后序二叉树
bool verifySequenceOfBST(int sequence[], int length) {
    if (sequence == NULL || length <= 0) {
        return NO;
    }
    
    int root = sequence[length - 1];
    int i = 0;
    for (i = 0; i<length - 1; i++) {
        if (sequence[i] > root) {
            break;
        }
    }
    
    for (int j = i; j < length - 1; j++) {
        if (sequence[j] < root) {
            return NO;
        }
    }
    
    bool left = true;
    if (i > 0) {
        left = verifySequenceOfBST(sequence, i);
    }
    
    bool right = true;
    if (i < length - 1) {
        right = verifySequenceOfBST(sequence + i, length - i - 1);
    }
    
    
    
    return left && right;
}

//前序二叉树
bool verifySequenceOfTree(int sequence[],int length) {
    if (sequence == NULL || length <= 0) {
        return NO;
    }
    
    int root = sequence[0];
    int i = 1;
    for (; i < length; i++) {
        if (sequence[i] > root) {
            break;
        }
    }
    
    int j = i;
    for (; j < length; j++) {
        if (sequence[j] < root) {
            return false;
        }
    }
    
    bool left = true;
    if (i > 1) {
        left = verifySequenceOfTree(sequence+1, i-1);
    }
    
    bool right = true;
    if (i < length) {
        right = verifySequenceOfTree(sequence + i, length - i);
    }
    
    return left && right;
}

//路径搜索
- (void)findPath:(struct BinaryTreeNode *)pRoot goal:(int)goal {
        if (!pRoot) {
            return;
        }
        _sumValue = 0;
    [self recursivelyFindWithRoot:pRoot goal:goal];
}

- (void)recursivelyFindWithRoot:(struct BinaryTreeNode *)pRoot goal:(int)goal{
    _sumValue += pRoot -> value;
    int intValue = pRoot -> value;
    [_values addObject:@(intValue)];
    bool isLeaf = pRoot -> pleft == NULL && pRoot -> pright == NULL;
    if (_sumValue == goal && isLeaf) {
        for (NSNumber *number in _values) {
            NSLog(@"\nbegin---\n%@\n---end",number );
        }
    }
    if (pRoot -> pleft) {
        [self recursivelyFindWithRoot:pRoot -> pleft goal:goal];
    }
    if (pRoot -> pright) {
        [self recursivelyFindWithRoot:pRoot -> pright goal:goal];
    }
    NSNumber *lastNumer = [_values lastObject];
    _sumValue -= [lastNumer intValue];
    [_values removeLastObject];
}

//复杂链表的复制
void cloneNode(struct ComplexListNode *pHead) {
    struct ComplexListNode *pNode = pHead;
    while (pNode) {
        struct ComplexListNode *pCloned = calloc(1, sizeof(struct ComplexListNode));
        pCloned->value = pNode->value;
        pCloned->next = pNode->next;
        pCloned->pSibing = NULL;
        pNode->next = pCloned;
        pNode = pCloned->next;
    }
}

void connectionSiblingNodes(struct ComplexListNode *pHead) {
    struct ComplexListNode *pNode = pHead;
    while (pNode) {
        struct ComplexListNode *pCloned = pNode->next;
        if (pNode->pSibing) {
            pCloned->pSibing = pNode->pSibing->next;
        }
        pNode = pCloned->next;
    }
}

struct ComplexListNode *reconnectNodes(struct ComplexListNode * pHead) {
    struct ComplexListNode *pNode = pHead;
    struct ComplexListNode *pClonedHead = NULL;
    struct ComplexListNode *pClonedNode = NULL;
    if (pNode) {
        pClonedHead = pClonedNode = pNode->next;
        pNode->next = pClonedNode->next;
        pNode = pNode->next;
    }
    while (pNode) {
        pClonedNode->next = pNode->next;
        pClonedNode=pClonedNode->next;
        pNode->next = pClonedNode->next;
        pNode = pNode->next;
    }
    return pClonedHead;
}

struct ComplexListNode *clone(struct ComplexListNode * pHead) {
    cloneNode(pHead);
    connectionSiblingNodes(pHead);
    return reconnectNodes(pHead);
}

//二叉树转换为双向链表
struct BinaryTreeNode *convert(struct BinaryTreeNode *pRootOfTree) {
    struct BinaryTreeNode *pLastNodeInList = NULL;
    convertNode(pRootOfTree, &pLastNodeInList);
    struct BinaryTreeNode *pHeadOfList = pLastNodeInList;
    while (pHeadOfList !=NULL && pHeadOfList -> pleft) {
        pHeadOfList = pHeadOfList -> pleft;
    }
    return pHeadOfList;
}

void convertNode(struct BinaryTreeNode *pNode, struct BinaryTreeNode **pLastNodeInList) {
    if (!pNode) {
        return;
    }
    struct BinaryTreeNode *pCurrent = pNode;
    if (pCurrent->pleft!=NULL) {
        convertNode(pCurrent->pleft, pLastNodeInList);
    }
    pCurrent->pleft = *pLastNodeInList;
    
    if (*pLastNodeInList != NULL) {
        (*pLastNodeInList)->pright = pCurrent;
    }
    
    *pLastNodeInList = pCurrent;
     
    if (pCurrent->pright) {
        convertNode(pCurrent->pright, pLastNodeInList);
    }
    
}

void recursivelyPermutate(char *pStr,char *pBegin) {
    if (*pBegin == '\0') {
        printf("%s\n",pStr);
    }
    else {
        for (char *pCh = pBegin; *pCh != '\0'; ++pCh) {
            char temp = *pCh;
            *pCh = *pBegin;
            *pBegin = temp;
            recursivelyPermutate(pStr, pBegin+1);
            temp = *pCh;
            *pCh = *pBegin;
            *pBegin = temp;
        }
    }
}

void permutate(char *pStr) {
    if (pStr == NULL) {
        return;
    }
    recursivelyPermutate(pStr, pStr);
}


//最小的k个数
- (NSArray *)findMinNumbers:(NSArray *)numbers limit:(int)limit {
    if (numbers.count <= 0 || !numbers || limit <= 0) {
        return nil;
    }
    NSNumber *minNumber = numbers[0];
    NSMutableArray *output = @[].mutableCopy;
    for (int i = 0; i < numbers.count; i++) {
        NSNumber *number = numbers[i];
        if (i > limit - 1) {
            if (number < minNumber) {
                [self addNumber:number InArray:output];
                [output removeLastObject];
                minNumber = [output lastObject];
            }
        }
        else {
            minNumber = minNumber > number ? minNumber : number;
            [self addNumber:number InArray:output];
        }
    }
    return output.copy;
}


- (void)addNumber:(NSNumber *)number InArray:(NSMutableArray *)output {
    if (output.count) {
        NSNumber *firstNum = output[0];
        NSNumber *lastNum = [output lastObject];
        if (firstNum > number) {
            [output insertObject:number atIndex:0];
            return;
        }
        if (number > lastNum) {
            [output addObject:number];
            return;
        }
    }
    int index = [self binarySearchNumber:number min:0 max:(int)output.count - 1 numbers:output];
    [output insertObject:number atIndex:index];
}

- (int)binarySearchNumber:(NSNumber *)number min:(int)min max:(int)max numbers:(NSMutableArray *)output{
    if (max < 0) {
        return 0;
    }
    else {
        int mid = ceilf((CGFloat)(min + max) / 2.f);
        while (mid > min && mid < max ) {
            NSNumber *middleNum = output[mid];
            if (number >= middleNum) {
                NSNumber *nextnumber = output[mid+1];
                if (number < nextnumber) {
                    mid++;
                    break;
                }
                min = mid;
            }
            else {
                max = mid;
            }
            mid = ceilf((CGFloat)(min + max) / 2.f);
        }
        return mid;
    }
}

@end
