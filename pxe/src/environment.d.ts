declare global {
  namespace NodeJS {
    interface ProcessEnv {}
  }
}

// Ensure that this file is considered a module by adding an empty export
// statement.
export {};
