import threading
import queue
import time

class Worker(threading.Thread):
    def __init__(self, queue, id):
        super().__init__()
        self.queue = queue
        self.id = id

    def run_task(self,task):
        time.sleep(.5)
        print(f"{self.id}: {task}")

    def run(self):
        while not self.queue.empty():
            task = self.queue.get()
            self.run_task(task)
            self.queue.task_done()

def main():
    q = queue.Queue(10)

    for i in range(10):
        q.put(i+1)


    threads = []
    for i in range(5):
        w = Worker(q,f"threading {i+1}")
        w.daemon = True
        w.start()
        threads.append(w)

    for thread in threads:
        thread.join()

    for i in range(5):
        t = threading.Thread(target=print,args=[i,i+1])
        t.start()

if __name__ == '__main__':
    main()