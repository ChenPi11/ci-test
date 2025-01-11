from_str = \
"""const modPath = path.join(constants_1.vsRootPath, "out/server-main.js");"""

to_str = \
"""const os = __importStar(require("os"));
let modPath = path.join(constants_1.vsRootPath, "out/server-main.js");
        if (os.platform() === "win32") {
            // On Windows, absolute paths of ESM modules must be a valid file URI.
            modPath = "file:///" + modPath.replace(/\\/g, "/")
            console.log(modPath);
          }"""

# Walk node_modules recursively.
import os

for root, dirs, files in os.walk("node_modules"):
    for file in files:
        if file.endswith(".js"):
            file_path = os.path.join(root, file)
            with open(file_path, "r") as f:
                contents = f.read()
                if from_str in contents:
                    print(f"Patching {file_path}")
                    contents = contents.replace(from_str, to_str)
                    with open(file_path, "w") as f:
                        f.write(contents)