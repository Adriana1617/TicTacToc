//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol"; 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Marketplace is Ownable(msg.sender){

    mapping (uint => uint) valores; 
    mapping(uint =>address) postor;
    IERC721 achivements; 
    IERC20 moneda; 

    constructor (address contratoMoneda, address contratoAchivements){
        achivements = IERC721(contratoAchivements); 
        moneda = IERC20(contratoMoneda);
    }

    function publicar (uint tokenId, uint valor) public {
        require(valor > 0 );
        require(valores[tokenId] == 0); 
        require(achivements.getApproved(tokenId) ==  address(this)); //Permisos del marketplace para transferir el tokenId 
        valores[tokenId] = valor; 
        postor[tokenId] = msg.sender;
    }


    function finalizacion(uint tokenId) public onlyOwner(){
        require(valores[tokenId] >0); 
        require(moneda.allowance(postor[tokenId], address(this)) > valores[tokenId]);
        require(achivements.getApproved(tokenId) == address(this));

        moneda.transferFrom(postor[tokenId], achivements.ownerOf(tokenId), valores[tokenId]);
        achivements.transferFrom(achivements.ownerOf(tokenId), postor[tokenId], tokenId);
        valores[tokenId] = 0;

    }


    function oferta(uint tokenId, uint cantidad) public {
        require(valores[tokenId] > 0);
        require(cantidad > valores[tokenId]);
        require(moneda.allowance(msg.sender, address(this)) > cantidad);
        postor[tokenId] = msg.sender; 
        valores[tokenId] = cantidad;
    }
}