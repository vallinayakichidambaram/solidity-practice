// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomError {
    uint256  public num = 256;
    error revertCustomError (uint256 x);
    function revertWithCustomError() public view {
        if(num < 1000) {
            revert revertCustomError({x: 56789});
        }
    }
}