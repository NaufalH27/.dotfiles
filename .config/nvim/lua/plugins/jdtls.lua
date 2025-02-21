return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local jdtls = require("jdtls")

    local home = os.getenv("HOME")
    local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
    local lombok_path = home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar"
    local plugins_path = jdtls_path .. "/plugins/"
    local launcher_jar = vim.fn.glob(plugins_path .. "org.eclipse.equinox.launcher_*.jar")

    -- Generate a unique workspace per project
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

    local config = {
      cmd = {
        "java",
        "-javaagent:" .. lombok_path,
        "-Xbootclasspath/a:" .. lombok_path,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher_jar,
        "-configuration",
        jdtls_path .. "/config_linux",
        "-data",
        workspace_dir,
      },
      root_dir = require("jdtls.setup").find_root({ "gradlew", "mvnw", ".git" }),
    }

    -- Ensure JDTLS attaches when a Java file is opened
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.java",
      callback = function()
        jdtls.start_or_attach(config)
      end,
    })

    -- Attach JDTLS immediately if a Java file is already open
    jdtls.start_or_attach(config)
  end,
}

