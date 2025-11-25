# filestoring.py – 10 Jupyter notebooks in one one-liner
import sys
import json
import subprocess

PROGRAMS = {
    "1a": '''m1 = int(input("Enter marks for test1 : "))
m2 = int(input("Enter marks for test2 : "))
m3 = int(input("Enter marks for test3 : "))

if m1 <= m2 and m1 <= m3:
    avgMarks = (m2 + m3) / 2
elif m2 <= m1 and m2 <= m3:
    avgMarks = (m1 + m3) / 2
else:
    avgMarks = (m1 + m2) / 2

print("Average of best two test marks out of three test’s marks is", avgMarks)
''',




    "1b": '''val = int(input("Enter a value : "))
str_val = str(val)

if str_val == str_val[::-1]:
    print("Palindrome")
else:
    print("Not Palindrome")

print("\nDigit occurrences:")
for i in range(10):
    count = str_val.count(str(i))
    if count > 0:
        print(str(i), "appears", count, "times")''',

    "2a": '''def fn(n):
    if n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        return fn(n - 1) + fn(n - 2)

num = int(input("Enter a number : "))

if num > 0:
    print("fn(", num, ") = ", fn(num), sep="")
else:
    print("Error in input")''',
    "2b":'''def bin2Dec(val):
    rev = val[::-1]
    dec = 0
    i = 0
    for dig in rev:
        dec += int(dig) * 2 ** i
        i += 1
    return dec

def oct2Hex(val):
    # Octal to Decimal first
    rev = val[::-1]
    dec = 0
    i = 0
    for dig in rev:
        dec += int(dig) * 8 ** i
        i += 1
    
    # Decimal to Hex
    if dec == 0:
        return "0"
    
    list_hex = []
    while dec != 0:
        list_hex.append(dec % 16)
        dec = dec // 16
    
    nl = []
    for elem in list_hex[::-1]:
        if elem <= 9:
            nl.append(str(elem))
        else:
            nl.append(chr(ord('A') + (elem - 10)))
    
    return "".join(nl)

num1 = input("Enter a binary number : ")
print(bin2Dec(num1))

num2 = input("Enter a octal number : ")
print(oct2Hex(num2))''',
    "3a":'''sentence = input("Enter a sentence : ")
wordList = sentence.split()
print("This sentence has", len(wordList), "words")

digCnt = upCnt = loCnt = 0
for ch in sentence:
    if '0' <= ch <= '9':
        digCnt += 1
    elif 'A' <= ch <= 'Z':
        upCnt += 1
    elif 'a' <= ch <= 'z':
        loCnt += 1

print("This sentence has", digCnt, "digits", upCnt, "upper case letters", loCnt, "lower case letters")''',
    "3b":'''str1 = input("Enter String 1:\n")
str2 = input("Enter String 2:\n")

len1 = len(str1)
len2 = len(str2)

if len1 == 0 and len2 == 0:
    print("Both strings are empty — similarity is 1.0 (identical).")
else:
    short = min(len1, len2)
    long = max(len1, len2)
    matchCnt = 0
    for i in range(short):
        if str1[i] == str2[i]:
            matchCnt += 1
    similarity = matchCnt / long
    print("Similarity (fraction):", similarity)
    print(f"Similarity (percent): {similarity * 100:.2f}%")''',
    "4a":'''import matplotlib.pyplot as plt

x = [1, 2, 3, 4, 5]
y = [3, 5, 7, 2, 1]

plt.bar(x, y, color='green')
plt.title('Bar Plot Example')
plt.xlabel('X Axis')
plt.ylabel('Y Axis')
plt.show()''',
    "4b":'''import matplotlib.pyplot as plt
import numpy as np

x = np.random.randn(100)
y = np.random.randn(100)

plt.scatter(x, y)
plt.title('Scatter Plot')
plt.xlabel('X')
plt.ylabel('Y')
plt.show()''',
    "5a":'''import matplotlib.pyplot as plt
import numpy as np

data = np.random.normal(100, 10, 1000)
plt.hist(data, bins=20, edgecolor='black')
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram of Data')
plt.grid(True)
plt.show()''',
    "5b":'''import matplotlib.pyplot as plt

labels = ['A', 'B', 'C', 'D']
sizes = [15, 30, 45, 10]

plt.pie(sizes, labels=labels, autopct="%1.1f%%")
plt.title("Pie Chart")
plt.show()'''
    
}

if len(sys.argv) < 2 or sys.argv[1] not in PROGRAMS:
    print("Usage: python filestoring.py <1a|1b|2a|2b|3a|3b|4a|4b|5a|5b>")
    sys.exit(1)

code = PROGRAMS[sys.argv[1]]

nb = {
    "cells": [{"cell_type": "code", "execution_count": None, "metadata": {}, "outputs": [], "source": code.splitlines()}],
    "metadata": {"kernelspec": {"name": "python3", "display_name": "Python 3"}},
    "nbformat": 4,
    "nbformat_minor": 5
}

name = sys.argv[1] + ".ipynb"
with open(name, "w", encoding="utf-8") as f:
    json.dump(nb, f, indent=1)

print(f"Opening {sys.argv[1]} …")
subprocess.run(["jupyter-lab", name] if subprocess.run(["which","jupyter-lab"], capture_output=True).returncode == 0 else ["jupyter-notebook", name])
