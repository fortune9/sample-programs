#!/usr/bin/env python3

import concurrent.futures
import threading
import time

# Settings
max_running_tasks = 5
delay_between_submissions = 1  # seconds

# Shared variable to track running tasks
task_lock = threading.Lock()
running_tasks = 0

def task(n):
    global running_tasks
    with task_lock:
        running_tasks += 1
    try:
        print(f"Running task {n}")
        time.sleep(2)  # Simulate a long-running task
        return f"Task {n} completed"
    finally:
        with task_lock:
            running_tasks -= 1

def submit_tasks(executor, task_args_list):
    futures = []
    
    for task_args in task_args_list:
        while True:
            with task_lock:
                if running_tasks < max_running_tasks:
                    print(f"Submitting task {task_args}")
                    future = executor.submit(task, *task_args)
                    futures.append(future)
                    break  # Task submitted, break out of while loop
            # Delay submission if too many tasks are running
            print("Max running tasks reached, delaying submission...")
            time.sleep(delay_between_submissions)
    
    return futures

def collect_results(futures):
    # Asynchronously collect results as tasks complete
    for future in concurrent.futures.as_completed(futures):
        try:
            print(f"collecting result: {result}")
            result = future.result()
            print(result)  # Handle the result (e.g., print or store it)
        except Exception as e:
            print(f"Task raised an exception: {e}")

# Main Execution
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
    task_args_list = [(i,) for i in range(20)]  # List of task arguments

    # Start a separate thread for result collection
    # this seems not working, as it does not delay job submission
    futures = []
    result_collector_thread = threading.Thread(target=collect_results, args=(futures,))
    result_collector_thread.start()

    # Submit tasks with controlled submission rate
    futures.extend(submit_tasks(executor, task_args_list))

    # Wait for result collection to complete
    result_collector_thread.join()
