return {
    dependencies = {
        "mason.nvim",
        "nvim-lspconfig",
        "cmp-nvim-lsp",
    },

    "williamboman/mason-lspconfig.nvim",

    config = function()
        vim.diagnostic.config({
            virtual_text = false,
        })
        vim.o.updatetime = 250
        vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
        local autocomplete_capabilities = require("cmp_nvim_lsp").default_capabilities()

        --- Install and setup language servers ---
        require("mason-lspconfig").setup({
            ensure_installed = {
                --- c++ ---
                "clangd",
                --- cmake ---
                "cmake",
                --- python ---
                "pyre",
                --- asm ---
                "asm_lsp",
                --- bash ---
                "bashls",
                --- docker ---
                "docker_compose_language_service",
                --- lua ---
                "lua_ls",
                --- vim-script ---
                "vimls",
            },
        })

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = autocomplete_capabilities,
                })
            end,

            require("lspconfig").clangd.setup({
                capabilities = autocomplete_capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--compile-commands-dir=" .. vim.fn.getcwd(),
                    "--log=error",
                    "--all-scopes-completion",
                    "--query-driver=clang++",
                    "--enable-config",
                    "--fallback-style=file",
                    "--header-insertion=never",
                    "--limit-results=100",
                    "-pch-storage=memory",
                },
                init_options = {
                    memoryLimit = 8192,
                    clangdFileStatus = true,
                    fallbackFlags = {
                        "-stdc++=20",
                    },
                },
            }),
        })

        --- Install formatters and linters ---
        local formatters_linters = {
            -- c++
            "clang-format",
            "cpplint",
            -- cmake
            "cmakelint",
            "gersemi",
            -- python
            "autoflake",
            "black",
            "pylint",
            -- bash
            "beautysh",
            -- docker
            "hadolint",
            -- lua
            "luacheck",
            "stylua",
        }
        vim.schedule(function()
            local registry = require("mason-registry")
            for _, pkg_name in ipairs(formatters_linters) do
                local ok, pkg = pcall(registry.get_package, pkg_name)
                if ok and not pkg:is_installed() then
                    pkg:install()
                end
            end
        end)
    end,
}
