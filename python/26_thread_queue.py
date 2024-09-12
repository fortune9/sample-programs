#!/usr/bin/env python

import threading
import queue
import time

# Create a queue with a maximum size of 5
max_queue_size = 5
q = queue.Queue(maxsize=max_queue_size)

def producer():
    for i in range(20):
        # Simulate data production
        item = f"Item {i}"
        q.put(item)  # This will block if the queue is full (maxsize reached)
        print(f"Produced: {item}")
        time.sleep(1)  # Simulate delay between producing items

    q.put(None)  # Sentinel to signal the consumer to stop

def consumer():
    while True:
        item = q.get()  # Get item from the queue (blocks if the queue is empty)
        if item is None:  # Check for the sentinel to stop consuming
            break
        print(f"Consumed: {item}")
        time.sleep(2)  # Simulate processing time for each item
    print("Consumer finished.")

# Start producer and consumer threads
producer_thread = threading.Thread(target=producer)
consumer_thread = threading.Thread(target=consumer)

producer_thread.start()
consumer_thread.start()

# Wait for both threads to finish
producer_thread.join()
consumer_thread.join()

