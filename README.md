# Connect-4

The purpose of this project was to design the original Connect-4 game using an FPGA. The rules of the game are the same as the original. There are two players that will  take turns placing a red/yellow piece and the first person to get 4 of their own pieces in a row will win. The combinations can be vertical, horizontal, and diagonal. We used  the left and right buttons to allow the user to navigate the columns of the Connect 4 board. We also used the down button to allow the user to drop the piece into a column. The middle button was used as a reset to restart the game. The board and pieces of the game were displayed on the screen using the VGA display. The winner of the game is notified by the square in the corner. It is initially green to signify no winner, but when yellow wins it changes to yellow and the same goes for when red wins. 

## How to Run it in Xillinx

Create a new project and add the files within the project. Then, connect the FPGA to a monitor using a VGA cable. Finally, run the code in Xillinx and the game should appear on your monitor ready to play. 
