// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Mensaje is Ownable {
    string public texto;

    // Pasamos el msg.sender al constructor de Ownable para asignarlo como dueño
    constructor(string memory _textoInicial) Ownable(msg.sender) {
        texto = _textoInicial;
    }

    function actualizarTexto(string memory _nuevoTexto) public onlyOwner {
        texto = _nuevoTexto;
    }
}