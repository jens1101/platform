declare global {
  namespace NodeJS {
    interface ProcessEnv {
      PORT: string;
      USER_DATA_FILE: string;
      ISO_MOUNT_PATH: string;
    }
  }
}

// Ensure that this file is considered a module by adding an empty export
// statement.
export {};
