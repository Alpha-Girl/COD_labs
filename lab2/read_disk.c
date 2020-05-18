#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b){
	return *(int *)a > *(int *)b;
}

int main(int argc, char *argv[]){	// 第一个参数为当前读取位置，后续参数为请求的数字 
	int stack[100];
	int pos = atoi(argv[1]);
	int i;
	int stack_top;
	int requests[100];

	if(argc < 3){
		fprintf(stderr, "至少2参数\n");
		return 1;
	}
	else if(argc > 102){
		fprintf(stderr, "数字数量太多\n");
		return 2;
	}
	for(i = 2; i < argc; i++){
		requests[i - 2] = atoi(argv[i]);
	}

	qsort(requests, argc - 2, sizeof(int), cmp);	//对请求排序 
	for(i = 0; i < argc - 2; i++){
		if(requests[i] < pos){
			stack[i] = requests[i];		//存储位置比当前指针小的数据
			stack_top = i;
		}else{
			printf("%d, ", requests[i]);	//输出位置比当前指针大的数据
		}
	}
	for(; stack_top >= 0; stack_top--){
		printf("%d, ", stack[stack_top]);	// 反向输出位置比当前指针大的数据
	}
	printf("\n");
}