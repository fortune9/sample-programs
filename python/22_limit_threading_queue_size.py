#!/usr/bin/env python3

import threading
import time

# Create a semaphore with 3 permits
semaphore = threading.Semaphore(3)

def task(resource_id):
    with semaphore: # Acquire the semaphore
        print(f"Task {resource_id} is submitted")
        time.sleep(resource_id)
        print(f"Thread {resource_id} completed.")

# Create and start threads
threads = []
for i in range(5,11):
    thread = threading.Thread(target=task, args=(i,), name=f"Thread-{i}")
    thread.start() # this will not block
    threads.append(thread)

# Join threads and print which thread is being joined
for thread in threads:
    print(f"Joining {thread.name}")
    thread.join()
    print(f"{thread.name} has been joined.")

