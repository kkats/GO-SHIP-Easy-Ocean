# I02
## 1. Source

### 1995
+ [316N145_14](https://cchdo.ucsd.edu/cruise/316N145_14)
+ [316N145_15](https://cchdo.ucsd.edu/cruise/316N145_15)

### 2000
+ [09FA20000926](https://cchdo.ucsd.edu/cruise/09FA20000926)

# 2. Glitches

## 1995

Depth is missing. Use SUM files to produce depth file.
```
% awk '/ROS/ && /BE/ {print $3, $4, $16}' i02esu.txt > i02_1995.depth
% awk '/ROS/ && /BE/ {print $3, $4, $16}' i02wsu.txt >> i02_1995.depth
```
