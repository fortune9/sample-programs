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


def consume(item):
    print(f"Consumer consumed: {item}")
    time.sleep(2)  # Simulate processing time for each item
    return f"Done {item}"

def limited_consumer(executor, *args, **kwargs):
    while True:
        item = q.get()
        if item is None:  # Check for the sentinel to stop consuming
            break
        future=executor.submit(consume, item) # this doesn't block
        consumer_futures.append(future)
        #print(f"In limited_consumer: {future.result()}")
    print("Limited consumer done")

# Number of parallel consumers
consumer_count = 3

# Producer thread
producer_process = multiprocessing.Process(target=producer)

# Start the producer
producer_process.start()

consumer_futures = []
# Start the consumers using a process pool
with concurrent.futures.ProcessPoolExecutor(max_workers=consumer_count) as executor:
    #consumer_futures = [executor.submit(consumer, i) for i in range(consumer_count)]
    limited_consumer(executor)

    # Wait for all consumers to finish
    for future in concurrent.futures.as_completed(consumer_futures):
        print(f"Collecting results: {future.result()}")

# Wait for the producer to finish
producer_process.join()

print("This setting can't limit the number of submitted tasks")

