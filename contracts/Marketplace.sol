//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol"; 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract Marketplace{

    mapping (uint => uint) valores; 
    IERC721 achivements; 
    IERC20 moneda; 

    constructor (address contratoMoneda, address contratoAchivements){
        achivements = IERC721(contratoAchivements); 
        moneda = IERC20(contratoMoneda);
    }

    function publicar (uint tokenId, uint valor) public {
        require(valores[tokenId] == 0); 
        require(valor > 0 );
        require(achivements.getApproved(tokenId) ==  address(this)); //Permisos del marketplace para transferir el tokenId 
        valores[tokenId] = valor; 
    }

    function comprar(uint tokenId) public {
        require(valores[tokenId] != 0);
        require(moneda.allowance(msg.sender, address(this)) >= valores[tokenId]); //Validación de fondos  
        require(achivements.getApproved(tokenId) == address(this));
        moneda.transferFrom(msg.sender, achivements.ownerOf(tokenId), valores[tokenId]);
        achivements.transferFrom(achivements.ownerOf(tokenId), msg.sender, tokenId);
        valores[tokenId] = 0;

    }

}