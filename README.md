# 8 Puzzle Problem

[![License: MIT](https://img.shields.io/github/license/Ghost1995/8-Puzzle-Problem.svg)](https://opensource.org/licenses/MIT)
---

## Overview

Create a simple exhaustive search algorithm to solve the 8 Puzzle Problem.

In this project, I have developed a simple 8-piece puzzle solver. The solution for the given puzzle is found using Breadth First Search Algorithm. This project has been developed on MATLAB using functions and an interactive Graphical User Interface (GUI) has also been developed using MATLAB App.

The developed system is capable of:
* taking a starting configuration of the puzzle as an input,
* taking a goal configuration of the puzzle as an input,
* checking for solvability of the puzzle for a given pair of starting and goal configuration of the puzzle, and
* generating a solution for a given pair of starting and goal configuration of the puzzle, if a solution exists.

## Demonstration of the Project

Here we show the generation of solution for a given pair of starting and goal configuration of the puzzle, using the developed GUI.

<p align="center">
<img src="https://github.com/Ghost1995/object_collection_robotic_arm/blob/master/additional_files/BR.gif">
</p>

## Dependencies

To run this program you need to have the following installed on your system:
* MATLAB R2018b

## Run Instructions

To run the puzzle solver, you can either use the MATLAB functions or the MATLAB App.

### Run Puzzle Solver using MATLAB Functions

To run the program, you first need to make sure that your MATLAB has the folder with all the MATLAB functions added to its path. Then, you run the [puzzleSolver.m](https://github.com/Ghost1995/8-Puzzle-Problem/blob/master/code/puzzleSolver.m) file with 6 inputs:
* initialNode - This is the starting configuration of the puzzle defined as a 3 x 3 matrix. It is a mandatory input argument.
* goalNode - This is the goal configuration of the puzzle defined as a 3 x 3 matrix. It is an optional input argument. If the goalNode is not defined, then the goal configuration is set as \[1 2 3; 4 5 6; 7 8 0\], the puzzle set in ascending order.
* checkSolvability - This is a flag which mentions whether the code should check for solvability of the puzzle for the given pair of initial and goal configurations of the puzzle. It is an optional argument, and by default is set as false. If true, the code checks for solvability by checking whether the number of inversions is even or not. However, if false, the code starts node exploration and later checks whether a solution could be generated or not.
* visualize - This is a flag which mentions whether the code should visualize the solution generated or not. It is an optional argument, and by default is set as false.
* saveVars - This is a flag which mentions whether the code should save the variables (explored nodes and solution) or not. It is an optional argument, and by default is set as false.
* saveType - This is the format in which the arguments need to be saved. The code can only save the variables as MAT files (".mat") or text files (".txt"). It is an optional argument, and by default the arguments are saved as MAT files.

A sample run command is shown below:
```
initialNode = [8 6 7; 2 5 4; 3 0 1];
goalNode = [1 2 3; 4 5 6; 7 8 0];
checkSolvability = true;
visualize = true;
saveVars = true;
saveType = '.txt';

clc
puzzleSolver(initialNode, goalNode, checkSolvability, visualize, saveVars, saveType);
```

### Run Puzzle Solver using MATLAB App

To run the program, simply double-click on the [PuzzleSolver.mlapp](https://github.com/Ghost1995/8-Puzzle-Problem/blob/master/code/PuzzleSolver.mlapp) file from inside MATLAB. It will open the app. Now, follow the given steps:
1) Input the starting configuration of the puzzle.
2) Press the next button. The code will check if the starting configuration is valid.
3) Input the goal configuration of the puzzle.
4) Press the start button. The code will first check whether the goal configuration is valid. Then, it will check for solvability of the puzzle for the given pair of initial and goal configurations. Then, if the puzzle is solvable, the code will explore nodes while looking for the solution. Once the solution is found, it will plot the solution.
5) Either replay the solution by pressing the replay button, or reset the puzzle using the reset button, or close the app using the close button.

The use of the app is shown in [Demonstartion](#demonstration-of-the-project).

## Record Variables

As explained earlier, you can save the variables as MAT files or text files. Once the files are saved, you can run the same by following the commands shown in respective sub-headings. This will generate the same visualization that would have generated if the visualize flag was set as true when running the puzzle solver using MATLAB functions.

### Play MAT Files

Once the variables are saved as MAT files, simply locate the same inside MATLAB and load the variable in the workspace. Then, run the [plotPath.m](https://github.com/Ghost1995/8-Puzzle-Problem/blob/master/code/plotPath.m) file with the nodePath variable as input.

### Play Text Files

Once the variables are saved as text files, run the [plotPath.m](https://github.com/Ghost1995/8-Puzzle-Problem/blob/master/code/plotPath.m) file with the name of the text file with the node path (nodePath.txt) as input.
