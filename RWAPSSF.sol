// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract RWAPSSF {
    struct Player {
        uint choice; // 0 - Rock, 1 - Paper , 2 - Scissors, 3 - Water, 4 - Air, 5 - Sponge, 6 - Fire, 7 - undefined
        address addr;
    }
    uint private numPlayer = 0;
    uint private reward = 0;
    mapping (uint => Player) private player;
    uint private numInput = 0;
    mapping (address => uint) private playerIdx;
    uint private time = 0;

    function reset() private {
        numPlayer = 0;
        reward = 0;
        numInput = 0;
        time = 0;
        player[0].addr = address(0);
        player[0].choice = 7;
        player[1].addr = address(0);
        player[1].choice = 7;
    }

    function timeoutPay() public payable {
        require(block.timestamp - time > 5 minutes);
        require(playerIdx[player[0].addr] == 0);
        require(numPlayer == 1);
        address payable account0 = payable(player[0].addr);
        account0.transfer(reward); 
        reset();
    }

    function addPlayer() public payable {
        require(numPlayer < 2);
        require(msg.value == 1 ether);
        reward += msg.value;
        player[numPlayer].addr = msg.sender;
        player[numPlayer].choice = 3;
        playerIdx[msg.sender] = numPlayer;
        time = block.timestamp;
        numPlayer++;
    }

    function input(uint choice, uint idx) public  {
        require(numPlayer == 2);
        require(msg.sender == player[idx].addr);
        require(choice == 0 || choice == 1 || choice == 2);
        player[idx].choice = choice;
        numInput++;
        if (numInput == 2) {
            _checkWinnerAndPay();
        }
    }

    function _checkWinnerAndPay() private {
        uint p0Choice = player[0].choice;
        uint p1Choice = player[1].choice;
        address payable account0 = payable(player[0].addr);
        address payable account1 = payable(player[1].addr);
        if ((p0Choice + 1) % 3 == p1Choice) {
            // to pay player[1]
            account1.transfer(reward);
        }
        else if ((p1Choice + 1) % 3 == p0Choice) {
            // to pay player[0]
            account0.transfer(reward);    
        }
        else {
            // to split reward
            account0.transfer(reward / 2);
            account1.transfer(reward / 2);
        }
    }
}
