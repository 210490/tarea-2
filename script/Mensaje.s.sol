// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Mensaje} from "../src/Mensaje.sol";

contract DesplegarMensaje is Script {
    function run() external {
        // Lee la clave privada de tu archivo .env
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Todo lo que esté entre start y stop se enviará a la red
        vm.startBroadcast(deployerPrivateKey);

        // AQUÍ PASAMOS EL ARGUMENTO: "Hola desde Foundry"
        new Mensaje("Hola desde Foundry");

        vm.stopBroadcast();
    }
}
