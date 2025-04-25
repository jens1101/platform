declare global {
  namespace NodeJS {
    interface ProcessEnv {
      KERNEL_PATH: string;
      INITRD_PATH: string;
      NETBOOT_IPXE_PATH: string;
    }
  }
}

// Ensure that this file is considered a module by adding an empty export
// statement.
export {};
