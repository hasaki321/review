import time
import sys

def main(word):
    for i in range(3):
        time.sleep(1)
        print(f"{word} sec {i+1}\n")

if __name__ == '__main__':
    stdin = sys.stdin.buffer.read()
    word = stdin.decode('utf-8')
    main(word)