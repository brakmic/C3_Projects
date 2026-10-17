import fs from "fs";
import path from "path";

// Workspace file path
const workspaceFilePath = "/workspace/dev.code-workspace";

// Ensure the directory for the workspace file exists
const dirPath = path.dirname(workspaceFilePath);
if (!fs.existsSync(dirPath)) {
  fs.mkdirSync(dirPath, { recursive: true });
}

// Ensure the host scratchpad folder exists so the workspace has no missing folders.
// It is gitignored and only contains local notes.
fs.mkdirSync("/host_workspace/scratchpad", { recursive: true });

// Define the workspace configuration
const workspaceConfig = {
  folders: [
    {
      name: "DevContainer Workspace",
      path: "/workspace"
    },
    {
      name: "Host Workspace",
      path: "/host_workspace"
    },
    {
      name: "Projects",
      path: "/host_workspace/projects"
    },
    {
      name: "Scratchpad",
      path: "/host_workspace/scratchpad"
    }
  ],
  settings: {
    "files.eol": "\n",
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,
    "search.exclude": {
      "**/*.wasm": true,
      "**/*.wat": true
    },
    "terminal.integrated.defaultProfile.linux": "bash"
  },
  extensions: {
    recommendations: ["c3.vscode-c3"]
  }
};

// Write the workspace file only when its content changes.
const workspaceJson = JSON.stringify(workspaceConfig, null, 2);
const previousJson = fs.existsSync(workspaceFilePath)
  ? fs.readFileSync(workspaceFilePath, "utf8")
  : "";

if (previousJson === workspaceJson) {
  console.log(`Workspace file unchanged: ${workspaceFilePath}`);
} else {
  fs.writeFileSync(workspaceFilePath, workspaceJson);
  console.log(`Workspace file created: ${workspaceFilePath}`);
}
