//
//  OperationStack.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class OperationStack: OperationQueue {
    - (NSOperationQueue *)addOperation:(NSOperation *)operation toHeadOfQueue:(NSOperationQueue *)queue
    {
    // suspending a queue prevents it from issuing new operations; it doesn't
    // pause any already ongoing operations. So we do this to prevent a race
    // condition as we copy operations from the queue
    queue.suspended = YES;
    
    // create a new queue
    NSOperationQueue *mutatedQueue = [[NSOperationQueue alloc] init];
    
    // add the new operation at the head
    [mutatedQueue addOperation:operation];
    
    // copy in all the preexisting operations that haven't yet started
    for(NSOperation *operation in [queue operations])
    {
    if(!operation.isExecuting)
    [mutatedQueue addOperation:operation];
    }
    
    // the caller should now ensure the original queue is disposed of...
    }
    
    /* ... elsewhere ... */
    
    NSOperationQueue *newQueue = [self addOperation:newOperation toHeadOfQueue:operationQueue];
    [operationQueue release];
    operationQueue = newQueue;

}
