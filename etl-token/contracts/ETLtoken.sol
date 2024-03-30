// contracts/ESTELLE_TOKEN.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract ESTELLE_TOKEN is ERC20Capped , ERC20Burnable { 

    address payable public owner;

    uint256 public blockReward;

    
    constructor ( uint256 cap , uint256 reward) ERC20("ESTELLE_TOKEN","ETL") ERC20Capped(cap * (10 ** decimals())) {

        owner = payable(msg.sender);

        _mint(msg.sender,70000000 * (10 ** decimals()));

        blockReward = reward * (10 ** decimals());

    }

    function _update(address from, address to, uint256 value) internal virtual override {  
        super._update(from, to, value);

        if (from == address(0)) {
            uint256 maxSupply = cap();                                                     //copied from ERC20Capped ( whole function )
            uint256 supply = totalSupply();
            if (supply > maxSupply) {
                revert ERC20ExceededCap(supply, maxSupply);
            }
        }
    }                                                                                      

    fucntion _mintMinerReward() internal {

        _mint( block.coinbase , blockReward );
    }

    function _beforeTokenTransfer(address from , address to , uint256 vlaue) internal virtual ovverride( ERC20Capped , ERC20 ) {

        if( from != address(0) && to != block.coinbase && block.coinbase != address(0)) {

            _mintMinerReward();

        }

        super._beforeTokenTransfer(from, to, value);

        
    }

    function setBlockReward ( uint256 reward ) public onlyOwner {

        blockReward = reward * (10 ** decimals());

    }

    function destroy() public onlyOwner {

        selfdestruct(owner);
    }

    modifier onlyOwner {

        require( msg.sender == owner , "ONLY THE OWNER  CAN CALL THIS FUNCITON" );

        _;
    }

}











// alsdfkjaskldjl