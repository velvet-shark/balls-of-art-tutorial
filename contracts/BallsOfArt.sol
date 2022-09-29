//SPDX-License-Identifier: MIT
// @title    Balls of Art
// @version  1.0.0
// @author   Radek Sienkiewicz | velvetshark.com
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "hardhat/console.sol";

contract BallsOfArt is ERC721, Ownable {
    // Structs
    // struct Ball {
    //     // Ball parameters
    // }

    // Constants, prublic variables
    // uint constant maxSupply = XXX; // max number of tokens
    // uint public totalSupply = XXX; // number of tokens minted
    // uint public mintPrice = XXX ether;

    // Events

    constructor() ERC721("Balls of Art", "BART") {}

    // Functions

    // Return a random background color
    // function backgroundColors() {}

    // Return a random ball color
    // function ballColors() {}

    // Create an instance of a Ball
    // function createBallStruct() {}

    // Randomly picka a ball size: 1, 2, or 3x
    // function drawBallSize() {}

    // SVG code for a single ball
    // function ballSvg() {}

    // SVG code for a single line
    // function generateLineSvg() {}

    // Draw animated eyes
    // function drawEyes() {}

    // Final SVG code for the NFT
    // function generateFinalSvg() {}

    // Generate token URI with all the SVG code, to be stored on-chain
    // function tokenURI() {}

    // Mint new Balls of Art
    // function mintBallsOfArt() {}

    // From: https://stackoverflow.com/a/65707309/11969592
    function uint2str(uint _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
