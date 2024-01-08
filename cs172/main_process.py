import subprocess
import sys

def main(c):

    pipes = []

    for i in range(3):
        pipe = subprocess.Popen(c,stdin=subprocess.PIPE,stdout=subprocess.PIPE)
        pipe.stdin.write(f"process{i+1}".encode('utf-8'))
        pipe.stdin.close()

        pipes.append(pipe)

    # for pipe in pipes:
    #     pipe.wait()
    for pipe in pipes:
        out = pipe.communicate()
        print('out:',out)

if __name__ == '__main__':
    command = 'python child_process.py'
    main(command)