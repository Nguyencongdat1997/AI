Running sample:
- Run main.pl file
- ?- play().

====================
= Prolog TicTacToe =
====================

Starts the game

Color for human player ? (x or o)
|: x.

     |   |  
  -----------
     |   |  
  -----------
     |   |  


Next move ?
|: 1.

   x |   |  
  -----------
     |   |  
  -----------
     |   |  

Computer play : 

   x |   |  
  -----------
     | o |  
  -----------
     |   |  

Next move ?
|: 2.

   x | x |  
  -----------
     | o |  
  -----------
     |   |  

Computer play : 

   x | x | o
  -----------
     | o |  
  -----------
     |   |  

Next move ?
|: 3.

-> Bad Move !
Next move ?
|: 4.

   x | x | o
  -----------
   x | o |  
  -----------
     |   |  

Computer play : 

   x | x | o
  -----------
   x | o |  
  -----------
   o |   |  

End of game : o win !

true.