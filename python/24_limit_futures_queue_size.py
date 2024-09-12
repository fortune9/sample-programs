#!/usr/bin/env python3

import concurrent.futures
import time
import threading

def task(n):
    print(f"Task {n} submitted")
    time.sleep(n)
    return f"Task with sleep {n} completed"

max_queue_size = 5  # Limit the number of active submissions
semaphore = threading.Semaphore(max_queue_size)

def limited_submit(executor, n):
    with semaphore:
        print(f"Submitting task {n} with semaphore")
        future = executor.submit(task, n)
        return future

with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
    futures = []
    
    # Submit tasks with the semaphore to limit how many get submitted at once
    for i in range(100):
        print(f"Submitting task {i}")
        # the following submission is not limited by semaphore at all
        future = limited_submit(executor, i)
        futures.append(future)
    
    for future in concurrent.futures.as_completed(futures):
        print(future.result())
        
