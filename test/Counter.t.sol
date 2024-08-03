// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_ReturnsColor() public view {
        bytes32 example = 0x0000000000000001018000ffd8da6bf26964af9d7eed9e03e53415d37aa96045;
        uint24 color = counter.getColor(example);
        assertEq(color, 0x8000FF);
    }

    function testFuzz_ReturnsColor(bytes32 randomData) public view {
        uint24 expectedColor;
        assembly {
            let shiftedData := shr(160, randomData)
            expectedColor := and(shiftedData, 0xffffff)
        }

        uint24 color = counter.getColor(randomData);
        assertEq(color, expectedColor, "Color mismatch found during fuzz testing");
    }
}
