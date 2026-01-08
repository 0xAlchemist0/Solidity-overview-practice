import hardhatToolboxViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";
import { configVariable, defineConfig } from "hardhat/config";

export default defineConfig({
  plugins: [hardhatToolboxViemPlugin],
  solidity: {
    profiles: {
      default: {
        version: "0.8.28",
      },
      production: {
        version: "0.8.28",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    },
  },
  networks: {
    hardhatMainnet: {
      type: "edr-simulated",
      chainType: "l1",
      forking: {
        // ← Add this
        //get url from alchemy alows u to test on any chain
        url: "https://eth-mainnet.g.alchemy.com/v2/VYLeFMVuLrgLzsVbho9J4v98uA7sAs73",
        enabled: true,
      },
    },
    hardhatOp: {
      type: "edr-simulated",
      chainType: "op",
    },
    mainnet: {
      // ← Add this
      type: "http",
      chainType: "l1",
      url: "https://eth.llamarpc.com", // Alchemy, Infura, etc.
      accounts: [
        configVariable("MAINNET_PRIVATE_KEY"), //
      ],
    },
    sepolia: {
      type: "http",
      chainType: "l1",
      url: configVariable("SEPOLIA_RPC_URL"),
      accounts: [configVariable("SEPOLIA_PRIVATE_KEY")],
    },
  },
});
