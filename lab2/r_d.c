#include <stdio.h>
#include <stdlib.h>
#define MAX_REQs 100
int cmp(const void *a, const void *b)
{
    return *(int *)a > *(int *)b;
}

int minium(int a, int b)
{
    if (a < b)
        return a;
    else
        return b;
}

int main()
{
    int requests[MAX_REQs];
    int done[MAX_REQs];
    int cfq[MAX_REQs];
    int n;
    int finished, start;
    printf("Input the number of requests:\n");
    scanf("%d", &n);
    if (n > MAX_REQs)
    {
        printf("There are too many requests.\n");
        return 0;
    }
    int i, j;
    for (i = 0; i < n; i++)
    {
        printf("Input the address of the %dth request:\n", i + 1);
        scanf("%d", &requests[i]);
        cfq[i] = requests[i];
    }
    for (i = 0; i < MAX_REQs; i++)
    {
        done[i] = 0;
    }
    finished = 0;
    printf("NOOP:\n"); //相邻请求合并
    //requests数组表示 请求队列
    //done数组表示 是否已完成访问
    for (i = 0; i < n; i++)
    {
        if (done[i] == 0)
        {
            printf("%d", requests[i]);
            done[i] = 1;
            finished++;
            if (finished != n)
                printf(",");
            for (j = i + 1; j <= minium(i + 3, n - 1); j++)
            {

                if ((abs(requests[j] - requests[i]) <= 10) && done[j] == 0)
                {
                    printf("%d", requests[j]);
                    done[j] = 1;
                    finished++;
                    if (finished != n)
                        printf(",");
                }
            }
        }
    }
    printf("\n");

    printf("CFQ:\n"); //按请求地址排序
    printf("Input the start:\n");
    scanf("%d", &start);
    qsort(cfq, n, sizeof(int), cmp);
    finished = 0;
    //start开始时表示磁头所在位置
    //cfq数组为 快排后的requests数组
    for (i = 0; i < n; i++)
    {
        if (cfq[i] >= start)
            break;
    }
    start = i; //此处start表示 访问的第一个扇区
    //访问扇区号比磁头所在位置大的区域
    for (; i < n; i++)
    {
        printf("%d", cfq[i]);
        finished++;
        if (finished != n)
            printf(",");
    }
    //剩余区域
    for (i = 0; i < start; i++)
    {
        printf("%d", cfq[i]);
        finished++;
        if (finished != n)
            printf(",");
    }
    printf("\n");
    return 0;
}
