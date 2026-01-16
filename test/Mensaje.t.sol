// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Mensaje} from "../src/Mensaje.sol";

// Importamos la interfaz de errores de OpenZeppelin
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";

contract MensajeTest is Test {
    Mensaje public mensajeContrato;
    
    // Usamos direcciones más realistas
    address public dueno = makeAddr("dueno");
    address public intruso = makeAddr("intruso");

    function setUp() public {
        // Forzamos que el "dueno" sea quien despliega
        vm.prank(dueno);
        mensajeContrato = new Mensaje("Texto Inicial");
    }

    function test_SoloDuenoPuedeCambiar() public {
        // 1. Caso exitoso: El dueño cambia el texto
        vm.prank(dueno);
        mensajeContrato.actualizarTexto("Nuevo Texto");
        assertEq(mensajeContrato.texto(), "Nuevo Texto");

        // 2. Caso de error: El intruso intenta cambiarlo
        // Definimos el error exacto que esperamos de OpenZeppelin
        bytes4 selector = bytes4(keccak256("OwnableUnauthorizedAccount(address)"));
        
        vm.prank(intruso);
        vm.expectRevert(abi.encodeWithSelector(selector, intruso)); 
        mensajeContrato.actualizarTexto("Hack!");
    }
}