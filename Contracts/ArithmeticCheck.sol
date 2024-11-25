// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ArithmeticCheck {
    uint256 public principal;
    uint32 public rateOfInterest;
    uint32 public timePeriod;
    uint256 public simpleInterest;
    event OnSimpleInterestCalculated(uint256 _simpleInterest, address _sender);

    constructor(
        uint256 _principal,
        uint32 _rateOfInterest,
        uint32 _timePeriod
    ) {
        principal = _principal;
        rateOfInterest = _rateOfInterest;
        timePeriod = _timePeriod;
    }

    function calculateSimpleInterest() public {
        simpleInterest = (principal * rateOfInterest * timePeriod) / 100;
        emit OnSimpleInterestCalculated(simpleInterest, msg.sender);
    }

    function errorSimpleInterest() public {
        simpleInterest = (principal / 100) * rateOfInterest * timePeriod;
        emit OnSimpleInterestCalculated(simpleInterest, msg.sender);
    }

    function getSimpleInterest() public view returns (uint256) {
        return simpleInterest;
    }
}
