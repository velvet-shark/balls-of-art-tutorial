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
    struct Ball {
        uint x; // x coordinates of the top left corner
        uint y; // y coordinates of the top left corner
        uint width;
        uint height;
        string fill; // ball color
        uint randomSeed;
    }

    // Constants, prublic variables
    uint constant maxSupply = 111; // max number of tokens
    uint public totalSupply = 0; // number of tokens minted
    uint public mintPrice = 0.001 ether;

    // Mapping to store SVG code for each token
    mapping(uint => string) private tokenIdToSvg;

    // Events
    event BallsCreated(uint indexed tokenId);

    constructor() ERC721("Balls of Art", "BART") {}

    // Functions

    // Return a random background color
    function backgroundColors(uint index)
        internal
        pure
        returns (string memory)
    {
        string[7] memory bgColors = [
            "#ffffff",
            "#F1F1F1",
            "#EEF6FF",
            "#FCF8E8",
            "#EEF1FF",
            "#FFFDE3",
            "#2C3639"
        ];
        return bgColors[index];
    }

    // Return a random ball color
    function ballColors(uint index) internal pure returns (string memory) {
        string[33] memory bColors = [
            "#1eafed",
            "#25316D",
            "#325fa3",
            "#367E18",
            "#38e27d",
            "#400D51",
            "#5d67c1",
            "#7294d4",
            "#A1C298",
            "#CC3636",
            "#F07DEA",
            "#F637EC",
            "#FA7070",
            "#a74f6c",
            "#c2c2d0",
            "#cc0e74",
            "#e5c37a",
            "#e6a0c4",
            "#e8185d",
            "#4bbe9d",
            "#fb97b3",
            "#ff0000",
            "#000007",
            "#2A0944",
            "#3330E4",
            "#5bbcd6",
            "#74275c",
            "#8758FF",
            "#96ac92",
            "#9c65ca",
            "#D800A6",
            "#F57328",
            "#FECD70"
        ];
        return bColors[index];
    }

    // Create an instance of a Ball
    function createBallStruct(
        uint x,
        uint y,
        uint width,
        uint height,
        uint randomSeed
    ) internal pure returns (Ball memory) {
        return
            Ball({
                x: x,
                y: y,
                width: width,
                height: height,
                fill: ballColors(randomSeed % 33), // Choose random color from bColors array
                randomSeed: randomSeed
            });
    }

    // Randomly picka a ball size: 1, 2, or 3x
    function drawBallSize(uint maxSize, uint randomSeed)
        public
        pure
        returns (uint size)
    {
        // Random number 1-100
        uint r = (randomSeed % 100) + 1;

        // Probabilities:
        // 3x: 20%
        // 2x: 25%
        // else: 1x
        if (maxSize == 3) {
            if (r <= 20) {
                return 3;
            } else if (r <= 45) {
                return 2;
            } else {
                return 1;
            }
        } else {
            // Probabilities:
            // 2x: 30%
            // else: 1x
            if (r <= 30) {
                return 2;
            } else {
                return 1;
            }
        }
    }

    // SVG code for a single ball
    function ballSvg(Ball memory ball) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    '<rect x="',
                    uint2str(ball.x),
                    '" y="',
                    uint2str(ball.y),
                    '" width="',
                    uint2str(ball.width),
                    '" height="',
                    uint2str(ball.height),
                    '" fill="',
                    ball.fill,
                    '" rx="150" /> <path fill="none" stroke="#ffffff" stroke-width="20" stroke-linecap="round" d="M ',
                    uint2str(ball.x + ball.width - 150),
                    " ",
                    uint2str(ball.y + ball.height - 50),
                    " A 100 100 0 0 0 ",
                    uint2str(ball.x + ball.width - 50),
                    " ",
                    uint2str(ball.y + ball.height - 150),
                    '" />'
                )
            );
    }

    // SVG code for a single line
    function generateLineSvg(uint lineNumber, uint randomSeed)
        public
        view
        returns (string memory)
    {
        // Line SVG
        string memory lineSvg = "";

        uint y = 150; // Default y for row 1
        if (lineNumber == 2) {
            y = 475; // Default y for row 2
        } else if (lineNumber == 3) {
            y = 800; // Default y for row 3
        }

        // Size of ball at slot 1
        uint ballSize1 = drawBallSize(3, randomSeed);
        console.log("Ball size 1: ", ballSize1);

        // Ball size 1x? Paint 1x at slot 1
        if (ballSize1 == 1) {
            Ball memory ball1 = createBallStruct(150, y, 300, 300, randomSeed);
            lineSvg = string.concat(lineSvg, ballSvg(ball1));

            // Slot 2
            // Size of ball at slot 2
            uint ballSize2 = drawBallSize(2, randomSeed >> 1);
            console.log("Ball size 2: ", ballSize2);

            // Ball size 1x? Paint 1x at slot 2 and 1x at slot 3
            if (ballSize2 == 1) {
                Ball memory ball2 = createBallStruct(
                    475,
                    y,
                    300,
                    300,
                    randomSeed >> 2
                );
                Ball memory ball3 = createBallStruct(
                    800,
                    y,
                    300,
                    300,
                    randomSeed >> 3
                );
                lineSvg = string.concat(
                    lineSvg,
                    ballSvg(ball2),
                    ballSvg(ball3)
                );

                // Ball size 2x? Paint 2x at slot 2
            } else if (ballSize2 == 2) {
                Ball memory ball2 = createBallStruct(
                    475,
                    y,
                    625,
                    300,
                    randomSeed >> 4
                );
                lineSvg = string.concat(lineSvg, ballSvg(ball2));
            }

            // Ball size 2x? Paint 2x at slot 1 and 1x at slot 3
        } else if (ballSize1 == 2) {
            Ball memory ball1 = createBallStruct(
                150,
                y,
                625,
                300,
                randomSeed >> 5
            );
            Ball memory ball3 = createBallStruct(
                800,
                y,
                300,
                300,
                randomSeed >> 6
            );
            lineSvg = string.concat(lineSvg, ballSvg(ball1), ballSvg(ball3));

            // Ball size 3x? Paint 3x at slot 1
        } else if (ballSize1 == 3) {
            Ball memory ball1 = createBallStruct(
                150,
                y,
                950,
                300,
                randomSeed >> 7
            );
            lineSvg = string.concat(lineSvg, ballSvg(ball1));
        }

        return lineSvg;
    }

    // Draw animated eyes
    function drawEyes(uint eyesLocation) internal pure returns (string memory) {
        // Bottom-right location by default
        uint y1 = 930;
        uint y2 = 980;

        if (eyesLocation == 1) {
            y1 = 280;
            y2 = 330;
        } else if (eyesLocation == 2) {
            y1 = 605;
            y2 = 655;
        } // Location 3 skipped because it's set up as default already, and only changed if location is 1 or 2

        return
            string(
                abi.encodePacked(
                    '<rect x="980" y="',
                    uint2str(y1),
                    '" width="30" height="30" fill="#ffffff" rx="15"><animate attributeType="XML" attributeName="fill" values="#ffffff00;#ffffff00;#ffffff00;#ffffff00;#ffffff00;#ffffff;#ffffff00;#ffffff00;#ffffff00;#ffffff00;" dur="10s" repeatCount="indefinite"/></rect><rect x="930" y="',
                    uint2str(y2),
                    '" width="30" height="30" fill="#ffffff" rx="15"><animate attributeType="XML" attributeName="fill" values="#ffffff00;#ffffff00;#ffffff00;#ffffff00;#ffffff00;#ffffff;#ffffff00;#ffffff00;#ffffff00;#ffffff00;" dur="10s" repeatCount="indefinite"/></rect>'
                )
            );
    }

    // Final SVG code for the NFT
    function generateFinalSvg(
        uint randomSeed1,
        uint randomSeed2,
        uint randomSeed3
    ) public view returns (string memory) {
        bytes memory backgroundCode = abi.encodePacked(
            '<rect width="1250" height="1250" fill="',
            backgroundColors(randomSeed1 % 7),
            '" />'
        );

        // Which line will contain the eyes
        uint eyesLocation = (randomSeed1 % 3) + 1;

        // SVG opening and closing tags, background color + 3 lines generated
        string memory finalSvg = string(
            abi.encodePacked(
                '<svg viewBox="0 0 1250 1250" xmlns="http://www.w3.org/2000/svg">',
                backgroundCode,
                generateLineSvg(1, randomSeed1),
                generateLineSvg(2, randomSeed2),
                generateLineSvg(3, randomSeed3),
                drawEyes(eyesLocation),
                "</svg>"
            )
        );

        console.log("Final Svg: ", string(finalSvg));
        return finalSvg;
    }

    // Generate token URI with all the SVG code, to be stored on-chain
    function tokenURI(uint tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(_exists(tokenId));

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "Balls of Art #',
                                uint2str(tokenId),
                                '", "description": "Balls of Art are an assortment of 111 fully on-chain, randomly generated, happy art balls", "attributes": "", "image":"data:image/svg+xml;base64,',
                                Base64.encode(bytes(tokenIdToSvg[tokenId])),
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    // Mint new Balls of Art
    function mintBallsOfArt(uint tokenId) public payable {
        // Require token ID to be between 1 and maxSupply (111)
        require(tokenId > 0 && tokenId <= maxSupply, "Token ID invalid");

        // Make sure the amount of ETH is equal or larger than the minimum mint price
        require(msg.value >= mintPrice, "Not enough ETH sent");

        uint randomSeed1 = uint(
            keccak256(abi.encodePacked(block.basefee, block.timestamp))
        );
        uint randomSeed2 = uint(
            keccak256(abi.encodePacked(block.timestamp, msg.sender))
        );
        uint randomSeed3 = uint(
            keccak256(abi.encodePacked(msg.sender, block.timestamp))
        );

        tokenIdToSvg[tokenId] = generateFinalSvg(
            randomSeed1,
            randomSeed2,
            randomSeed3
        );

        // Mint token
        _mint(msg.sender, tokenId);

        // Increase minted tokens counter
        ++totalSupply;

        emit BallsCreated(tokenId);
    }

    // Withdraw funds from the contract
    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

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
