#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(){
char input[80];
while(1){
	fscanf(stdin, "%s", input);
		FILE* f = fopen("/home/valery/net/inetd_prog/log.txt", "a");
		printf("Returned: %s from prog\n", input);
		fflush(stdin);
		fprintf(f, "%d: %s\n", getpid(), input);
		fclose(f);
}
return 0;
}
