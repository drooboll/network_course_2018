import select, subprocess
from subprocess import PIPE
prog = "cat"
prog_arr = prog.split(" ")
print(prog_arr)
process = subprocess.Popen(
    prog_arr,
    stdin=PIPE, stdout=PIPE, stderr=PIPE, bufsize=4096
)
def main():
    process.stdin.write(b'Halo\nWhat\n')
    process.stdin.flush()
    print('x')
    for stdout_line in iter(process.stdout.readline, ""):
        print('got line: {0}'.format(stdout_line.decode('utf-8')), end='')
    print('y')
    process.kill()
    print("Process killed")

main()
