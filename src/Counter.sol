// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    function getColor(bytes32 data) public pure returns (uint24 color) {
        assembly {
            // ! Remove owner data -> 160 bits = 20 bytes
            let shiftedData := shr(160, data)

            // ! Each F represents 4 bits - 11111111 11111111 11111111 - returns last 24bit - 3 bytes - COLOR
            color := and(shiftedData, 0xffffff)
        }
    }
}
