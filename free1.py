import sys
import json
import subprocess

PROGRAMS = {
    "1a": "m1 = int(input(\"Enter marks for test1 : \"))\nm2 = int(input(\"Enter marks for test2 : \"))\nm3 = int(input(\"Enter marks for test3 : \"))\n\nif m1 <= m2 and m1 <= m3:\n    avgMarks = (m2 + m3) / 2\nelif m2 <= m1 and m2 <= m3:\n    avgMarks = (m1 + m3) / 2\nelse:\n    avgMarks = (m1 + m2) / 2\n\nprint(\"Average of best two test marks out of three test's marks is\", avgMarks)",

    "1b": "def fn(n):\n    if n == 1:\n        return 0\n    elif n == 2:\n        return 1\n    else:\n        return fn(n-1) + fn(n-2)\n\nnum = int(input(\"Enter a number : \"))\nif num > 0:\n    print(f\"fn({num}) = {fn(num)}\")\nelse:\n    print(\"Error in input\")",

    "2a": "val = int(input(\"Enter a value : \"))\nstr_val = str(val)\n\nif str_val == str_val[::-1]:\n    print(\"Palindrome\")\nelse:\n    print(\"Not Palindrome\")\n\nprint(\"\\nDigit occurrences:\")\nfor i in range(10):\n    count = str_val.count(str(i))\n    if count > 0:\n        print(str(i), \"appears\", count, \"times\")",

    "2b": "def bin2Dec(val):\n    rev = val[::-1]\n    dec = i = 0\n    for d in rev:\n        dec += int(d) * 2**i\n        i += 1\n    return dec\n\ndef oct2Hex(val):\n    rev = val[::-1]\n    dec = i = 0\n    for d in rev:\n        dec += int(d) * 8**i\n        i += 1\n    if dec == 0: return \"0\"\n    h = []\n    while dec:\n        h.append(dec % 16)\n        dec //= 16\n    return \"\".join(\"0123456789ABCDEF\"[x] for x in h[::-1])\n\nnum1 = input(\"Enter a binary number : \")\nprint(bin2Dec(num1))\nnum2 = input(\"Enter an octal number : \")\nprint(oct2Hex(num2))",

    "3a": "sentence = input(\"Enter a sentence : \")\nwords = sentence.split()\nprint(\"This sentence has\", len(words), \"words\")\ndig = up = lo = 0\nfor c in sentence:\n    if \"0\" <= c <= \"9\":\n        dig += 1\n    elif \"A\" <= c <= \"Z\":\n        up += 1\n    elif \"a\" <= c <= \"z\":\n        lo += 1\nprint(\"This sentence has\", dig, \"digits\", up, \"upper case letters\", lo, \"lower case letters\")",

    "3b": "s1 = input(\"Enter String 1:\\n\")\ns2 = input(\"Enter String 2:\\n\")\nl1, l2 = len(s1), len(s2)\nif not l1 and not l2:\n    print(\"Both strings are empty — similarity is 1.0 (identical).\")\nelse:\n    match = sum(a == b for a, b in zip(s1, s2))\n    sim = match / max(l1, l2)\n    print(\"Similarity (fraction):\", sim)\n    print(f\"Similarity (percent): {sim * 100:.2f}%\")",

    "4a": "import matplotlib.pyplot as plt\nx = [1,2,3,4,5]\ny = [3,5,7,2,1]\nplt.bar(x, y, color='green')\nplt.title('Bar Plot Example')\nplt.xlabel('X Axis')\nplt.ylabel('Y Axis')\nplt.show()",

    "4b": "import matplotlib.pyplot as plt, numpy as np\nx = np.random.randn(100)\ny = np.random.randn(100)\nplt.scatter(x, y)\nplt.title('Scatter Plot')\nplt.xlabel('X')\nplt.ylabel('Y')\nplt.show()",

    "5a": "import matplotlib.pyplot as plt, numpy as np\ndata = np.random.normal(100, 10, 1000)\nplt.hist(data, bins=20, edgecolor='black')\nplt.xlabel('Value')\nplt.ylabel('Frequency')\nplt.title('Histogram of Data')\nplt.grid(True)\nplt.show()",

    "5b": "import matplotlib.pyplot as plt\nlabels = ['A','B','C','D']\nsizes = [15,30,45,10]\nplt.pie(sizes, labels=labels, autopct='%1.1f%%')\nplt.title('Pie Chart')\nplt.show()"
}

if len(sys.argv) != 2 or sys.argv[1] not in PROGRAMS:
    print("Usage: python filestoring.py <1a|1b|2a|2b|3a|3b|4a|4b|5a|5b>")
    sys.exit(1)

code_string = PROGRAMS[sys.argv[1]]

nb = {
    "cells": [{
        "cell_type": "code",
        "execution_count": None,
        "metadata": {},
        "outputs": [],
        "source": code_string
    }],
    "metadata": {
        "kernelspec": {
            "name": "python3",
            "display_name": "Python 3"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 5
}

name = sys.argv[1] + ".ipynb"
with open(name, "w", encoding="utf-8") as f:
    json.dump(nb, f, indent=1)

print(f"Opening {sys.argv[1]} …")
subprocess.run(["jupyter-lab", name] if subprocess.run(["which","jupyter-lab"], capture_output=True).returncode == 0 else ["jupyter-notebook", name])
