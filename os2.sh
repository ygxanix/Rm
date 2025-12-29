#!/bin/bash

case $1 in

6a)
    cat > new.c <<'EOF'
#include <stdio.h>

int main() {
    int block[20], process[20], n, m;
    int i, j, flag[20] = {0};

    printf("Enter number of memory blocks: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("Enter size of block %d: ", i);
        scanf("%d", &block[i]);
    }

    printf("Enter number of processes: ");
    scanf("%d", &m);

    for (i = 0; i < m; i++) {
        printf("Enter size of process %d: ", i);
        scanf("%d", &process[i]);
    }

    printf("\n--- First Fit Allocation ---\n");

    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
            if (process[i] <= block[j]) {
                printf("Process %d (size %d) -> Block %d (remaining %d)\n",
                       i, process[i], j, block[j] - process[i]);
                block[j] -= process[i];
                flag[i] = 1;
                break;
            }
        }
    }

    printf("\nUnallocated processes:\n");
    for (i = 0; i < m; i++) {
        if (flag[i] == 0)
            printf("Process %d (size %d) could not be allocated\n", i, process[i]);
    }

    return 0;
}
EOF
    ;;

6b)
    cat > new.c <<'EOF'
#include <stdio.h>

int main() {
    int block[20], process[20], n, m;
    int i, j, flag[20] = {0};

    printf("Enter number of memory blocks: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("Enter size of block %d: ", i);
        scanf("%d", &block[i]);
    }

    printf("Enter number of processes: ");
    scanf("%d", &m);

    for (i = 0; i < m; i++) {
        printf("Enter size of process %d: ", i);
        scanf("%d", &process[i]);
    }

    printf("\n--- Worst Fit Allocation ---\n");

    for (i = 0; i < m; i++) {
        int max_size = -1, block_no = -1;

        for (j = 0; j < n; j++) {
            if (block[j] >= process[i] && block[j] > max_size) {
                max_size = block[j];
                block_no = j;
            }
        }

        if (block_no != -1) {
            printf("Process %d (size %d) -> Block %d (remaining %d)\n",
                   i, process[i], block_no, block[block_no] - process[i]);
            block[block_no] -= process[i];
            flag[i] = 1;
        }
    }

    printf("\nUnallocated processes:\n");
    for (i = 0; i < m; i++) {
        if (flag[i] == 0)
            printf("Process %d (size %d) could not be allocated\n", i, process[i]);
    }

    return 0;
}
EOF
    ;;

6c)
    cat > new.c <<'EOF'
#include <stdio.h>

int main() {
    int block[20], process[20], n, m;
    int i, j, flag[20] = {0};

    printf("Enter number of memory blocks: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("Enter size of block %d: ", i);
        scanf("%d", &block[i]);
    }

    printf("Enter number of processes: ");
    scanf("%d", &m);

    for (i = 0; i < m; i++) {
        printf("Enter size of process %d: ", i);
        scanf("%d", &process[i]);
    }

    printf("\n--- Best Fit Allocation ---\n");

    for (i = 0; i < m; i++) {
        int min_remain = 99999, block_no = -1;

        for (j = 0; j < n; j++) {
            if (block[j] >= process[i] && (block[j] - process[i]) < min_remain) {
                min_remain = block[j] - process[i];
                block_no = j;
            }
        }

        if (block_no != -1) {
            printf("Process %d (size %d) -> Block %d (remaining %d)\n",
                   i, process[i], block_no, block[block_no] - process[i]);
            block[block_no] -= process[i];
            flag[i] = 1;
        }
    }

    printf("\nUnallocated processes:\n");
    for (i = 0; i < m; i++) {
        if (flag[i] == 0)
            printf("Process %d (size %d) could not be allocated\n", i, process[i]);
    }

    return 0;
}
EOF
    ;;

7a)
    cat > new.c <<'EOF'
#include <stdio.h>

int main() {
    int frames[10], ref[25];
    int n, f, i, j, k = 0;
    int page_faults = 0, found;

    printf("Enter the length of reference string: ");
    scanf("%d", &n);

    printf("Enter the reference string:\n");
    for (i = 0; i < n; i++)
        scanf("%d", &ref[i]);

    printf("Enter number of frames: ");
    scanf("%d", &f);

    for (i = 0; i < f; i++) frames[i] = -1;

    for (i = 0; i < n; i++) {
        found = 0;
        for (j = 0; j < f; j++) {
            if (frames[j] == ref[i]) { found = 1; break; }
        }

        if (!found) {
            frames[k] = ref[i];
            k = (k + 1) % f;
            page_faults++;
        }

        for (j = 0; j < f; j++)
            printf(frames[j] == -1 ? "-\t" : "%d\t", frames[j]);

        if (!found) printf("  PF %d", page_faults);
        printf("\n");
    }

    printf("Total Page Faults = %d\n", page_faults);
    return 0;
}
EOF
    ;;

7b)
    cat > new.c <<'EOF'
#include <stdio.h>

int findLRU(int time[], int f) {
    int min = time[0], pos = 0;
    for (int i = 1; i < f; ++i)
        if (time[i] < min) { min = time[i]; pos = i; }
    return pos;
}

int main() {
    int frames[10], pages[25], time[10];
    int n, f, i, j, counter = 0, page_faults = 0, found, pos;

    printf("Enter the length of reference string: ");
    scanf("%d", &n);

    printf("Enter the reference string:\n");
    for (i = 0; i < n; i++) scanf("%d", &pages[i]);

    printf("Enter number of frames: ");
    scanf("%d", &f);

    for (i = 0; i < f; i++) { frames[i] = -1; time[i] = 0; }

    for (i = 0; i < n; i++) {
        found = 0;
        for (j = 0; j < f; j++) {
            if (frames[j] == pages[i]) {
                found = 1;
                counter++;
                time[j] = counter;
                break;
            }
        }

        if (!found) {
            pos = findLRU(time, f);
            frames[pos] = pages[i];
            counter++;
            time[pos] = counter;
            page_faults++;
        }

        for (j = 0; j < f; j++)
            printf(frames[j] == -1 ? "-\t" : "%d\t", frames[j]);

        if (!found) printf("  PF %d", page_faults);
        printf("\n");
    }

    printf("Total Page Faults = %d\n", page_faults);
    return 0;
}
EOF
    ;;

8a)
    cat > new.c <<'EOF'
#include <stdio.h>
#include <string.h>

#define MAX 20

int main() {
    char files[MAX][20];
    int count = 0, choice, i;
    char name[20];

    do {
        printf("\n1.Create 2.Delete 3.Search 4.Display 5.Exit\nEnter choice: ");
        scanf("%d", &choice);

        switch(choice) {
            case 1:
                printf("Enter file name: "); scanf("%s", name);
                for(i=0; i<count; i++) if(strcmp(files[i],name)==0) { printf("Exists\n"); goto next1; }
                strcpy(files[count++], name);
                printf("Created\n");
                next1: break;
            case 2:
                printf("Enter file name: "); scanf("%s", name);
                for(i=0; i<count; i++) if(strcmp(files[i],name)==0) break;
                if(i==count) printf("Not found\n");
                else {
                    for(int j=i; j<count-1; j++) strcpy(files[j], files[j+1]);
                    count--; printf("Deleted\n");
                }
                break;
            case 3:
                printf("Enter file name: "); scanf("%s", name);
                for(i=0; i<count; i++) if(strcmp(files[i],name)==0) { printf("Found\n"); break; }
                if(i==count) printf("Not found\n");
                break;
            case 4:
                if(count==0) printf("Empty\n");
                else for(i=0; i<count; i++) printf("%d. %s\n", i+1, files[i]);
                break;
            case 5: break;
            default: printf("Invalid\n");
        }
    } while(choice != 5);
    return 0;
}
EOF
    ;;

8b)
    cat > new.c <<'EOF'
#include <stdio.h>
#include <string.h>

#define MAX_USERS 5
#define MAX_FILES 10

int main() {
    char users[MAX_USERS][20];
    char files[MAX_USERS][MAX_FILES][20];
    int userCount = 0, fileCount[MAX_USERS] = {0};
    int choice, i, u;
    char uname[20], fname[20];

    do {
        printf("\n1.Create User 2.Create File 3.Delete File 4.Display User 5.Display All 6.Exit\nEnter choice: ");
        scanf("%d", &choice);

        switch(choice) {
            case 1:
                printf("User name: "); scanf("%s", uname);
                strcpy(users[userCount++], uname);
                printf("User created\n");
                break;
            case 2:
                printf("User: "); scanf("%s", uname);
                for(u=0; u<userCount; u++) if(strcmp(users[u],uname)==0) break;
                if(u==userCount) { printf("User not found\n"); break; }
                printf("File name: "); scanf("%s", fname);
                strcpy(files[u][fileCount[u]++], fname);
                printf("File created\n");
                break;
            case 3:
                printf("User: "); scanf("%s", uname);
                for(u=0; u<userCount; u++) if(strcmp(users[u],uname)==0) break;
                if(u==userCount) { printf("User not found\n"); break; }
                printf("File name: "); scanf("%s", fname);
                for(i=0; i<fileCount[u]; i++) if(strcmp(files[u][i],fname)==0) break;
                if(i==fileCount[u]) printf("File not found\n");
                else { for(int j=i; j<fileCount[u]-1; j++) strcpy(files[u][j], files[u][j+1]); fileCount[u]--; printf("Deleted\n"); }
                break;
            case 4:
                printf("User: "); scanf("%s", uname);
                for(u=0; u<userCount; u++) if(strcmp(users[u],uname)==0) break;
                if(u==userCount) printf("User not found\n");
                else for(i=0; i<fileCount[u]; i++) printf("%s\n", files[u][i]);
                break;
            case 5:
                for(u=0; u<userCount; u++) {
                    printf("User: %s\n", users[u]);
                    for(i=0; i<fileCount[u]; i++) printf("  %s\n", files[u][i]);
                }
                break;
            case 6: break;
            default: printf("Invalid\n");
        }
    } while(choice != 6);
    return 0;
}
EOF
    ;;

9a)
    cat > new.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_BLOCKS 50

int main() {
    bool free_space[MAX_BLOCKS];
    int next_block[MAX_BLOCKS];
    int file1[10], file2[10];
    int i, f1 = 0, f2 = 0;

    for (i = 0; i < MAX_BLOCKS; i++) {
        free_space[i] = true;
        next_block[i] = -1;
    }

    // File 1 - 5 blocks
    for (i = 0; i < MAX_BLOCKS && f1 < 5; i++)
        if (free_space[i]) { free_space[i] = false; file1[f1++] = i; }
    for (i = 0; i < f1 - 1; i++) next_block[file1[i]] = file1[i + 1];

    printf("File1: ");
    for (i = 0; i < f1; i++) printf("%d -> ", file1[i]);
    printf("NULL\n");

    // File 2 - 3 blocks
    for (i = 0; i < MAX_BLOCKS && f2 < 3; i++)
        if (free_space[i]) { free_space[i] = false; file2[f2++] = i; }
    for (i = 0; i < f2 - 1; i++) next_block[file2[i]] = file2[i + 1];

    printf("File2: ");
    for (i = 0; i < f2; i++) printf("%d -> ", file2[i]);
    printf("NULL\n");

    return 0;
}
EOF
    ;;

10a)
    cat > new.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, head, disk_size, direction;
    int request[102], temp;
    int seek_time = 0, i, j, pos;

    printf("Enter number of disk requests: ");
    scanf("%d", &n);

    printf("Enter the request sequence:\n");
    for (i = 0; i < n; i++) scanf("%d", &request[i]);

    printf("Enter initial head position: ");
    scanf("%d", &head);

    printf("Enter disk size: ");
    scanf("%d", &disk_size);

    printf("Enter direction (1=right, 0=left): ");
    scanf("%d", &direction);

    request[n] = head;
    request[n+1] = (direction == 1) ? disk_size - 1 : 0;
    n += 2;

    for (i = 0; i < n - 1; i++)
        for (j = i + 1; j < n; j++)
            if (request[i] > request[j]) {
                temp = request[i]; request[i] = request[j]; request[j] = temp;
            }

    for (i = 0; i < n; i++) if (request[i] == head) { pos = i; break; }

    printf("Seek Sequence: %d ", head);

    if (direction == 1) {
        for (i = pos + 1; i < n; i++) { seek_time += abs(request[i] - head); head = request[i]; printf("%d ", head); }
        for (i = 0; i < pos; i++) { seek_time += abs(request[i] - head); head = request[i]; printf("%d ", head); }
    } else {
        for (i = pos - 1; i >= 0; i--) { seek_time += abs(request[i] - head); head = request[i]; printf("%d ", head); }
        for (i = n - 1; i > pos; i--) { seek_time += abs(request[i] - head); head = request[i]; printf("%d ", head); }
    }

    printf("\nTotal Seek Time: %d\n", seek_time);
    return 0;
}
EOF
    ;;

*)
    echo "Usage: $0 <number>"
    exit 1
    ;;
esac

clear
gcc new.c -o a.out
./a.out
