//SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity >=0.7.0 <0.9.0;


contract Achievement is ERC721("Token Achivement", "TA"), Ownable(msg.sender){
    

    uint ultimoIndice; 

    function emitir(address destino)public onlyOwner returns(uint){
        uint indice = ultimoIndice; 
        ultimoIndice++; 
        _safeMint(destino, indice);
        return indice;
    }

}