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

def limited_task(n):
    with semaphore:
        result = task(n)
        return result

with concurrent.futures.ThreadPoolExecutor() as executor:
    futures = []
    
    # Submit tasks with the semaphore to limit how many get submitted at once
    for i in range(100):
        future = executor.submit(limited_task, i)
        futures.append(future)
    
    for future in concurrent.futures.as_completed(futures):
        print(future.result())
        
