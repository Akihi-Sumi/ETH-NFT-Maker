const main = async () => {
  // コントラクトがコンパイル
  // コントラクトを扱うために必要なファイルが `artifacts` ディレクトリの直下に生成されれる。
  const nftContractFactory = await hre.ethers.getContractFactory("Web3Mint");
  // Hardhat がローカルの Ethereum ネットワークを作成。
  const nftContract = await nftContractFactory.deploy();
  // コントラクトが Mint され、ローカルのブロックチェーンにデプロイされるまで待つ。
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);
  // makeAnEpicNFT 関数を呼び出す。NFT が Mint される。
  let txn = await nftContract.makeAnEpicNFT();
  // Minting が仮想マイナーにより、承認されるのを待つ。
  await txn.wait();
  console.log("Minted NFT #1");
  // makeAnEpicNFT 関数をもう一度呼び出します。NFT がまた Mint される。
  txn = await nftContract.makeAnEpicNFT();
  // Minting が仮想マイナーにより、承認されるのを待つ。
  await txn.wait();
  console.log("Minted NFT #2");
};

// エラー処理
const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();