#!/bin/bash
case $1 in
1)
cat > new.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>

struct Day {
    char *dayName;
    int date;
    char *activity;
};

void create(struct Day *day) {
    day->dayName = (char *)malloc(20);   // 20 chars enough for day names
    day->activity = (char *)malloc(100); // 100 chars for activity

    if (day->dayName == NULL || day->activity == NULL) {
        printf("Memory allocation failed!\n");
        exit(1);
    }

    printf("Enter the day name: ");
    scanf("%19s", day->dayName);  // safe: limits input to 19 chars + null

    printf("Enter the date: ");
    scanf("%d", &day->date);

    // Consume leftover newline from previous scanf
    int c;
    while ((c = getchar()) != '\n' && c != EOF); 

    printf("Enter the activity for the day: ");
    fgets(day->activity, 100, stdin);

    // Remove trailing newline from fgets if present
    size_t len = strlen(day->activity);
    if (len > 0 && day->activity[len - 1] == '\n') {
        day->activity[len - 1] = '\0';
    }
}

void read(struct Day *calendar, int size) {
    for (int i = 0; i < size; i++) {
        printf("\n--- Enter details for Day %d ---\n", i + 1);
        create(&calendar[i]);
    }
}

void display(struct Day *calendar, int size) {
    printf("\n========== Week's Activity Details ==========\n");
    for (int i = 0; i < size; i++) {
        printf("Day %d:\n", i + 1);
        printf("Day Name : %s\n", calendar[i].dayName);
        printf("Date     : %d\n", calendar[i].date);
        printf("Activity : %s\n", calendar[i].activity);
        printf("--------------------------------------------\n");
    }
}

void freeMemory(struct Day *calendar, int size) {
    for (int i = 0; i < size; i++) {
        free(calendar[i].dayName);
        free(calendar[i].activity);
    }
}

int main() {
    int size;

    printf("Enter the number of days in the week: ");
    if (scanf("%d", &size) != 1 || size <= 0 || size > 100) {
        printf("Invalid input. Please enter a positive number.\n");
        return 1;
    }

    struct Day *calendar = (struct Day *)malloc(sizeof(struct Day) * size);
    if (calendar == NULL) {
        printf("Memory allocation failed. Exiting program.\n");
        return 1;
    }

    read(calendar, size);
    display(calendar, size);

    freeMemory(calendar, size);
    free(calendar);

    return 0;
}
EOF
;;
2)
cat > new.c <<'EOF'
#include <stdio.h>
#include <string.h>

int find_match(char str[100], char pat[100], char rep[100], char ans[100]);

int main() {
    char str[100], pat[100], rep[100], ans[100];
    int flag;

    printf("Enter the main string:\n");
    fgets(str, sizeof(str), stdin);
    str[strcspn(str, "\n")] = '\0';

    printf("Enter the pattern string:\n");
    fgets(pat, sizeof(pat), stdin);
    pat[strcspn(pat, "\n")] = '\0';

    printf("Enter the replacement string:\n");
    fgets(rep, sizeof(rep), stdin);
    rep[strcspn(rep, "\n")] = '\0';

    flag = find_match(str, pat, rep, ans);

    if(flag){
        printf("Pattern found\nNew string is:\n%s\n", ans);
    } else {
        printf("Pattern not found\n");
    }

    return 0;
}

int find_match(char str[100], char pat[100], char rep[100], char ans[100]){
    int c = 0, m = 0, i = 0, j = 0, k, flag = 0;

    while(str[c] != '\0'){
        if(str[m] == pat[i]){
            i++;
            m++;
            if(pat[i] == '\0'){   // full pattern matched
                flag = 1;
                for(k = 0; rep[k] != '\0'; k++, j++){
                    ans[j] = rep[k];
                }
                i = 0;
                c = m;
            }
        }
        else{
            ans[j++] = str[c++];
            m = c;
            i = 0;
        }
    }

    ans[j] = '\0';
    return flag;
}
EOF
;;
3)
cat > new.c <<'EOF'
#include <stdio.h> 
#include <stdlib.h> 
#define STACK_MAX_SIZE 100 
#define ERROR_CODE 999 
int STACK [STACK_MAX_SIZE]; 
int top=-1; 
void push (int); 
int pop (void); 
void STACKFull (void); 
int STACKEmpty (void); 
void display (void); 
void palindrome (void); 
int main() 
{ 
int ch;  
    int ele;  
    while (1) 
    { 
        printf("Enter the choice \n"); 
        printf ("PUSH:1\nPOP:2\nDISPLAY:3\nPALINDROME:4\nEXIT: 5\n"); 
        scanf("%d", &ch); 
        if (ch==1) 
        {  
            printf ("Enter the element to be inserted \n"); 
            scanf("%d",&ele); 
            push (ele); 
        }     
        else  
        if (ch== 2) 
        { 
            ele=pop(); 
            if (ele!=ERROR_CODE)  
            printf("Popped out element is %d\n", ele); 
             
        } 
        else  
        if (ch==3) 
        { 
            display(); 
        } 
        else  
        if (ch==4) 
        { 
            palindrome(); 
        } 
        else  
        if(ch==5)  
        exit(0); 
    }     
 
} 
void push (int ele) 
{ 
    if (top>= STACK_MAX_SIZE) 
        STACKFull(); 
    else 
        STACK[++top] = ele; 
} 
int pop() 
{ 
    int ele; 
    if (top == -1) 
        STACKEmpty(); 
    else 
        ele=STACK[top--]; 
    return ele; 
} 
void STACKFull (void) 
{  
    printf(" STACK OVERFLOW \n"); 
} 
int STACKEmpty (void) 
{ 
    int ele = 999; 
    printf(" STACK UNDERFLOW\n"); 
    return ele; 
} 
void display (void) 
{ 
    int i; 
    if (top==-1) 
    printf ("Stack is empty\n");  
    else  
    {  
        printf ("Stack elements are: \n"); 
        for(i= top;i>=0; i--) 
        {  
printf("%d\n", STACK[i]); 
        } 
    } 
}     
void palindrome (void) 
{ 
    int i,flag=1; 
    int rev[100]; 
    int n=0,j=0; 
    for (i=top;i>= 0; i--) 
    { 
        rev [j] = STACK[i]; 
        j=j+1; 
        n=n+1; 
    }     
    for(i=0;i<n;i++) 
    { 
        if (rev [i]!= STACK[i]) 
        { 
            flag=0; 
                    break; 
        } 
    } 
    if(flag==0) 
        printf("Not a Palindrome\n"); 
    else 
        printf("Palindrome\n"); 
}
EOF
;;
4)
cat > new.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define MAX_STACK_SIZE 100
#define ERROR_CODE 'E'

typedef struct {
    char ch;
} element;

element stack[MAX_STACK_SIZE];
int top = -1;

void push(element item);
element pop(void);
void StackFull(void);
element StackEmpty(void);
int priority(char ch);

int main()
{
    char infix[100], postfix[100];
    int pos = 0;
    element item;
    char *e;

    printf("Enter the Infix Expression:\n");
    scanf("%s", infix);

    e = infix;

    while (*e != '\0')   // FIXED
    {
        if (isalnum(*e))
        {
            postfix[pos++] = *e;
        }
        else if (*e == '(')
        {
            item.ch = *e;
            push(item);
        }
        else if (*e == ')')
        {
            while (1)
            {
                item = pop();
                if (item.ch == '(')
                    break;
                postfix[pos++] = item.ch;
            }
        }
        else   // operator
        {
            while (top != -1 && priority(stack[top].ch) >= priority(*e))
            {
                item = pop();
                postfix[pos++] = item.ch;
            }
            item.ch = *e;
            push(item);
        }
        e++;
    }

    while (top != -1)   // FIXED
    {
        item = pop();
        postfix[pos++] = item.ch;
    }

    postfix[pos] = '\0';

    printf("Postfix Expression is: %s\n", postfix);

    return 0;
}

// Stack push
void push(element item)
{
    if (top >= MAX_STACK_SIZE - 1)
        StackFull();
    else
        stack[++top] = item;
}

// Stack pop
element pop()
{
    if (top == -1)
        return StackEmpty();
    return stack[top--];
}

void StackFull()
{
    printf("OVERFLOW: Stack is Full\n");
}

// Stack empty handler
element StackEmpty()
{
    element item;
    printf("UNDERFLOW: Stack is Empty\n");
    item.ch = ERROR_CODE;
    return item;
}

// Operator precedence
int priority(char ch)
{
    if (ch == '(') return 0;
    if (ch == '+' || ch == '-') return 1;
    if (ch == '*' || ch == '/' || ch == '%') return 2;
    if (ch == '^') return 3;
    return -1;
}
EOF
;;
5)
cat > new.c <<'EOF'
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<ctype.h>

#define MAX_STACK_SIZE 100
#define ERROR_CODE 'E'

typedef struct{
    int key;
} element;

element stack[MAX_STACK_SIZE];
int top = -1;

// Function prototypes
void push(element item);
element pop(void);
void StackFull(void);
element StackEmpty(void);

int main() {
    int num;
    char postfix[100];
    char *e;
    element item1, item2, item3, item;

    printf("\nEnter the postfix expression:\n");
    scanf("%s", postfix);
    printf("\n");

    e = postfix;

    while(*e != '\0') {
        if(isdigit(*e)) {
            num = *e - '0';  // safer than 48
            item.key = num;
            push(item);
        }
        else {
            item1 = pop();   // second operand
            item2 = pop();   // first operand
            switch(*e) {
                case '+': item3.key = item2.key + item1.key; break;
                case '-': item3.key = item2.key - item1.key; break;
                case '*': item3.key = item2.key * item1.key; break;
                case '/': item3.key = item2.key / item1.key; break;
                case '%': item3.key = item2.key % item1.key; break;
                case '^': item3.key = (int)pow(item2.key, item1.key); break;
            }
            push(item3);
        }
        e++;
    }

    // Final result
    item = pop();
    printf("The result of postfix expression %s = %d\n", postfix, item.key);

    return 0;
}

// Push function
void push(element item) {
    if(top >= MAX_STACK_SIZE - 1)
        StackFull();
    else
        stack[++top] = item;
}

// Pop function
element pop(void) {
    if(top == -1)
        return StackEmpty();
    return stack[top--];
}

// Stack full error
void StackFull(void) {
    printf("OVERFLOW: stack is full, cannot add elements\n");
}

// Stack empty error
element StackEmpty(void) {
    printf("UNDERFLOW: Stack is empty\n");
    element item;
    item.key = ERROR_CODE;
    return item;
}
EOF
;;
6)
cat > new.c <<'EOF'
#include<stdio.h> 
#include<stdlib.h> 
#define N 6 
#define ERROR_CODE 'Z' 
typedef struct 
{ 
char key; 
} element; 
element QUEUE[N]; 
int REAR=-1; 
int FRONT=-1; 
void ENQUEUE (element); 
element DEQUEUE (void); 
void display(void); 
 int main() 
{ 
char c; 
int ch; 
element item; 
while(1) 
{ 
printf("Enter the choice\n"); 
printf("\nENQUEUE:1\nDEQUEUE:2\nDISPLAY:3\nEXIT:4\n"); 
scanf("%d",&ch); 
if(ch==1) 
{ 
printf("Enter the element to be inserted\n"); 
c=getchar(); 
scanf("%c",&c); 
//printf("hello\n"); 
item.key=c; 
ENQUEUE(item); 
} 
else if(ch==2) 
{ 
item=DEQUEUE(); 
if(item.key!=ERROR_CODE) 
putchar(item.key); 
} 
else if(ch==3) 
{ 
display(); 
} 
else if(ch==4) 
{ 
exit(0); 
} 
} 
} 
void ENQUEUE(element item) 
{ 
if (REAR==-1 &&FRONT==-1) 
{ 
REAR=FRONT=0; 
QUEUE[REAR]=item; 
} 
else 
if((REAR+1)%N==FRONT) 
{ 
printf("Queue is full\n"); 
} 
else 
{ 
REAR=(REAR+1)%N;  
QUEUE[REAR]=item; 
} 
} 
element DEQUEUE(void) 
{ 
element item; 
if (REAR==-1 && FRONT==-1) 
{ 
printf("Underflow\n"); 
item.key='Z'; 
return (item); 
} 
else if (FRONT== REAR) 
{ 
item=QUEUE[FRONT]; 
FRONT=REAR=-1; 
return(item); 
} 
else 
{ 
item=QUEUE[FRONT]; 
FRONT=(FRONT+1)%N; 
return(item); 
} 
} 
void display() 
{ 
char c; 
element item; 
int i=FRONT; 
if(FRONT==-1 && REAR==-1) 
printf("Queue Empty\n"); 
else 
{ 
printf("Queue elements are:\n"); 
while( i  != REAR) 
{ 
item=QUEUE[i]; 
c=item.key; 
putchar(c); 
printf("\n"); 
i=(i+1)%N; 
} 
item=QUEUE[i]; 
c=item.key; 
putchar(c); 
printf("\n"); 
} 
}
EOF
;;
*)
echo "Use: $0 1  or  $0 2  ...  $0 6"
exit
;;
esac

cc new.c
./a.out
