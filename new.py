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

    "2b": '''def bin2Dec(val):
    rev = val[::-1]
    dec = 0
    i = 0
    for dig in rev:
        dec += int(dig) * 2 ** i
        i += 1
    return dec

def oct2Hex(val):
    rev = val[::-1]
    dec = 0
    i = 0
    for dig in rev:
        dec += int(dig) * 8 ** i
        i += 1
    
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

    "3a": '''sentence = input("Enter a sentence : ")
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

    "3b": '''str1 = input("Enter String 1:\n")
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

    "4a": '''import matplotlib.pyplot as plt

x = [1, 2, 3, 4, 5]
y = [3, 5, 7, 2, 1]

plt.bar(x, y, color='green')
plt.title('Bar Plot Example')
plt.xlabel('X Axis')
plt.ylabel('Y Axis')
plt.show()''',

    "4b": '''import matplotlib.pyplot as plt
import numpy as np

x = np.random.randn(100)
y = np.random.randn(100)

plt.scatter(x, y)
plt.title('Scatter Plot')
plt.xlabel('X')
plt.ylabel('Y')
plt.show()''',

    "5a": '''import matplotlib.pyplot as plt
import numpy as np

data = np.random.normal(100, 10, 1000)
plt.hist(data, bins=20, edgecolor='black')
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram of Data')
plt.grid(True)
plt.show()''',

    "5b": '''import matplotlib.pyplot as plt

labels = ['A', 'B', 'C', 'D']
sizes = [15, 30, 45, 10]

plt.pie(sizes, labels=labels, autopct="%1.1f%%")
plt.title("Pie Chart")
plt.show()''',

    "6a": '''import matplotlib.pyplot as plt
import numpy as np

X = np.array([2, 4, 6, 8, 10])
Y = X * 2

plt.plot(X, Y)
plt.xlabel("X-axis Label")
plt.ylabel("Y-axis Label")
plt.title("This is the title of of the plot")
plt.show()''',

    "6b": '''import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.plot(x, y, color='blue', linestyle='-', linewidth=2)
plt.title('Line Plot')
plt.xlabel('X Axis')
plt.ylabel('Y Axis')
plt.show()''',

    "7a": '''import seaborn as sns
import matplotlib.pyplot as plt

tips = sns.load_dataset("tips")
sns.scatterplot(x="total_bill", y="tip", data=tips)
sns.set_style("whitegrid")
sns.set_palette("Set2")
sns.despine()
plt.show()''',

    "8": '''from bokeh.plotting import figure, show

x = [1, 2, 3, 4, 5]
y = [6, 7, 2, 4, 5]

p = figure(title="Interactive line graph", x_axis_label='x', y_axis_label='y')
p.line(x, y, legend_label="Line", line_width=2)
p.annular_wedge(x=5, y=5, inner_radius=0.2, outer_radius=0.4,
                start_angle=45, end_angle=135, line_color="red", fill_color="red")
show(p)''',

    "9": '''import plotly.graph_objects as go
import numpy as np

x = np.linspace(-5, 5, 100)
y = np.linspace(-5, 5, 100)
X, Y = np.meshgrid(x, y)

Z = np.sin(np.sqrt(X**2 + Y**2))

fig = go.Figure(data=go.Surface(z=Z, x=x, y=y))
fig.update_layout(
    scene=dict(
        xaxis_title="X-axis",
        yaxis_title="Y-axis",
        zaxis_title="Z-axis"
    ),
    title="3D Surface Plot"
)
fig.show()''',

    "10a": '''import plotly.graph_objects as go
import pandas as pd

data = {
    'Date': pd.date_range(start='2023-01-01', periods=30, freq='D'),
    'Value': [10, 15, 12, 18, 22, 24, 30, 28, 35, 40, 45, 48, 52, 50, 60, 58, 65, 70, 75, 80, 78, 85, 90, 95, 100, 95, 105, 110, 115, 120]
}
df = pd.DataFrame(data)

fig = go.Figure(data=go.Scatter(x=df['Date'], y=df['Value'], mode='lines+markers', name='Time Series'))
fig.update_layout(
    xaxis_title='Date',
    yaxis_title='Value',
    title='Time Series Plot'
)
fig.show()''',

    "10b": '''import plotly.express as px

locations = ['New York', 'Los Angeles', 'Chicago', 'San Francisco']
latitudes = [40.7128, 34.0522, 41.8781, 37.7749]
longitudes = [-74.0060, -118.2437, -87.6298, -122.4194]

fig = px.scatter_geo(
    lat=latitudes,
    lon=longitudes,
    locationmode='USA-states',
    text=locations
)

fig.update_geos(
    projection_scale=10,
    center=dict(lon=-95, lat=38),
    visible=False,
    showcoastlines=True,
    coastlinecolor="RebeccaPurple",
    showland=True,
    landcolor="LightGreen",
    showocean=True,
    oceancolor="LightBlue",
    showlakes=True,
    lakecolor="LightBlue",
)

fig.update_layout(
    title_text='Sample US Map',
    title_x=0.5,
)
fig.show()'''
}

if len(sys.argv) != 2 or sys.argv[1] not in PROGRAMS:
    print("Usage: python run.py <name>")
    print("Available:", " | ".join(sorted(PROGRAMS.keys())))
    sys.exit(1)

name = sys.argv[1]
code = PROGRAMS[name].strip()

notebook = {
    "cells": [
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": code.splitlines()
        }
    ],
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 5
}

filename = f"{name}.ipynb"
with open(filename, "w", encoding="utf-8") as f:
    json.dump(notebook, f, indent=2, ensure_ascii=False)

print(f"Created {filename} → Opening in Jupyter...")

try:
    subprocess.run(["jupyter-lab", filename], check=True)
except:
    subprocess.run(["jupyter-notebook", filename])
