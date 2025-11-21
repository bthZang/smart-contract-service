import { ethers } from "ethers";
import fs from "fs";

import { fileURLToPath } from "node:url";
import path from "node:path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
async function main() {
  const provider = new ethers.JsonRpcProvider(process.env.SEPOLIA_RPC);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!, provider);

  const artifactPath = path.join(
    __dirname,
    "../artifacts/contracts/TransactionLogger.sol/TransactionLogger.json"
  );
  const artifact = JSON.parse(fs.readFileSync(artifactPath, "utf8"));

  console.log("Deploying TransactionLogger...");
  const factory = new ethers.ContractFactory(
    artifact.abi,
    artifact.bytecode,
    wallet
  );
  const contract = await factory.deploy();

  await contract.waitForDeployment();

  console.log("Deployed to:", await contract.getAddress());
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
