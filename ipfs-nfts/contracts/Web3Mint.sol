// SPDX-License-Identifier: UNICENSED
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./libraries/Base64.sol";
import "hardhat/console.sol";

contract Web3Mint is ERC721URIStorage {
    struct NftAttributes{
        string name;
        string imageURL;
    }

    NftAttributes[] Web3Nfts;

    // // OpenZeppelin が tokenIds を簡単に追跡するために提供するライブラリを呼び出す
    using Counters for Counters.Counter;
    // _tokenIdsを初期化（_tokenIds = 0）
    // tokenIdはNFTの一意な識別子で、0, 1, 2, .. N のように付与される
    Counters.Counter private _tokenIds;

    /* NFT トークンの名前とそのシンボルを渡す */
    constructor() ERC721 ("TanyaNFT", "TANYA") {
        console.log("This is my NFT contract.");
    }

    function mintIpfsNFT(string memory name,string memory imageURI) public{
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender,newItemId);
        Web3Nfts.push(NftAttributes({
            name: name,
            imageURL: imageURI
        }));

        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        _tokenIds.increment();
    }

    function tokenURI(uint256 _tokenId) public override view returns(string memory){
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        Web3Nfts[_tokenId].name,
                        ' -- NFT #: ',
                        Strings.toString(_tokenId),
                        '", "description": "An epic NFT", "image": "ipfs://',
                        Web3Nfts[_tokenId].imageURL,'"}'
                    )
                )
            )
        );
        
        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        return output;
    }

    /* ユーザーが NFT を取得するために実行する関数 */
    // function makeAnEpicNFT() public {
    //     // 現在のtokenIdを取得します。tokenIdは0から始まる。
    //     uint256 newItemId = _tokenIds.current();
    //     // msg.sender を使って NFT を送信者に Mint する。
    //     _safeMint(msg.sender, newItemId);
    //     // NFTデータを設定。
    //     _setTokenURI(newItemId, "https://jsonkeeper.com/b/AW3E");
    //     // NFTがいつ誰に作成されたかを確認
    //     console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    //     // 次の NFT が Mint されるときのカウンターをインクリメントする。
    //     _tokenIds.increment();
    // }
}