//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract BalrogExample {
    address public balrog;

    /**
     * Modificador que permite a cualquiera menos al balrog ejecutar la función
     */
    modifier notBalrog() {
        require(msg.sender != balrog, "YOU SHALL NOT PASS!!");
        _;
    }

    /**
     *
     * @param balrogAddress La dirección del balrog
     */
    constructor(address balrogAddress) {
        require(
            balrogAddress != address(0),
            "BALROG CAN NOT BE THE ZERO ADDRESS"
        );
        balrog = balrogAddress;
    }

    /**
     * Esta función permite a quien no sea el balrog cruzar el puente de las minas de Moria
     */
    function cruzarElPuenteDeLasMinasDeMoria() public notBalrog {
        // Lógica para ruzar el puente de Moria
    }
}
