//
//  ViewController.m
//  Algorithm&DataStructure
//
//  Created by He yang on 2017/4/8.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


struct ListNode {
    int value;
    struct ListNode *next;
};

struct BinaryTreeNode {
    int value;
    struct BinaryTreeNode *pleft;
    struct BinaryTreeNode *pright;
};

void DeleteNode(struct ListNode **headNode,struct ListNode *toBeDeletedNode){
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

void recorderOddEven(int *pData,int length,bool (*func) (int)){
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
struct ListNode * findNthTotail(struct ListNode * plistHead,unsigned int k){
    
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
struct ListNode * reverseList(struct ListNode *phead){
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
struct ListNode *merge(struct ListNode *phead1,struct ListNode *phead2) {
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

bool hasSubtree(struct BinaryTreeNode *pRoot1,struct BinaryTreeNode *pRoot2) {
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

bool doesTree1HaveTree2(struct BinaryTreeNode *pRoot1,struct BinaryTreeNode *pRoot2){
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


@end
