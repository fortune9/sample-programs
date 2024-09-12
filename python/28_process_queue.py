#!/usr/bin/env python3

import concurrent.futures
import queue
import time
import multiprocessing

# Create a queue with a maximum size of 5
max_queue_size = 5
q = multiprocessing.Queue(maxsize=max_queue_size)

def producer():
    for i in range(20):
        # Simulate data production
        item = f"Item {i}"
        q.put(item)  # This will block if the queue is full (maxsize reached)
        print(f"Produced: {item}")
        #time.sleep(0.5)  # Simulate delay between producing items

    # Put None as sentinel values for each consumer to stop processing
    for _ in range(consumer_count):
        q.put(None)

def consumer(consumer_id):
    while True:
        item = q.get()  # Get item from the queue (blocks if the queue is empty)
        if item is None:  # Check for the sentinel to stop consuming
            break
        print(f"Consumer {consumer_id} consumed: {item}")
        time.sleep(2)  # Simulate processing time for each item
    print(f"Consumer {consumer_id} finished.")

# Number of parallel consumers
consumer_count = 3

# Producer thread
producer_process = multiprocessing.Process(target=producer)

# Start the producer
producer_process.start()

# Start the consumers using a process pool
with concurrent.futures.ProcessPoolExecutor(max_workers=consumer_count) as executor:
    consumer_futures = [executor.submit(consumer, i) for i in range(consumer_count)]

# Wait for all consumers to finish
for future in concurrent.futures.as_completed(consumer_futures):
    future.result()

# Wait for the producer to finish
producer_process.join()

