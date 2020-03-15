#include <stdio.h>
#include <time.h>
int main()
{
    int n;
    int v[30];
    int i, j, tmp;
    time_t time_start, time_end;
    scanf("%d",&n);
    //for1
    for(i = 0; i < n; i++)
    {
        scanf("%d",&v[i]);
    }
    time_start = time(NULL);
    for(i = n - 1; i > 0; i--)
    {
        for(j = 0; j < i; j++)
        {
            if(v[j] > v [j+1])
            {
                //swap
                tmp = v[j];
                v[j] = v[j+1];
                v[j+1] = tmp;
            }
        }
    }
    time_end = time(NULL);
    for(i = n; i > 0; i--)
    {
        printf("%d",&v[n-i]);
        printf(" ");
    }
    printf("%dms",(time_end-time_start));
}