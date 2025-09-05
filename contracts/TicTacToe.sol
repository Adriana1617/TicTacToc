//SPDX-License-Identifier: GLP-3.0

pragma solidity >=0.7.0 <0.9.0;


contract TicTacToc{

    struct Partida {
        address jugador1;
        address jugador2; 
        address ganador; 
        uint[4][4] jugadas; 
    }

    Partida[] partidas; 

    //Constructor 


    //Funciones


    function crearPartida(address jug1, address jug2) public returns(uint){


    }

    function jugar(uint idPartida, uint horizontal , uint vertical) public {
        //Validaciones 


        //Guardar la jugada 


        //Verificar si hya un ganador o esta llena 

    }


    //Modificadores 


}