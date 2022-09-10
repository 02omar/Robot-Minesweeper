# Robot-Minesweeper

Implemented the AI module for a minesweeper robot in Haskell. The environment in which the robot operates is an n * n grid of cells. Initially, a cell on the grid contains either a robot, a mine, or is empty. The robot can move in all four directions (up, down, left, right) and is able to collect a mine only if it is in the same cell as the mine. The program will take as input the starting position of the robot and the positions of all of the mines. The objective of the AI module is to compute a sequence of actions that the robot can follow in order to go to all the mines and collect them. Below is an example grid:

![minesweeper](https://user-images.githubusercontent.com/67235119/189489051-1316f694-3936-4e31-883e-8b1521b23e86.png)

The robot R starts at (3,0) while the mines are at (2,2) and (1,2). One possible generated sequence of actions is: ["up","right","right","collect","up","collect"]
