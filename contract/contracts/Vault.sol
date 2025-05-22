// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    address public owner;
    uint256 public sentValue;
    uint256 public timestamp;
    uint256 public gasUsed;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send some ether.");
        sentValue = msg.value;
        timestamp = block.timestamp;
    }

    function getCaller() public view returns (address) {
        return msg.sender;
    }

    function getOrigin() public view returns (address) {
        return tx.origin;
    }

    function getBlockDetails()
        public
        view
        returns (
            uint256 blockNumber,
            uint256 blockPrevrandao,
            uint256 blockGasLimit,
            address blockCoinBase
        )
    {
        {
            return (
                block.number,
                block.prevrandao,
                block.gaslimit,
                block.coinbase
            );
        }
    }

    function trackGasUsage() public {
        uint256 initGas = gasleft();
        uint256 results = 0;

        for (uint256 i = 0; i < 100; i++) {
            results += i;
        }
        uint256 finalGas = gasleft();
        gasUsed = initGas - finalGas;
    }
    function generateHash(
        string calldata message
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(message));
    }
    //pure : 상태변수 접근 불가, 입력값만 사용
    //view : 상태변수 읽기 허용
    //memory : 함수 내부에서 가공,수정 가능
    //calldata: 외부에서 받은 데이터만 읽고 수정 불가, 가스비가 더 저렴
}
